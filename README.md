# StepCounter - Manual de Instalação e Uso

## 📋 Índice

- [Sobre o Projeto](#sobre-o-projeto)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Como Executar](#como-executar)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Scripts Disponíveis](#scripts-disponíveis)
- [Solução de Problemas](#solução-de-problemas)
- [Deploy](#deploy)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)

## 🎯 Sobre o Projeto

StepCounter é uma aplicação web moderna para contagem de passos utilizando os sensores de movimento do dispositivo (acelerômetro e giroscópio). Desenvolvido com React, TypeScript e Vite, oferece uma interface intuitiva e responsiva para acompanhamento de atividade física.

## 📦 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

### 1. Node.js (versão 18 ou superior)

**Windows:**
- Baixe o instalador em: https://nodejs.org/
- Execute o instalador e siga as instruções
- Verifique a instalação: `node --version`

**macOS:**
- Usando Homebrew: `brew install node`
- Ou baixe em: https://nodejs.org/
- Verifique a instalação: `node --version`

**Linux (Ubuntu/Debian):**
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version
```

### 2. npm (geralmente vem com Node.js)

Verifique a instalação:
```bash
npm --version
```

### 3. Git (opcional, mas recomendado)

**Windows/macOS:**
- Baixe em: https://git-scm.com/

**Linux:**
```bash
sudo apt-get install git
```

## 🚀 Instalação

### Método 1: Instalação Manual (Recomendado)

1. **Clone ou baixe o projeto:**
   ```bash
   git clone [URL_DO_REPOSITÓRIO]
   cd StepCounter-main
   ```
   
   Ou extraia o arquivo ZIP em uma pasta de sua preferência.

2. **Navegue até a pasta do projeto:**
   ```bash
   cd StepCounter-main
   ```

3. **Instale as dependências:**
   ```bash
   npm install --legacy-peer-deps
   ```
   
   ⚠️ **Nota:** Usamos `--legacy-peer-deps` para resolver conflitos de versão entre algumas dependências. Isso é seguro e não afeta a funcionalidade do projeto.

4. **Aguarde a instalação:**
   - O processo pode levar alguns minutos
   - Você verá mensagens de progresso no terminal
   - Ao final, verá "added X packages"

### Método 2: Usando Script de Instalação

#### Windows:
```bash
# Execute o script install.bat (se disponível)
install.bat
```

#### Linux/macOS:
```bash
# Dê permissão de execução ao script
chmod +x install.sh

# Execute o script
./install.sh
```

## ▶️ Como Executar

### Modo de Desenvolvimento

1. **Inicie o servidor de desenvolvimento:**
   ```bash
   npm run dev
   ```

2. **Acesse a aplicação:**
   - Abra seu navegador
   - Acesse: `http://localhost:5173`
   - A aplicação será recarregada automaticamente quando você fizer alterações no código

3. **Para parar o servidor:**
   - Pressione `Ctrl + C` no terminal

### Modo de Produção

1. **Crie o build de produção:**
   ```bash
   npm run build
   ```

2. **Visualize o build localmente:**
   ```bash
   npm run preview
   ```

3. **Acesse:**
   - O servidor de preview estará disponível em `http://localhost:4173`

## 📁 Estrutura do Projeto

```
StepCounter-main/
├── src/
│   ├── react-app/           # Aplicação React
│   │   ├── components/      # Componentes reutilizáveis
│   │   │   └── StepCounter.tsx
│   │   ├── pages/          # Páginas da aplicação
│   │   │   └── Home.tsx
│   │   ├── App.tsx         # Componente principal
│   │   ├── main.tsx        # Ponto de entrada
│   │   └── index.css       # Estilos globais
│   ├── worker/             # Backend (Cloudflare Worker)
│   │   └── index.ts
│   └── shared/             # Tipos compartilhados
│       └── types.ts
├── public/                 # Arquivos estáticos (se houver)
├── index.html             # Página HTML principal
├── package.json           # Dependências e scripts
├── vite.config.ts         # Configuração do Vite
├── tailwind.config.js     # Configuração do Tailwind CSS
├── tsconfig.json          # Configuração do TypeScript
└── README.md             # Este arquivo
```

## 📜 Scripts Disponíveis

Execute os scripts usando `npm run [nome-do-script]`:

| Script | Descrição |
|--------|-----------|
| `npm run dev` | Inicia o servidor de desenvolvimento |
| `npm run build` | Cria o build de produção |
| `npm run preview` | Visualiza o build de produção localmente |
| `npm run lint` | Verifica o código com ESLint |
| `npm run check` | Verifica tipos TypeScript e faz build de teste |

## 🔧 Solução de Problemas

### Problema: Erro ao instalar dependências

**Sintoma:**
```
npm error ERESOLVE unable to resolve dependency tree
```

**Solução:**
```bash
# Limpe o cache do npm
npm cache clean --force

# Remova node_modules e package-lock.json
rm -rf node_modules package-lock.json

# Reinstale as dependências
npm install --legacy-peer-deps
```

### Problema: Porta 5173 já está em uso

**Sintoma:**
```
Error: Port 5173 is already in use
```

**Solução:**
```bash
# Opção 1: Pare o processo que está usando a porta
# Linux/macOS:
lsof -ti:5173 | xargs kill -9

# Windows:
netstat -ano | findstr :5173
taskkill /PID [PID_NUMBER] /F

# Opção 2: Use outra porta
# Edite vite.config.ts e adicione:
server: {
  port: 3000, // ou outra porta disponível
}
```

### Problema: Erro de TypeScript

**Sintoma:**
```
Cannot find module '...' or its corresponding type declarations
```

**Solução:**
```bash
# Verifique se todas as dependências estão instaladas
npm install --legacy-peer-deps

# Verifique os tipos
npm run check
```

### Problema: Sensores de movimento não funcionam

**Sintoma:**
- O contador não detecta passos
- Mensagem de "sensores não suportados"

**Solução:**
1. **Use HTTPS:** Os sensores de movimento requerem HTTPS em produção
   - Para desenvolvimento local, use `http://localhost` (funciona)
   - Para testar em dispositivos móveis, você precisa de HTTPS

2. **Permissões (iOS):**
   - iOS 13+ requer permissão explícita
   - Clique no botão de permissão quando solicitado

3. **Navegadores suportados:**
   - Chrome Android (recomendado)
   - Safari iOS 13+
   - Firefox (parcial)
   - Edge (parcial)

4. **Teste em dispositivo físico:**
   - Simuladores/emuladores podem não ter sensores
   - Use um dispositivo real para testar

### Problema: Plugin Cloudflare não funciona

**Sintoma:**
```
TypeError: Class extends value undefined is not a constructor or null
```

**Solução:**
- O plugin Cloudflare está comentado no `vite.config.ts` para desenvolvimento local
- Isso é normal e não afeta o funcionamento local
- Para deploy em produção, atualize o Vite para versão 6+ ou ajuste as versões das dependências

### Problema: Versão do Node.js incompatível

**Sintoma:**
```
npm warn cli npm v11.5.1 does not support Node.js v20.14.0
```

**Solução:**
1. Atualize o Node.js para a versão mais recente LTS:
   - Baixe em: https://nodejs.org/
   - Ou use nvm (Node Version Manager):
     ```bash
     nvm install 20
     nvm use 20
     ```

2. Ou continue usando (o aviso não impede o funcionamento)

## 🌐 Deploy

### Deploy em Vercel

1. **Instale a CLI da Vercel:**
   ```bash
   npm i -g vercel
   ```

2. **Faça o deploy:**
   ```bash
   npm run build
   vercel
   ```

### Deploy em Netlify

1. **Instale a CLI da Netlify:**
   ```bash
   npm i -g netlify-cli
   ```

2. **Faça o deploy:**
   ```bash
   npm run build
   netlify deploy --prod --dir=dist
   ```

### Deploy em Cloudflare Workers

1. **Instale o Wrangler:**
   ```bash
   npm install -g wrangler
   ```

2. **Configure o wrangler.json:**
   - Edite o arquivo `wrangler.json` com suas configurações

3. **Faça o deploy:**
   ```bash
   npm run build
   wrangler deploy
   ```

### Deploy Manual

1. **Crie o build:**
   ```bash
   npm run build
   ```

2. **Faça upload da pasta `dist`:**
   - Para qualquer servidor web estático
   - Ou hospedagem de arquivos estáticos

## 🧪 Testando em Dispositivos Móveis

### Método 1: Usando o IP Local

1. **Encontre seu IP local:**
   ```bash
   # Linux/macOS:
   ifconfig | grep "inet "
   
   # Windows:
   ipconfig
   ```

2. **Inicie o servidor:**
   ```bash
   npm run dev
   ```

3. **Acesse no celular:**
   - Conecte o celular na mesma rede Wi-Fi
   - Acesse: `http://[SEU_IP]:5173`
   - Exemplo: `http://192.168.1.100:5173`

### Método 2: Usando ngrok (HTTPS)

1. **Instale o ngrok:**
   ```bash
   npm install -g ngrok
   ```

2. **Inicie o servidor:**
   ```bash
   npm run dev
   ```

3. **Crie um túnel HTTPS:**
   ```bash
   ngrok http 5173
   ```

4. **Use a URL fornecida pelo ngrok:**
   - Exemplo: `https://abc123.ngrok.io`
   - Acesse esta URL no seu celular

## 📱 Requisitos do Navegador

- **Chrome/Edge:** Versão 50+
- **Firefox:** Versão 55+
- **Safari:** Versão 13+
- **Opera:** Versão 37+

### Funcionalidades por Navegador

| Navegador | Sensores de Movimento | Permissões |
|-----------|----------------------|------------|
| Chrome Android | ✅ Completo | ✅ Automático |
| Safari iOS | ✅ Completo | ⚠️ Requer permissão |
| Firefox | ⚠️ Parcial | ✅ Automático |
| Edge | ✅ Completo | ✅ Automático |

## 🛠️ Tecnologias Utilizadas

- **React 19** - Biblioteca para construção de interfaces
- **TypeScript** - Tipagem estática
- **Vite** - Build tool e servidor de desenvolvimento
- **Tailwind CSS** - Framework de estilo utility-first
- **React Router** - Roteamento single-page application
- **Lucide React** - Biblioteca de ícones
- **Hono** - Framework web para Workers
- **Zod** - Validação de esquemas

## 📝 Notas Importantes

1. **HTTPS em Produção:**
   - Sensores de movimento requerem HTTPS em produção
   - Use serviços como Vercel, Netlify ou Cloudflare Pages (HTTPS automático)

2. **Permissões:**
   - iOS 13+ requer permissão explícita do usuário
   - Android geralmente funciona automaticamente

3. **Precisão:**
   - A precisão depende da qualidade dos sensores do dispositivo
   - Resultados podem variar entre diferentes dispositivos

4. **Armazenamento:**
   - Os dados são salvos no `localStorage` do navegador
   - Limpar os dados do navegador apagará o histórico

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT.

## 🆘 Suporte

Se encontrar problemas:

1. Verifique a seção [Solução de Problemas](#solução-de-problemas)
2. Consulte os logs do console do navegador (F12)
3. Verifique se todas as dependências estão instaladas
4. Certifique-se de estar usando a versão correta do Node.js

## 📞 Contato

Para dúvidas ou suporte, abra uma issue no repositório.

---

**Desenvolvido com ❤️ usando React e TypeScript**

