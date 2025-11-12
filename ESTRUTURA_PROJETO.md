# 📁 Estrutura do Projeto StepCounter

## 🗂️ Organização de Pastas

```
StepCounter/
├── 📄 README.md                    # Documentação principal
├── 🚀 start-project.sh             # Script de inicialização completa
├── 📦 package.json                 # Dependências do projeto
├── ⚙️ vite.config.ts               # Configuração do Vite
├── ⚙️ tsconfig.json                # Configuração do TypeScript
├── ⚙️ tailwind.config.js           # Configuração do Tailwind CSS
│
├── 📁 src/                         # Código fonte
│   ├── react-app/                  # Aplicação React
│   │   ├── components/             # Componentes React
│   │   │   └── StepCounter.tsx
│   │   ├── pages/                  # Páginas da aplicação
│   │   │   └── Home.tsx
│   │   ├── App.tsx                 # Componente principal
│   │   ├── main.tsx                # Ponto de entrada
│   │   └── index.css               # Estilos globais
│   ├── worker/                     # Backend (Cloudflare Worker)
│   │   └── index.ts
│   └── shared/                     # Tipos compartilhados
│       └── types.ts
│
├── 📁 manuais/                     # Documentação organizada
│   ├── instalacao/                 # Manuais de instalação
│   │   ├── CHECKLIST_INSTALACAO.md
│   │   ├── INSTALACAO_RAPIDA.md
│   │   ├── REQUIREMENTS.md
│   │   └── SETUP_INSTRUCTIONS.md
│   ├── nginx/                      # Manuais do Nginx
│   │   ├── NGINX_SETUP.md
│   │   └── INICIO_RAPIDO_NGINX.md
│   ├── git/                        # Manuais do Git
│   │   ├── INSTRUCOES_GIT.md
│   │   ├── PUSH_AGORA.md
│   │   └── COMANDO_PUSH.txt
│   └── geral/                      # Outros manuais
│       ├── DOCUMENTACAO.md
│       ├── RESUMO_ARQUIVOS.md
│       └── package-scripts.md
│
├── 📁 scripts/                     # Scripts organizados
│   ├── setup/                      # Scripts de instalação
│   │   ├── install.sh              # Instalação (Linux/macOS)
│   │   └── install.bat             # Instalação (Windows)
│   ├── nginx/                      # Scripts do Nginx
│   │   ├── configure-nginx.sh      # Configuração completa (Linux/WSL)
│   │   ├── setup-nginx.sh          # Configuração (macOS/Linux)
│   │   ├── setup-nginx-wsl.sh      # Configuração (WSL)
│   │   ├── start-nginx.sh          # Iniciar Nginx
│   │   └── stop-nginx.sh           # Parar Nginx
│   └── git/                        # Scripts do Git
│       ├── push-to-github.sh
│       └── fazer-push.sh
│
├── 📁 configs/                     # Configurações
│   └── nginx/                      # Configurações do Nginx
│       ├── nginx-stepcounter.conf  # Configuração (Linux/macOS)
│       └── nginx-stepcounter-wsl.conf  # Configuração (WSL)
│
├── 📁 dist/                        # Build de produção (gerado)
│   ├── index.html
│   └── assets/
│       ├── index-[hash].css
│       └── index-[hash].js
│
├── 📁 node_modules/                # Dependências (gerado)
├── 📁 public/                      # Arquivos estáticos (se houver)
└── 📄 index.html                   # Página HTML principal
```

## 📋 Descrição das Pastas

### 📁 `src/`
Contém todo o código fonte da aplicação:
- **react-app/**: Aplicação React principal
- **worker/**: Backend Cloudflare Worker
- **shared/**: Tipos e utilitários compartilhados

### 📁 `manuais/`
Documentação organizada por categoria:
- **instalacao/**: Guias de instalação e configuração inicial
- **nginx/**: Documentação específica do Nginx
- **git/**: Instruções para Git e GitHub
- **geral/**: Documentação geral do projeto

### 📁 `scripts/`
Scripts organizados por funcionalidade:
- **setup/**: Scripts de instalação de dependências
- **nginx/**: Scripts para gerenciar o Nginx
- **git/**: Scripts para operações Git

### 📁 `configs/`
Arquivos de configuração:
- **nginx/**: Configurações do Nginx para diferentes ambientes

### 📁 `dist/`
Build de produção (gerado automaticamente):
- Contém os arquivos estáticos prontos para servir
- Criado ao executar `npm run build`

## 🚀 Scripts Principais

### `start-project.sh`
Script de inicialização completa que verifica:
- ✅ Sistema operacional (Linux/WSL)
- ✅ Instalação de Node.js, npm, Nginx
- ✅ Estrutura de pastas
- ✅ Arquivos essenciais
- ✅ Configurações do Nginx
- ✅ Dependências instaladas
- ✅ Build criado
- ✅ Serviços rodando
- ✅ Configuração de rede

**Uso:**
```bash
./start-project.sh
```

### `scripts/nginx/configure-nginx.sh`
Script de configuração completa do Nginx:
- ✅ Detecta automaticamente Linux ou WSL
- ✅ Configura Nginx automaticamente
- ✅ Ajusta caminhos dinamicamente
- ✅ Testa configuração
- ✅ Inicia/reinicia Nginx

**Uso:**
```bash
./scripts/nginx/configure-nginx.sh
```

## 📝 Arquivos de Configuração

### Nginx
- **`configs/nginx/nginx-stepcounter.conf`**: Configuração para Linux/macOS
- **`configs/nginx/nginx-stepcounter-wsl.conf`**: Configuração para WSL

Os caminhos nestes arquivos são ajustados automaticamente pelos scripts.

## 🔄 Fluxo de Trabalho

1. **Instalação:**
   ```bash
   npm install --legacy-peer-deps
   ```

2. **Build:**
   ```bash
   npm run build
   ```

3. **Configurar Nginx:**
   ```bash
   ./scripts/nginx/configure-nginx.sh
   ```

4. **Verificar tudo:**
   ```bash
   ./start-project.sh
   ```

5. **Acessar:**
   - Local: http://localhost
   - Rede: http://[IP_DA_MAQUINA]

## 📚 Manuais

Consulte os manuais em `manuais/` para instruções detalhadas:
- **Instalação**: `manuais/instalacao/`
- **Nginx**: `manuais/nginx/`
- **Git**: `manuais/git/`
- **Geral**: `manuais/geral/`

## 🛠️ Manutenção

### Adicionar Novo Manual
1. Identifique a categoria (instalacao, nginx, git, geral)
2. Coloque o arquivo em `manuais/[categoria]/`
3. Atualize este documento se necessário

### Adicionar Novo Script
1. Identifique a categoria (setup, nginx, git)
2. Coloque o script em `scripts/[categoria]/`
3. Dê permissão de execução: `chmod +x scripts/[categoria]/script.sh`
4. Atualize este documento

### Adicionar Nova Configuração
1. Coloque o arquivo em `configs/[categoria]/`
2. Atualize os scripts que usam a configuração
3. Atualize este documento

## 📌 Notas

- Os arquivos em `dist/` e `node_modules/` são gerados automaticamente
- Não edite arquivos em `dist/` manualmente
- Os scripts ajustam caminhos automaticamente
- Sempre verifique com `./start-project.sh` antes de usar

---

**Última atualização**: Novembro 2024

