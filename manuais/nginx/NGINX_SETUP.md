# 🌐 Configuração do Nginx para StepCounter

Este guia explica como configurar o Nginx para servir a aplicação StepCounter e permitir acesso de outras máquinas na rede.

## 📋 Pré-requisitos

- ✅ Nginx instalado (`brew install nginx`)
- ✅ Node.js instalado
- ✅ Projeto buildado (`npm run build`)

## 🚀 Configuração Rápida

### 1. Executar Script de Configuração

```bash
chmod +x setup-nginx.sh
./setup-nginx.sh
```

O script irá:
- ✅ Verificar se o Nginx está instalado
- ✅ Fazer build do projeto (se necessário)
- ✅ Criar configuração do Nginx
- ✅ Configurar permissões
- ✅ Testar configuração
- ✅ Reiniciar Nginx

### 2. Acessar a Aplicação

Após a configuração, a aplicação estará disponível em:

- **Local:** http://localhost
- **Rede Local:** http://192.168.0.89
- **Outras máquinas:** http://192.168.0.89 (mesma rede Wi-Fi)

## 📝 Configuração Manual

Se preferir configurar manualmente:

### 1. Criar Diretório de Servidores

```bash
sudo mkdir -p /usr/local/etc/nginx/servers
sudo chown $(whoami) /usr/local/etc/nginx/servers
```

### 2. Copiar Configuração

```bash
sudo cp nginx-stepcounter.conf /usr/local/etc/nginx/servers/stepcounter.conf
sudo chown $(whoami) /usr/local/etc/nginx/servers/stepcounter.conf
```

### 3. Criar Diretório de Logs

```bash
sudo mkdir -p /usr/local/var/log/nginx
sudo chown $(whoami) /usr/local/var/log/nginx
```

### 4. Verificar Configuração

```bash
sudo nginx -t
```

### 5. Reiniciar Nginx

```bash
sudo nginx -s reload
```

Ou se não estiver rodando:

```bash
sudo nginx
```

## 🛠️ Scripts Úteis

### Iniciar/Reiniciar Nginx

```bash
chmod +x start-nginx.sh
./start-nginx.sh
```

### Parar Nginx

```bash
chmod +x stop-nginx.sh
./stop-nginx.sh
```

### Ver Status do Nginx

```bash
sudo nginx -t
pgrep -x nginx
```

### Ver Logs

```bash
tail -f /usr/local/var/log/nginx/stepcounter-access.log
tail -f /usr/local/var/log/nginx/stepcounter-error.log
```

## 🔧 Configuração do Nginx

A configuração está em `nginx-stepcounter.conf` e inclui:

- ✅ Servir arquivos estáticos da pasta `dist`
- ✅ Suporte a SPA (Single Page Application)
- ✅ Cache para assets estáticos
- ✅ Compressão gzip
- ✅ Headers de segurança
- ✅ Acesso de qualquer IP na rede

### Porta

Por padrão, o Nginx está configurado para usar a **porta 80** (HTTP).

Para usar outra porta, edite `nginx-stepcounter.conf`:

```nginx
listen 8080;  # Altere para a porta desejada
```

### Diretório

O diretório raiz está configurado para:

```
/Users/Lucas/Downloads/StepCounter-main/dist
```

Para alterar, edite `nginx-stepcounter.conf`:

```nginx
root /caminho/para/seu/projeto/dist;
```

## 🌐 Acesso de Outras Máquinas

### 1. Verificar IP da Máquina

```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

Ou:

```bash
ipconfig getifaddr en0
```

### 2. Verificar Firewall

No macOS, permita conexões na porta 80:

```bash
# Verificar firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# Se necessário, permitir Nginx
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/local/bin/nginx
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp /usr/local/bin/nginx
```

### 3. Acessar de Outra Máquina

1. Certifique-se de que ambas as máquinas estão na **mesma rede Wi-Fi**
2. Acesse no navegador: `http://[IP_DA_MAQUINA]`
3. Exemplo: `http://192.168.0.89`

