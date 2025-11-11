#!/bin/bash

# Script de Instalação do StepCounter
# Para Linux e macOS

echo "🚀 Instalando StepCounter..."
echo ""

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar se Node.js está instalado
echo "📦 Verificando Node.js..."
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js não está instalado!${NC}"
    echo "Por favor, instale Node.js 18 ou superior em: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${YELLOW}⚠️  Node.js versão $NODE_VERSION detectada. Recomendado: Node.js 18 ou superior.${NC}"
else
    echo -e "${GREEN}✅ Node.js $(node -v) instalado${NC}"
fi

# Verificar se npm está instalado
echo "📦 Verificando npm..."
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm não está instalado!${NC}"
    echo "npm geralmente vem com Node.js. Por favor, reinstale Node.js."
    exit 1
fi

echo -e "${GREEN}✅ npm $(npm -v) instalado${NC}"
echo ""

# Limpar instalações anteriores (opcional)
read -p "Deseja limpar instalações anteriores? (node_modules, package-lock.json) [s/N]: " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    echo "🧹 Limpando instalações anteriores..."
    rm -rf node_modules
    rm -f package-lock.json
    echo -e "${GREEN}✅ Limpeza concluída${NC}"
    echo ""
fi

# Limpar cache do npm
echo "🧹 Limpando cache do npm..."
npm cache clean --force
echo -e "${GREEN}✅ Cache limpo${NC}"
echo ""

# Instalar dependências
echo "📥 Instalando dependências..."
echo "Isso pode levar alguns minutos..."
echo ""

if npm install --legacy-peer-deps; then
    echo ""
    echo -e "${GREEN}✅ Dependências instaladas com sucesso!${NC}"
    echo ""
    echo "🎉 Instalação concluída!"
    echo ""
    echo "Para iniciar o servidor de desenvolvimento, execute:"
    echo -e "${YELLOW}  npm run dev${NC}"
    echo ""
    echo "A aplicação estará disponível em: http://localhost:5173"
    echo ""
else
    echo ""
    echo -e "${RED}❌ Erro ao instalar dependências${NC}"
    echo ""
    echo "Tente executar manualmente:"
    echo "  npm install --legacy-peer-deps"
    echo ""
    echo "Ou verifique a seção 'Solução de Problemas' no README.md"
    exit 1
fi

