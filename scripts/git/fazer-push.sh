#!/bin/bash
echo "🚀 Fazendo push para GitHub..."
echo ""
echo "Você precisará inserir suas credenciais do GitHub."
echo ""
echo "Opções:"
echo "1. Personal Access Token (recomendado)"
echo "2. GitHub CLI (gh auth login)"
echo ""
read -p "Pressione Enter para continuar..."
git push -u origin main --force-with-lease
