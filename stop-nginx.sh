#!/bin/bash

# Script para parar Nginx

echo "🛑 Parando Nginx..."
echo ""

sudo nginx -s stop

if [ $? -eq 0 ]; then
    echo "✅ Nginx parado com sucesso!"
else
    echo "⚠️  Nginx pode não estar rodando ou já foi parado"
fi

echo ""

