# ⚡ Instalação Rápida - StepCounter

## Instalação em 3 Passos

### 1️⃣ Pré-requisitos

Certifique-se de ter instalado:
- **Node.js** 18 ou superior: https://nodejs.org/
- **npm** (vem com Node.js)

Verifique:
```bash
node --version
npm --version
```

### 2️⃣ Instalar Dependências

**Windows:**
```bash
install.bat
```

**Linux/macOS:**
```bash
chmod +x install.sh
./install.sh
```

**Ou manualmente:**
```bash
npm install --legacy-peer-deps
```

### 3️⃣ Executar

```bash
npm run dev
```

Acesse: **http://localhost:5173**

---

## 🚨 Problemas Comuns

### Erro ao instalar?
```bash
# Limpe e reinstale
rm -rf node_modules package-lock.json
npm cache clean --force
npm install --legacy-peer-deps
```

### Porta já em uso?
```bash
# Use outra porta (edite vite.config.ts)
# Ou pare o processo na porta 5173
```

### Mais ajuda?
Consulte o **README.md** completo para instruções detalhadas.

---

**Pronto! 🎉 Agora você pode usar o StepCounter!**

