#!/bin/bash

# Script de Inicialização Completa do Projeto StepCounter
# Verifica todos os serviços, arquivos e configurações
# Suporta Linux e WSL (Windows Subsystem for Linux)
# Autor: StepCounter Project
# Versão: 1.0

set -e  # Parar em caso de erro crítico

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Diretórios do projeto
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR"
LOG_FILE="$PROJECT_DIR/project-startup.log"

# Contadores
ERRORS=0
WARNINGS=0
SUCCESS=0

# Função de log
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1" | tee -a "$LOG_FILE"
    ((SUCCESS++))
}

log_warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1" | tee -a "$LOG_FILE"
    ((WARNINGS++))
}

log_error() {
    echo -e "${RED}[ERRO]${NC} $1" | tee -a "$LOG_FILE"
    ((ERRORS++))
}

log_section() {
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Limpar log anterior
> "$LOG_FILE"

# Banner
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}🚀 Inicialização Completa do Projeto StepCounter${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

log_info "Diretório do projeto: $PROJECT_DIR"
log_info "Arquivo de log: $LOG_FILE"
log_info "Data/Hora: $(date)"
echo ""

# ============================================================================
# 1. VERIFICAÇÕES DE SISTEMA
# ============================================================================
log_section "1. VERIFICAÇÕES DE SISTEMA"

# Detectar WSL
IS_WSL=false
if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
    IS_WSL=true
    log_success "WSL detectado (Windows Subsystem for Linux)"
else
    log_success "Linux nativo detectado"
fi

# Verificar Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    log_success "Node.js instalado: $NODE_VERSION"
else
    log_error "Node.js não está instalado"
fi

# Verificar npm
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm -v)
    log_success "npm instalado: versão $NPM_VERSION"
else
    log_error "npm não está instalado"
fi

# Verificar Nginx
if command -v nginx &> /dev/null; then
    NGINX_VERSION=$(nginx -v 2>&1 | cut -d'/' -f2)
    log_success "Nginx instalado: versão $NGINX_VERSION"
else
    log_warning "Nginx não está instalado (necessário para servir na rede)"
fi

# ============================================================================
# 2. VERIFICAÇÕES DE ESTRUTURA DE PASTAS
# ============================================================================
log_section "2. VERIFICAÇÕES DE ESTRUTURA DE PASTAS"

