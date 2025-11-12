#!/bin/bash

# Script de Configuração Completa do Nginx para StepCounter
# Suporta Linux e WSL (Windows Subsystem for Linux)
# Autor: StepCounter Project
# Versão: 1.0

set -e  # Parar em caso de erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Diretórios do projeto
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONFIG_DIR="$PROJECT_DIR/configs/nginx"
DIST_DIR="$PROJECT_DIR/dist"

# Log file
LOG_FILE="$PROJECT_DIR/nginx-setup.log"

# Função de log
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERRO]${NC} $1" | tee -a "$LOG_FILE"
    exit 1
}

warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

# Verificar se está rodando como root (para algumas operações)
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        warning "Algumas operações requerem sudo. Você pode ser solicitado a inserir sua senha."
    fi
}

# Detectar se está no WSL
detect_wsl() {
    if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
        IS_WSL=true
        log "WSL detectado (Windows Subsystem for Linux)"
    else
        IS_WSL=false
        log "Linux nativo detectado"
    fi
}

# Verificar se Nginx está instalado
check_nginx() {
    log "Verificando se Nginx está instalado..."
    if command -v nginx &> /dev/null; then
        NGINX_VERSION=$(nginx -v 2>&1 | cut -d'/' -f2)
        log "Nginx encontrado: versão $NGINX_VERSION"
        return 0
    else
        error "Nginx não está instalado. Instale com: sudo apt-get install nginx (Ubuntu/Debian) ou brew install nginx (macOS)"
    fi
}

# Verificar se Node.js está instalado
check_node() {
    log "Verificando se Node.js está instalado..."
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node -v)
        log "Node.js encontrado: $NODE_VERSION"
        return 0
    else
        error "Node.js não está instalado. Instale Node.js primeiro."
    fi
}

# Verificar se npm está instalado
check_npm() {
    log "Verificando se npm está instalado..."
    if command -v npm &> /dev/null; then
        NPM_VERSION=$(npm -v)
        log "npm encontrado: versão $NPM_VERSION"
        return 0
    else
        error "npm não está instalado. Instale npm primeiro."
    fi
}

# Verificar se a pasta dist existe
check_dist() {
    log "Verificando se a pasta dist existe..."
    if [ ! -d "$DIST_DIR" ]; then
        warning "Pasta dist não encontrada. Fazendo build do projeto..."
        build_project
    else
        log "Pasta dist encontrada: $DIST_DIR"
        if [ ! -f "$DIST_DIR/index.html" ]; then
            warning "index.html não encontrado em dist. Fazendo build..."
            build_project
        fi
    fi
}

# Fazer build do projeto
build_project() {
    log "Fazendo build do projeto..."
    cd "$PROJECT_DIR"
    
    # Verificar se node_modules existe
    if [ ! -d "node_modules" ]; then
        warning "node_modules não encontrado. Instalando dependências..."
        npm install --legacy-peer-deps
    fi
    
    # Fazer build
    npm run build
    
    if [ $? -eq 0 ]; then
        log "Build concluído com sucesso"
    else
        error "Erro ao fazer build do projeto"
    fi
}

