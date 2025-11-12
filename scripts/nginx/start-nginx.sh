#!/bin/bash

# Script para iniciar/reiniciar Nginx com StepCounter

echo "🚀 Gerenciando Nginx para StepCounter..."
echo ""

# Verificar se nginx está rodando
if pgrep -x "nginx" > /dev/null; then
    echo "🔄 Nginx está rodando. Recarregando configuração..."
    sudo nginx -s reload
    if [ $? -eq 0 ]; then
        echo "✅ Nginx recarregado com sucesso!"
    else
        echo "❌ Erro ao recarregar Nginx"
        exit 1
    fi
else
    echo "▶️  Iniciando Nginx..."
    sudo nginx
    if [ $? -eq 0 ]; then
        echo "✅ Nginx iniciado com sucesso!"
    else
        echo "❌ Erro ao iniciar Nginx"
        exit 1
    fi
fi

echo ""
echo "🌐 Aplicação disponível em:"
echo "   http://localhost"
echo "   http://192.168.0.89"
echo ""