## 🔄 Atualizar Aplicação

Após fazer alterações no código:

1. **Fazer build:**
   ```bash
   npm run build
   ```

2. **Recarregar Nginx:**
   ```bash
   ./start-nginx.sh
   ```

Ou manualmente:

```bash
sudo nginx -s reload
```

## 🐛 Solução de Problemas

### Erro: "Permission denied"

```bash
# Verificar permissões
ls -la /usr/local/etc/nginx/servers/
sudo chown $(whoami) /usr/local/etc/nginx/servers/stepcounter.conf
```

### Erro: "Port 80 already in use"

```bash
# Verificar o que está usando a porta 80
sudo lsof -i :80

# Parar o processo ou usar outra porta
```

### Erro: "Failed to load resource"

```bash
# Verificar se a pasta dist existe
ls -la dist/

# Fazer build novamente
npm run build
```

### Nginx não inicia

```bash
# Verificar configuração
sudo nginx -t

# Ver logs de erro
tail -f /usr/local/var/log/nginx/error.log
```

### Não consigo acessar de outra máquina

1. **Verificar firewall:**
   ```bash
   sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
   ```

2. **Verificar IP:**
   ```bash
   ifconfig | grep "inet "
   ```

3. **Verificar se está na mesma rede:**
   - Ambas as máquinas devem estar na mesma rede Wi-Fi
   - Verifique o IP da máquina servidor

4. **Testar localmente primeiro:**
   ```bash
   curl http://localhost
   ```

## 📊 Monitoramento

### Ver Acessos

```bash
tail -f /usr/local/var/log/nginx/stepcounter-access.log
```

### Ver Erros

```bash
tail -f /usr/local/var/log/nginx/stepcounter-error.log
```

### Ver Status do Nginx

```bash
ps aux | grep nginx
```

## 🔒 Segurança

### HTTPS (Opcional)

Para usar HTTPS, você precisará de um certificado SSL. Opções:

1. **Let's Encrypt (gratuito):**
   ```bash
   brew install certbot
   sudo certbot --nginx -d seu-dominio.com
   ```

2. **Certificado auto-assinado (desenvolvimento):**
   ```bash
   # Gerar certificado
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
     -keyout /usr/local/etc/nginx/ssl/stepcounter.key \
     -out /usr/local/etc/nginx/ssl/stepcounter.crt
   ```

   Depois, adicione ao `nginx-stepcounter.conf`:
   ```nginx
   listen 443 ssl;
   ssl_certificate /usr/local/etc/nginx/ssl/stepcounter.crt;
   ssl_certificate_key /usr/local/etc/nginx/ssl/stepcounter.key;
   ```

## 📱 Testar em Dispositivo Móvel

1. Certifique-se de que o dispositivo está na mesma rede Wi-Fi
2. Abra o navegador no dispositivo
3. Acesse: `http://192.168.0.89` (ou o IP da sua máquina)
4. A aplicação deve carregar normalmente

## ✅ Checklist

- [ ] Nginx instalado
- [ ] Projeto buildado (`npm run build`)
- [ ] Configuração do Nginx criada
- [ ] Nginx testado (`sudo nginx -t`)
- [ ] Nginx reiniciado
- [ ] Aplicação acessível localmente
- [ ] Firewall configurado (se necessário)
- [ ] Aplicação acessível de outra máquina

## 🆘 Precisa de Ajuda?

1. Verifique os logs: `/usr/local/var/log/nginx/stepcounter-error.log`
2. Teste a configuração: `sudo nginx -t`
3. Verifique se o Nginx está rodando: `pgrep -x nginx`
4. Verifique as permissões dos arquivos
5. Consulte a documentação do Nginx: https://nginx.org/en/docs/

---

**Configuração concluída! 🎉**

A aplicação está disponível em:
- **Local:** http://localhost
- **Rede:** http://192.168.0.89