# Verificar estrutura de pastas
REQUIRED_DIRS=(
    "src"
    "src/react-app"
    "src/react-app/components"
    "src/react-app/pages"
    "manuais"
    "manuais/instalacao"
    "manuais/nginx"
    "manuais/git"
    "manuais/geral"
    "scripts"
    "scripts/setup"
    "scripts/nginx"
    "scripts/git"
    "configs"
    "configs/nginx"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$PROJECT_DIR/$dir" ]; then
        log_success "Pasta encontrada: $dir"
    else
        log_error "Pasta não encontrada: $dir"
    fi
done

# ============================================================================
# 3. VERIFICAÇÕES DE ARQUIVOS ESSENCIAIS
# ============================================================================
log_section "3. VERIFICAÇÕES DE ARQUIVOS ESSENCIAIS"

# Arquivos de configuração
REQUIRED_FILES=(
    "package.json"
    "vite.config.ts"
    "tsconfig.json"
    "tailwind.config.js"
    "index.html"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$PROJECT_DIR/$file" ]; then
        log_success "Arquivo encontrado: $file"
    else
        log_error "Arquivo não encontrado: $file"
    fi
done

# Arquivos de código fonte
REQUIRED_SRC_FILES=(
    "src/react-app/main.tsx"
    "src/react-app/App.tsx"
    "src/react-app/components/StepCounter.tsx"
    "src/react-app/pages/Home.tsx"
)

for file in "${REQUIRED_SRC_FILES[@]}"; do
    if [ -f "$PROJECT_DIR/$file" ]; then
        log_success "Arquivo encontrado: $file"
    else
        log_error "Arquivo não encontrado: $file"
    fi
done

# ============================================================================
# 4. VERIFICAÇÕES DE CONFIGURAÇÕES
# ============================================================================
log_section "4. VERIFICAÇÕES DE CONFIGURAÇÕES NGINX"

# Verificar arquivos de configuração do Nginx
if [ -f "$PROJECT_DIR/configs/nginx/nginx-stepcounter.conf" ]; then
    log_success "Configuração do Nginx (Linux) encontrada"
else
    log_warning "Configuração do Nginx (Linux) não encontrada"
fi

if [ -f "$PROJECT_DIR/configs/nginx/nginx-stepcounter-wsl.conf" ]; then
    log_success "Configuração do Nginx (WSL) encontrada"
else
    log_warning "Configuração do Nginx (WSL) não encontrada"
fi

# Verificar se Nginx está configurado no sistema
if command -v nginx &> /dev/null; then
    if [ "$IS_WSL" = true ]; then
        if [ -f "/etc/nginx/sites-available/stepcounter.conf" ] || [ -f "/etc/nginx/sites-enabled/stepcounter.conf" ]; then
            log_success "Nginx configurado no sistema (WSL)"
        else
            log_warning "Nginx não está configurado no sistema (WSL)"
        fi
    else
        if [ -f "/usr/local/etc/nginx/servers/stepcounter.conf" ] || [ -f "/etc/nginx/sites-available/stepcounter.conf" ]; then
            log_success "Nginx configurado no sistema"
        else
            log_warning "Nginx não está configurado no sistema"
        fi
    fi
fi

# ============================================================================
# 5. VERIFICAÇÕES DE DEPENDÊNCIAS
# ============================================================================
log_section "5. VERIFICAÇÕES DE DEPENDÊNCIAS"

# Verificar node_modules
if [ -d "$PROJECT_DIR/node_modules" ]; then
    log_success "node_modules encontrado"
    
    # Verificar se há arquivos em node_modules
    if [ "$(ls -A $PROJECT_DIR/node_modules 2>/dev/null)" ]; then
        log_success "node_modules não está vazio"
    else
        log_error "node_modules está vazio"
    fi
else
    log_error "node_modules não encontrado"
    log_warning "Execute: npm install --legacy-peer-deps"
fi

# Verificar package-lock.json
if [ -f "$PROJECT_DIR/package-lock.json" ]; then
    log_success "package-lock.json encontrado"
else
    log_warning "package-lock.json não encontrado"
fi

# ============================================================================
# 6. VERIFICAÇÕES DE BUILD
# ============================================================================
log_section "6. VERIFICAÇÕES DE BUILD"

# Verificar pasta dist
if [ -d "$PROJECT_DIR/dist" ]; then
    log_success "Pasta dist encontrada"
    
    # Verificar index.html em dist
    if [ -f "$PROJECT_DIR/dist/index.html" ]; then
        log_success "index.html encontrado em dist"
    else
        log_error "index.html não encontrado em dist"
    fi
    
    # Verificar pasta assets
    if [ -d "$PROJECT_DIR/dist/assets" ]; then
        log_success "Pasta assets encontrada em dist"
        
        # Verificar se há arquivos em assets
        if [ "$(ls -A $PROJECT_DIR/dist/assets 2>/dev/null)" ]; then
            log_success "Pasta assets não está vazia"
        else
            log_warning "Pasta assets está vazia"
        fi
    else
        log_warning "Pasta assets não encontrada em dist"
    fi
else
    log_error "Pasta dist não encontrada"
    log_warning "Execute: npm run build"
fi

# ============================================================================
# 7. VERIFICAÇÕES DE SERVIÇOS
# ============================================================================
log_section "7. VERIFICAÇÕES DE SERVIÇOS"

# Verificar se Nginx está rodando
if command -v nginx &> /dev/null; then
    if pgrep -x nginx > /dev/null; then
        log_success "Nginx está rodando"
        
        # Verificar se está escutando na porta 80
        if sudo netstat -tlnp 2>/dev/null | grep -q ":80 " || sudo ss -tlnp 2>/dev/null | grep -q ":80 "; then
            log_success "Nginx está escutando na porta 80"
        else
            log_warning "Nginx não está escutando na porta 80"
        fi
    else
        log_warning "Nginx não está rodando"
        log_warning "Execute: sudo nginx (ou sudo service nginx start no WSL)"
    fi
    
    # Verificar configuração do Nginx
    if sudo nginx -t 2>&1 | grep -q "syntax is ok"; then
        log_success "Configuração do Nginx está válida"
    else
        log_error "Configuração do Nginx tem erros"
        log_warning "Execute: sudo nginx -t para ver os erros"
    fi
else
    log_warning "Nginx não está instalado"
fi

# ============================================================================
# 8. VERIFICAÇÕES DE REDE
# ============================================================================
log_section "8. VERIFICAÇÕES DE REDE"

# Obter IP da máquina
if [ "$IS_WSL" = true ]; then
    WINDOWS_IP=$(ip route show | grep -i default | awk '{print $3}' | head -1)
    if [ -n "$WINDOWS_IP" ]; then
        log_info "IP do Windows Host (gateway): $WINDOWS_IP"
        log_warning "Para obter o IP real do Windows, execute no PowerShell: ipconfig"
    fi
else
    IP=$(ifconfig 2>/dev/null | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)
    if [ -z "$IP" ]; then
        IP=$(hostname -I 2>/dev/null | awk '{print $1}')
    fi
    if [ -n "$IP" ]; then
        log_success "IP da máquina: $IP"
        log_info "Aplicação disponível em: http://$IP"
    else
        log_warning "Não foi possível obter o IP da máquina"
    fi
fi

# ============================================================================
# 9. VERIFICAÇÕES DE SCRIPTS
# ============================================================================
log_section "9. VERIFICAÇÕES DE SCRIPTS"

# Verificar scripts principais
REQUIRED_SCRIPTS=(
    "scripts/nginx/configure-nginx.sh"
    "scripts/setup/install.sh"
)

for script in "${REQUIRED_SCRIPTS[@]}"; do
    if [ -f "$PROJECT_DIR/$script" ]; then
        if [ -x "$PROJECT_DIR/$script" ]; then
            log_success "Script encontrado e executável: $script"
        else
            log_warning "Script encontrado mas não executável: $script"
            log_warning "Execute: chmod +x $script"
        fi
    else
        log_warning "Script não encontrado: $script"
    fi
done

# ============================================================================
# 10. VERIFICAÇÕES DE MANUAIS
# ============================================================================
log_section "10. VERIFICAÇÕES DE MANUAIS"

# Verificar manuais principais
REQUIRED_MANUALS=(
    "README.md"
    "manuais/instalacao/INSTALACAO_RAPIDA.md"
    "manuais/nginx/NGINX_SETUP.md"
)

for manual in "${REQUIRED_MANUALS[@]}"; do
    if [ -f "$PROJECT_DIR/$manual" ]; then
        log_success "Manual encontrado: $manual"
    else
        log_warning "Manual não encontrado: $manual"
    fi
done

# ============================================================================
# RESUMO FINAL
# ============================================================================
log_section "RESUMO FINAL"

echo -e "${CYAN}Estatísticas:${NC}"
echo "   ✅ Sucessos: $SUCCESS"
echo "   ⚠️  Avisos: $WARNINGS"
echo "   ❌ Erros: $ERRORS"
echo ""

if [ $ERRORS -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}✅ Tudo está configurado corretamente!${NC}"
        echo ""
        echo -e "${BLUE}🌐 Aplicação disponível em:${NC}"
        echo "   - Local: http://localhost"
        if [ -n "$IP" ] && [ "$IS_WSL" = false ]; then
            echo "   - Rede: http://$IP"
        fi
        echo ""
        
        if [ "$IS_WSL" = true ]; then
            echo -e "${YELLOW}⚠️  Para Windows/WSL:${NC}"
            echo "   1. Obtenha o IP do Windows: ipconfig (PowerShell)"
            echo "   2. Configure o firewall do Windows"
            echo "   3. Acesse: http://[IP_DO_WINDOWS]"
            echo ""
        fi
    else
        echo -e "${YELLOW}⚠️  Há $WARNINGS avisos. Verifique o log acima.${NC}"
        echo ""
        echo -e "${BLUE}💡 Próximos passos:${NC}"
        
        if [ ! -d "$PROJECT_DIR/node_modules" ]; then
            echo "   1. Instale as dependências: npm install --legacy-peer-deps"
        fi
        
        if [ ! -d "$PROJECT_DIR/dist" ]; then
            echo "   2. Faça o build: npm run build"
        fi
        
        if ! pgrep -x nginx > /dev/null && command -v nginx &> /dev/null; then
            echo "   3. Configure o Nginx: ./scripts/nginx/configure-nginx.sh"
        fi
        
        echo ""
    fi
else
    echo -e "${RED}❌ Há $ERRORS erros que precisam ser corrigidos!${NC}"
    echo ""
    echo -e "${BLUE}💡 Ações necessárias:${NC}"
    
    if ! command -v node &> /dev/null; then
        echo "   1. Instale Node.js: https://nodejs.org/"
    fi
    
    if ! command -v npm &> /dev/null; then
        echo "   2. Instale npm (geralmente vem com Node.js)"
    fi
    
    if [ ! -d "$PROJECT_DIR/node_modules" ]; then
        echo "   3. Instale as dependências: npm install --legacy-peer-deps"
    fi
    
    if [ ! -d "$PROJECT_DIR/dist" ]; then
        echo "   4. Faça o build: npm run build"
    fi
    
    echo ""
    echo -e "${YELLOW}Consulte o log completo em: $LOG_FILE${NC}"
    echo ""
    exit 1
fi

# ============================================================================
# INFORMAÇÕES ADICIONAIS
# ============================================================================
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}📋 Informações Adicionais${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo "   📁 Projeto: $PROJECT_DIR"
echo "   📝 Log: $LOG_FILE"
echo "   🕐 Data/Hora: $(date)"
echo ""
echo -e "${BLUE}📚 Manuais disponíveis em:${NC}"
echo "   - README.md (principal)"
echo "   - manuais/instalacao/"
echo "   - manuais/nginx/"
echo "   - manuais/git/"
echo ""
echo -e "${BLUE}🛠️  Scripts disponíveis:${NC}"
echo "   - scripts/nginx/configure-nginx.sh (configurar Nginx)"
echo "   - scripts/setup/install.sh (instalar dependências)"
echo "   - start-project.sh (este script)"
echo ""
echo -e "${GREEN}✅ Verificação concluída!${NC}"
echo ""

