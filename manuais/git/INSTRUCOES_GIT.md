# 🔄 Instruções para Fazer Push para o GitHub

O repositório Git foi configurado localmente. Agora você precisa fazer o push para o GitHub.

## ✅ O que já foi feito

1. ✅ Repositório Git inicializado
2. ✅ Remote do GitHub configurado: `https://github.com/italo-sinatra/StepCounter.git`
3. ✅ Arquivos adicionados ao Git
4. ✅ Commit inicial criado com todas as alterações
5. ✅ Branch renomeada para `main`

## 🚀 Como fazer o Push

### Opção 1: Usando HTTPS (Recomendado para iniciantes)

1. **Faça o push:**
   ```bash
   git push -u origin main --force-with-lease
   ```

2. **Quando solicitado, insira suas credenciais:**
   - **Username:** Seu usuário do GitHub (italo-sinatra)
   - **Password:** Use um Personal Access Token (não sua senha)
     - Como criar: https://github.com/settings/tokens
     - Permissões necessárias: `repo`

### Opção 2: Usando SSH (Recomendado para desenvolvedores)

1. **Verifique se você tem chave SSH:**
   ```bash
   ls -la ~/.ssh/id_rsa.pub
   ```

2. **Se não tiver, crie uma:**
   ```bash
   ssh-keygen -t ed25519 -C "seu-email@example.com"
   ```

3. **Adicione a chave ao GitHub:**
   - Copie a chave pública: `cat ~/.ssh/id_rsa.pub`
   - Adicione em: https://github.com/settings/keys

4. **Altere o remote para SSH:**
   ```bash
   git remote set-url origin git@github.com:italo-sinatra/StepCounter.git
   ```

5. **Faça o push:**
   ```bash
   git push -u origin main --force-with-lease
   ```

### Opção 3: Usando GitHub CLI (gh)

1. **Instale o GitHub CLI:**
   ```bash
   # macOS
   brew install gh
   
   # Linux
   sudo apt install gh
   
   # Windows
   winget install GitHub.cli
   ```

2. **Faça login:**
   ```bash
   gh auth login
   ```

3. **Faça o push:**
   ```bash
   git push -u origin main --force-with-lease
   ```

## ⚠️ Sobre --force-with-lease

O flag `--force-with-lease` é usado porque:
- O repositório remoto já tem algum conteúdo
- Queremos substituir com nosso código atualizado
- É mais seguro que `--force` (verifica se há alterações remotas não vistas)

**Alternativa sem forçar:**
Se preferir mesclar com o conteúdo remoto:
```bash
git pull origin main --allow-unrelated-histories
git push -u origin main
```

## 📋 Comandos Úteis

### Verificar status
```bash
git status
```

### Ver commits
```bash
git log --oneline
```

### Ver remote configurado
```bash
git remote -v
```

### Verificar branch atual
```bash
git branch
```

## 🔐 Autenticação no GitHub

### Personal Access Token (HTTPS)

1. Acesse: https://github.com/settings/tokens
2. Clique em "Generate new token (classic)"
3. Selecione as permissões:
   - ✅ `repo` (acesso completo a repositórios)
4. Copie o token gerado
5. Use o token como senha ao fazer push

### Chave SSH

1. Gere uma chave SSH (se não tiver):
   ```bash
   ssh-keygen -t ed25519 -C "seu-email@example.com"
   ```

2. Adicione ao ssh-agent:
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

3. Copie a chave pública:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

4. Adicione no GitHub:
   - Acesse: https://github.com/settings/keys
   - Clique em "New SSH key"
   - Cole a chave pública

## 🎯 Resumo Rápido

```bash
# 1. Verificar status
git status

# 2. Verificar remote
git remote -v

# 3. Fazer push (escolha uma opção de autenticação acima primeiro)
git push -u origin main --force-with-lease
```

## ❓ Problemas Comuns

### Erro: "Authentication failed"
- Verifique suas credenciais
- Para HTTPS, use Personal Access Token (não senha)
- Para SSH, verifique se a chave está adicionada ao GitHub

### Erro: "Permission denied"
- Verifique se você tem permissão de escrita no repositório
- Verifique se o repositório existe e você tem acesso

### Erro: "Updates were rejected"
- Alguém fez push enquanto você trabalhava
- Faça pull primeiro: `git pull origin main --rebase`
- Depois faça push: `git push -u origin main`

## 📞 Precisa de Ajuda?

- Documentação do GitHub: https://docs.github.com/en/get-started
- Guia de autenticação: https://docs.github.com/en/authentication
- Suporte do GitHub: https://support.github.com/

---

**Após fazer o push, seu código estará disponível em:**
**https://github.com/italo-sinatra/StepCounter**

