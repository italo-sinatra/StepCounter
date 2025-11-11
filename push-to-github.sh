#!/bin/bash

# Script para fazer push do projeto para o GitHub

echo "🚀 Fazendo push para o GitHub..."
echo ""

# Verificar se estamos na branch main
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    echo "⚠️  Você não está na branch main. Branch atual: $current_branch"
    read -p "Deseja continuar mesmo assim? (s/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "❌ Push cancelado."
        exit 1
    fi
fi

# Verificar se há commits para fazer push
if ! git rev-parse --verify origin/main >/dev/null 2>&1; then
    echo "📤 Fazendo push inicial..."
    git push -u origin main --force-with-lease
else
    # Verificar se há diferenças
    if git diff --quiet origin/main..main; then
        echo "✅ Não há alterações para fazer push."
        exit 0
    else
        echo "📤 Fazendo push das alterações..."
        git push -u origin main --force-with-lease
    fi
fi

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Push realizado com sucesso!"
    echo ""
    echo "🌐 Seu código está disponível em:"
    echo "   https://github.com/italo-sinatra/StepCounter"
    echo ""
else
    echo ""
    echo "❌ Erro ao fazer push."
    echo ""
    echo "💡 Possíveis soluções:"
    echo "   1. Verifique suas credenciais do GitHub"
    echo "   2. Use um Personal Access Token se estiver usando HTTPS"
    echo "   3. Configure SSH se preferir"
    echo "   4. Consulte INSTRUCOES_GIT.md para mais detalhes"
    echo ""
    exit 1
fi

