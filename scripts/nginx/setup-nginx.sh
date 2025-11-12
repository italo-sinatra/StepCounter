#!/bin/bash

# Script para configurar Nginx para StepCounter
# Execute com: ./setup-nginx.sh

echo "🚀 Configurando Nginx para StepCounter..."
echo ""

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Verificar se nginx está instalado
if ! command -v nginx &> /dev/null; then
    echo -e "${RED}❌ Nginx não está instalado!${NC}"
    echo "Instale com: brew install nginx"
    exit 1
fi

echo -e "${GREEN}✅ Nginx encontrado$(nginx -v)${NC}"
echo ""

# Criar diretório de servidores se não existir
NGINX_DIR="/usr/local/etc/nginx"
SERVERS_DIR="$NGINX_DIR/servers"
PROJECT_DIR="/Users/Lucas/Downloads/StepCounter-main"
DIST_DIR="$PROJECT_DIR/dist"

# Verificar se a pasta dist existe
if [ ! -d "$DIST_DIR" ]; then
    echo -e "${YELLOW}⚠️  Pasta dist não encontrada. Fazendo build...${NC}"
    cd "$PROJECT_DIR"
    npm run build
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Erro ao fazer build${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✅ Pasta dist encontrada${NC}"
echo ""

# Criar diretório de servidores
echo "📁 Criando diretório de configuração..."
sudo mkdir -p "$SERVERS_DIR"
sudo chown $(whoami) "$SERVERS_DIR"

# Copiar configuração
echo "📝 Copiando configuração do Nginx..."
sudo cp "$PROJECT_DIR/nginx-stepcounter.conf" "$SERVERS_DIR/stepcounter.conf"
sudo chown $(whoami) "$SERVERS_DIR/stepcounter.conf"

# Criar diretório de logs se não existir
echo "📁 Criando diretório de logs..."
sudo mkdir -p /usr/local/var/log/nginx
sudo chown $(whoami) /usr/local/var/log/nginx

# Verificar configuração do nginx
echo "🔍 Verificando configuração do Nginx..."
sudo nginx -t

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Configuração do Nginx está correta!${NC}"
    echo ""
    echo "🔄 Reiniciando Nginx..."
    sudo nginx -s reload
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Nginx reiniciado com sucesso!${NC}"
        echo ""
        echo "🌐 Aplicação disponível em:"
        echo "   Local: http://localhost"
        echo "   Rede: http://192.168.0.89"
        echo ""
        echo "📱 Para acessar de outra máquina na mesma rede:"
        echo "   http://192.168.0.89"
        echo ""
    else
        echo -e "${YELLOW}⚠️  Nginx não está rodando. Iniciando...${NC}"
        sudo nginx
        echo -e "${GREEN}✅ Nginx iniciado!${NC}"
    fi
else
    echo -e "${RED}❌ Erro na configuração do Nginx${NC}"
    exit 1
fi

echo ""
echo "✅ Configuração concluída!"