# Configurar Nginx para Linux
setup_nginx_linux() {
    log "Configurando Nginx para Linux..."
    
    # Diretórios do Nginx (macOS via Homebrew)
    NGINX_CONF_DIR="/usr/local/etc/nginx"
    NGINX_SERVERS_DIR="$NGINX_CONF_DIR/servers"
    NGINX_LOG_DIR="/usr/local/var/log/nginx"
    
    # Verificar se é Linux padrão (não macOS)
    if [ -d "/etc/nginx" ]; then
        NGINX_CONF_DIR="/etc/nginx"
        NGINX_SERVERS_DIR="/etc/nginx/sites-available"
        NGINX_ENABLED_DIR="/etc/nginx/sites-enabled"
        NGINX_LOG_DIR="/var/log/nginx"
    fi
    
    # Criar diretórios
    log "Criando diretórios de configuração..."
    sudo mkdir -p "$NGINX_SERVERS_DIR" 2>/dev/null || sudo mkdir -p "$NGINX_ENABLED_DIR" 2>/dev/null
    sudo mkdir -p "$NGINX_LOG_DIR"
    
    # Copiar configuração
    if [ "$IS_WSL" = true ]; then
        CONFIG_FILE="$CONFIG_DIR/nginx-stepcounter-wsl.conf"
        log "Usando configuração para WSL"
    else
        CONFIG_FILE="$CONFIG_DIR/nginx-stepcounter.conf"
        log "Usando configuração para Linux"
    fi
    
    if [ ! -f "$CONFIG_FILE" ]; then
        error "Arquivo de configuração não encontrado: $CONFIG_FILE"
    fi
    
    # Ajustar caminho no arquivo de configuração
    log "Ajustando caminhos no arquivo de configuração..."
    TEMP_CONFIG=$(mktemp)
    sed "s|/Users/Lucas/Downloads/StepCounter-main/dist|$DIST_DIR|g" "$CONFIG_FILE" > "$TEMP_CONFIG"
    
    # Copiar para localização do Nginx
    if [ -d "/etc/nginx/sites-available" ]; then
        # Linux padrão
        sudo cp "$TEMP_CONFIG" "/etc/nginx/sites-available/stepcounter.conf"
        sudo ln -sf "/etc/nginx/sites-available/stepcounter.conf" "/etc/nginx/sites-enabled/stepcounter.conf"
        log "Configuração copiada para /etc/nginx/sites-available/stepcounter.conf"
        
        # Verificar se nginx.conf inclui sites-enabled
        if ! grep -q "sites-enabled" /etc/nginx/nginx.conf 2>/dev/null; then
            log "Adicionando include de sites-enabled no nginx.conf..."
            sudo sed -i '/http {/a\    include /etc/nginx/sites-enabled/*;' /etc/nginx/nginx.conf
        fi
    else
        # macOS ou outra configuração
        sudo cp "$TEMP_CONFIG" "$NGINX_SERVERS_DIR/stepcounter.conf"
        log "Configuração copiada para $NGINX_SERVERS_DIR/stepcounter.conf"
    fi
    
    rm "$TEMP_CONFIG"
    
    # Ajustar permissões
    if [ -f "$NGINX_SERVERS_DIR/stepcounter.conf" ]; then
        sudo chown $(whoami) "$NGINX_SERVERS_DIR/stepcounter.conf" 2>/dev/null || true
    elif [ -f "/etc/nginx/sites-available/stepcounter.conf" ]; then
        sudo chown root:root "/etc/nginx/sites-available/stepcounter.conf"
        sudo chmod 644 "/etc/nginx/sites-available/stepcounter.conf"
    fi
}

# Configurar Nginx para WSL
setup_nginx_wsl() {
    log "Configurando Nginx para WSL..."
    
    NGINX_CONF_DIR="/etc/nginx"
    NGINX_SERVERS_DIR="/etc/nginx/sites-available"
    NGINX_ENABLED_DIR="/etc/nginx/sites-enabled"
    NGINX_LOG_DIR="/var/log/nginx"
    
    # Criar diretórios
    log "Criando diretórios de configuração..."
    sudo mkdir -p "$NGINX_SERVERS_DIR"
    sudo mkdir -p "$NGINX_ENABLED_DIR"
    sudo mkdir -p "$NGINX_LOG_DIR"
    
    # Copiar configuração
    CONFIG_FILE="$CONFIG_DIR/nginx-stepcounter-wsl.conf"
    
    if [ ! -f "$CONFIG_FILE" ]; then
        error "Arquivo de configuração não encontrado: $CONFIG_FILE"
    fi
    
    # Ajustar caminho no arquivo de configuração
    log "Ajustando caminhos no arquivo de configuração..."
    TEMP_CONFIG=$(mktemp)
    sed "s|/mnt/c/Users/SeuUsuario/Downloads/StepCounter-main/dist|$DIST_DIR|g" "$CONFIG_FILE" > "$TEMP_CONFIG"
    
    # Copiar para localização do Nginx
    sudo cp "$TEMP_CONFIG" "$NGINX_SERVERS_DIR/stepcounter.conf"
    sudo ln -sf "$NGINX_SERVERS_DIR/stepcounter.conf" "$NGINX_ENABLED_DIR/stepcounter.conf"
    log "Configuração copiada para $NGINX_SERVERS_DIR/stepcounter.conf"
    
    rm "$TEMP_CONFIG"
    
    # Verificar se nginx.conf inclui sites-enabled
    if ! grep -q "sites-enabled" /etc/nginx/nginx.conf; then
        log "Adicionando include de sites-enabled no nginx.conf..."
        sudo sed -i '/http {/a\    include /etc/nginx/sites-enabled/*;' /etc/nginx/nginx.conf
    fi
    
    # Ajustar permissões
    sudo chown root:root "$NGINX_SERVERS_DIR/stepcounter.conf"
    sudo chmod 644 "$NGINX_SERVERS_DIR/stepcounter.conf"
}

