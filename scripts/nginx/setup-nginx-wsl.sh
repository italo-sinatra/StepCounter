#!/bin/bash

# Script para configurar Nginx para StepCounter no WSL (Windows)
# Execute com: ./setup-nginx-wsl.sh

echo "🚀 Configurando Nginx para StepCounter no WSL..."
echo ""

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Verificar se está no WSL
if [ ! -d /mnt/c ]; then
    echo -e "${RED}❌ Este script é específico para WSL (Windows Subsystem for Linux)${NC}"
    echo "Se você está no macOS/Linux, use setup-nginx.sh"
    exit 1
fi

# Verificar se nginx está instalado
if ! command -v nginx &> /dev/null; then
    echo -e "${RED}❌ Nginx não está instalado!${NC}"
    echo "Instale com: sudo apt-get update && sudo apt-get install nginx"
    exit 1
fi

echo -e "${GREEN}✅ Nginx encontrado$(nginx -v)${NC}"
echo ""

# Obter caminho do projeto
PROJECT_DIR=$(pwd)
DIST_DIR="$PROJECT_DIR/dist"

# Verificar se a pasta dist existe
if [ ! -d "$DIST_DIR" ]; then
    echo -e "${YELLOW}⚠️  Pasta dist não encontrada. Fazendo build...${NC}"
    npm run build
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Erro ao fazer build${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✅ Pasta dist encontrada: $DIST_DIR${NC}"
echo ""

# Obter nome de usuário do Windows (se possível)
WINDOWS_USER=$(whoami.exe 2>/dev/null | cut -d '\\' -f 2 | tr -d '\r\n' || echo "SeuUsuario")
echo "📝 Detected Windows user: $WINDOWS_USER"
echo ""

# Criar diretórios
echo "📁 Criando diretórios de configuração..."
sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled
sudo mkdir -p /var/log/nginx

# Copiar e ajustar configuração
echo "📝 Copiando e ajustando configuração do Nginx..."
sudo cp nginx-stepcounter-wsl.conf /etc/nginx/sites-available/stepcounter.conf

# Ajustar caminho no arquivo de configuração
echo "🔧 Ajustando caminhos no arquivo de configuração..."
sudo sed -i "s|/mnt/c/Users/SeuUsuario/Downloads/StepCounter-main/dist|$DIST_DIR|g" /etc/nginx/sites-available/stepcounter.conf

# Criar link simbólico
echo "🔗 Criando link simbólico..."
sudo ln -sf /etc/nginx/sites-available/stepcounter.conf /etc/nginx/sites-enabled/stepcounter.conf

# Verificar se nginx.conf inclui sites-enabled
if ! grep -q "sites-enabled" /etc/nginx/nginx.conf; then
    echo "📝 Adicionando include de sites-enabled no nginx.conf..."
    sudo sed -i '/http {/a\    include /etc/nginx/sites-enabled/*;' /etc/nginx/nginx.conf
fi

# Verificar configuração
echo "🔍 Verificando configuração do Nginx..."
sudo nginx -t

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Configuração do Nginx está correta!${NC}"
    echo ""
    echo "🔄 Reiniciando Nginx..."
    sudo service nginx restart
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Nginx reiniciado com sucesso!${NC}"
        echo ""
        echo "🌐 Aplicação disponível em:"
        echo "   Local: http://localhost"
        echo ""
        echo "📱 Para acessar de outro dispositivo na mesma rede:"
        echo "   1. Obtenha o IP do Windows (não do WSL):"
        echo "      - No PowerShell: ipconfig"
        echo "      - Use o IP da placa Wi-Fi/Ethernet"
        echo "   2. Acesse: http://[IP_DO_WINDOWS]"
        echo ""
        echo "⚠️  IMPORTANTE:"
        echo "   - Configure o firewall do Windows para permitir a porta 80"
        echo "   - Use o IP do Windows Host, não do WSL"
        echo ""
    else
        echo -e "${YELLOW}⚠️  Nginx não está rodando. Iniciando...${NC}"
        sudo service nginx start
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Nginx iniciado!${NC}"
        else
            echo -e "${RED}❌ Erro ao iniciar Nginx${NC}"
            echo "Verifique os logs: sudo tail -f /var/log/nginx/error.log"
            exit 1
        fi
    fi
else
    echo -e "${RED}❌ Erro na configuração do Nginx${NC}"
    echo "Verifique os erros acima e corrija o arquivo de configuração"
    exit 1
fi

echo ""
echo "✅ Configuração concluída!"

