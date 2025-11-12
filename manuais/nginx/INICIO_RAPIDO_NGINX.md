# ⚡ Início Rápido - Nginx para StepCounter

## 🚀 Execute estes comandos:

```bash
# 1. Dar permissão de execução aos scripts
chmod +x setup-nginx.sh start-nginx.sh stop-nginx.sh

# 2. Executar configuração (pedirá senha do sudo)
./setup-nginx.sh
```

## ✅ Pronto!

Após a configuração, a aplicação estará disponível em:

- **Local:** http://localhost
- **Rede Local:** http://192.168.0.89
- **Outras máquinas:** http://192.168.0.89 (mesma rede Wi-Fi)

## 📱 Para acessar de outra máquina:

1. Certifique-se de que ambas as máquinas estão na **mesma rede Wi-Fi**
2. Acesse no navegador: `http://192.168.0.89`
3. Pronto! A aplicação deve carregar

## 🔄 Comandos úteis:

```bash
# Reiniciar Nginx
./start-nginx.sh

# Parar Nginx
./stop-nginx.sh

# Ver logs
tail -f /usr/local/var/log/nginx/stepcounter-access.log

# Verificar status
sudo nginx -t
```

## 🐛 Problemas?

Consulte `NGINX_SETUP.md` para documentação completa e solução de problemas.

---

**IP da sua máquina:** 192.168.0.89