# Verificar configuração do Nginx
test_nginx_config() {
    log "Testando configuração do Nginx..."
    if sudo nginx -t 2>&1 | tee -a "$LOG_FILE"; then
        log "Configuração do Nginx está correta"
        return 0
    else
        error "Erro na configuração do Nginx. Verifique os logs."
    fi
}

# Iniciar/Reiniciar Nginx
restart_nginx() {
    log "Reiniciando Nginx..."
    
    if pgrep -x nginx > /dev/null; then
        log "Nginx está rodando. Recarregando configuração..."
        if sudo nginx -s reload 2>&1 | tee -a "$LOG_FILE"; then
            log "Nginx recarregado com sucesso"
        else
            error "Erro ao recarregar Nginx"
        fi
    else
        log "Nginx não está rodando. Iniciando..."
        if [ "$IS_WSL" = true ]; then
            if sudo service nginx start 2>&1 | tee -a "$LOG_FILE"; then
                log "Nginx iniciado com sucesso"
            else
                if sudo nginx 2>&1 | tee -a "$LOG_FILE"; then
                    log "Nginx iniciado com sucesso"
                else
                    error "Erro ao iniciar Nginx"
                fi
            fi
        else
            if sudo nginx 2>&1 | tee -a "$LOG_FILE"; then
                log "Nginx iniciado com sucesso"
            else
                error "Erro ao iniciar Nginx"
            fi
        fi
    fi
}

# Obter IP da máquina
get_ip() {
    log "Obtendo IP da máquina..."
    
    if [ "$IS_WSL" = true ]; then
        # No WSL, precisamos do IP do Windows Host
        WINDOWS_IP=$(ip route show | grep -i default | awk '{print $3}' | head -1)
        if [ -n "$WINDOWS_IP" ]; then
            info "IP do Windows Host: $WINDOWS_IP"
            info "Para obter o IP real do Windows, execute no PowerShell: ipconfig"
        fi
    else
        # Linux/macOS
        IP=$(ifconfig 2>/dev/null | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)
        if [ -n "$IP" ]; then
            info "IP da máquina: $IP"
        else
            IP=$(hostname -I 2>/dev/null | awk '{print $1}')
            if [ -n "$IP" ]; then
                info "IP da máquina: $IP"
            fi
        fi
    fi
}

# Mostrar informações finais
show_final_info() {
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}✅ Configuração do Nginx concluída com sucesso!${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${BLUE}📋 Informações:${NC}"
    echo "   - Projeto: $PROJECT_DIR"
    echo "   - Build: $DIST_DIR"
    echo "   - Log: $LOG_FILE"
    echo ""
    echo -e "${BLUE}🌐 Aplicação disponível em:${NC}"
    echo "   - Local: http://localhost"
    if [ -n "$IP" ]; then
        echo "   - Rede: http://$IP"
    fi
    echo ""
    if [ "$IS_WSL" = true ]; then
        echo -e "${YELLOW}⚠️  IMPORTANTE para Windows/WSL:${NC}"
        echo "   1. Obtenha o IP do Windows (não do WSL):"
        echo "      - No PowerShell: ipconfig"
        echo "      - Use o IP da placa Wi-Fi/Ethernet"
        echo "   2. Configure o firewall do Windows para permitir a porta 80"
        echo "   3. Acesse de outros dispositivos: http://[IP_DO_WINDOWS]"
    else
        echo -e "${BLUE}📱 Para acessar de outros dispositivos:${NC}"
        echo "   1. Certifique-se de estar na mesma rede Wi-Fi"
        echo "   2. Configure o firewall se necessário"
        echo "   3. Acesse: http://$IP"
    fi
    echo ""
    echo -e "${BLUE}📝 Comandos úteis:${NC}"
    echo "   - Ver logs: tail -f $LOG_FILE"
    echo "   - Reiniciar Nginx: sudo nginx -s reload"
    echo "   - Ver status: sudo nginx -t"
    echo ""
}

# Função principal
main() {
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}🚀 Configuração Completa do Nginx para StepCounter${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Limpar log anterior
    > "$LOG_FILE"
    
    # Verificações
    check_sudo
    detect_wsl
    check_nginx
    check_node
    check_npm
    check_dist
    
    # Configuração
    if [ "$IS_WSL" = true ]; then
        setup_nginx_wsl
    else
        setup_nginx_linux
    fi
    
    # Testar e reiniciar
    test_nginx_config
    restart_nginx
    
    # Obter IP e mostrar informações
    get_ip
    show_final_info
    
    log "Configuração concluída com sucesso!"
}

# Executar função principal
main "$@"

