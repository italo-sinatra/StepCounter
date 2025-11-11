# StepCounter - Configuração Local

## Pré-requisitos

Antes de começar, você precisa instalar:

1. **Node.js** (versão 18 ou superior)
   - Baixe em: https://nodejs.org/
   - Verifique a instalação: `node --version`

2. **Visual Studio Code**
   - Baixe em: https://code.visualstudio.com/

3. **Git** (opcional, mas recomendado)
   - Baixe em: https://git-scm.com/

## Como baixar o código

### Opção 1: Copiar arquivos manualmente

1. Crie uma nova pasta no seu computador (ex: `step-counter`)
2. Copie todos os arquivos do projeto para esta pasta
3. Mantenha a mesma estrutura de pastas

### Opção 2: Usar Git (se disponível)

```bash
git clone [URL_DO_REPOSITÓRIO] step-counter
cd step-counter
```

## Configuração no Visual Studio Code

### 1. Abrir o projeto

1. Abra o Visual Studio Code
2. Clique em "File" → "Open Folder"
3. Selecione a pasta do projeto `step-counter`

### 2. Instalar extensões recomendadas

Instale essas extensões no VS Code:
- **ES7+ React/Redux/React-Native snippets**
- **Tailwind CSS IntelliSense**
- **TypeScript Importer**
- **Prettier - Code formatter**
- **ESLint**

### 3. Instalar dependências

Abra o terminal no VS Code (Terminal → New Terminal) e execute:

```bash
npm install
```

### 4. Executar o projeto

Para rodar o servidor de desenvolvimento:

```bash
npm run dev
```

O app estará disponível em: `http://localhost:5173`

## Estrutura do projeto

```
step-counter/
├── src/
│   ├── react-app/           # Código React
│   │   ├── components/      # Componentes reutilizáveis
│   │   ├── pages/          # Páginas da aplicação
│   │   └── main.tsx        # Ponto de entrada
│   ├── worker/             # Backend (Cloudflare Worker)
│   └── shared/             # Tipos compartilhados
├── public/                 # Arquivos estáticos
├── index.html             # Página HTML principal
└── package.json           # Dependências do projeto
```

## Scripts disponíveis

- `npm run dev` - Inicia servidor de desenvolvimento
- `npm run build` - Gera build de produção
- `npm run preview` - Visualiza build de produção
- `npm run lint` - Verifica código com ESLint
- `npm run type-check` - Verifica tipos TypeScript

## Como testar no celular (desenvolvimento)

1. Execute `npm run dev`
2. Encontre seu IP local (ex: 192.168.1.100)
3. Acesse no celular: `http://192.168.1.100:5173`

**Nota:** Para funcionar no celular, você precisa de HTTPS. Use ferramentas como `ngrok` para criar um túnel seguro:

```bash
# Instalar ngrok
npm install -g ngrok

# Criar túnel HTTPS
ngrok http 5173
```

## Tecnologias utilizadas

- **React 18** - Interface de usuário
- **TypeScript** - Tipagem estática
- **Vite** - Build tool e servidor de desenvolvimento
- **Tailwind CSS** - Framework de estilo
- **React Router** - Roteamento
- **Lucide React** - Ícones
- **Hono** - Framework para backend

## Deploy em produção

O projeto está configurado para Cloudflare Workers, mas você pode fazer deploy em outras plataformas:

- **Vercel**: `npm run build` + deploy da pasta `dist`
- **Netlify**: `npm run build` + deploy da pasta `dist`
- **GitHub Pages**: Configure GitHub Actions para build automático

## Problemas comuns

### Erro de permissões no celular
- Certifique-se de usar HTTPS
- Aceite as permissões para sensores de movimento
- Teste em navegadores modernos (Safari iOS 13+, Chrome Android)

### Erro de dependências
```bash
# Limpar cache e reinstalar
rm -rf node_modules package-lock.json
npm install
```

### Erro de TypeScript
```bash
# Verificar tipos
npm run type-check
```

## Personalização

- **Cores**: Edite `tailwind.config.js` ou os estilos nos componentes
- **Layout**: Modifique `src/react-app/components/StepCounter.tsx`
- **Algoritmo**: Ajuste os parâmetros de detecção no componente principal

## Suporte

Se encontrar problemas:
1. Verifique os pré-requisitos
2. Consulte o console do navegador para erros
3. Execute `npm run type-check` para verificar tipos
4. Use `npm run lint` para verificar o código