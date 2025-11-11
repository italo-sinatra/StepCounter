# Scripts do package.json para desenvolvimento

## Como criar/configurar um projeto similar do zero

### 1. Inicializar projeto
```bash
npm create vite@latest step-counter -- --template react-ts
cd step-counter
```

### 2. Instalar dependências principais
```bash
npm install react-router lucide-react
```

### 3. Instalar dependências de desenvolvimento
```bash
npm install -D tailwindcss postcss autoprefixer @tailwindcss/typography
npm install -D @types/react @types/react-dom
npm install -D eslint @typescript-eslint/eslint-plugin @typescript-eslint/parser
npm install -D prettier eslint-plugin-react-hooks eslint-plugin-react-refresh
```

### 4. Configurar Tailwind CSS
```bash
npx tailwindcss init -p
```

### 5. Scripts úteis no package.json
```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "preview": "vite preview",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "lint:fix": "eslint . --ext ts,tsx --fix",
    "type-check": "tsc --noEmit",
    "format": "prettier --write src/**/*.{ts,tsx,css,md}"
  }
}
```

## Dependências do projeto atual

### Dependências principais (runtime):
- `react` - Biblioteca principal
- `react-dom` - DOM renderer
- `react-router` - Roteamento SPA
- `lucide-react` - Ícones SVG
- `hono` - Framework web para Workers

### Dependências de desenvolvimento:
- `vite` - Build tool e dev server
- `typescript` - Tipagem estática
- `tailwindcss` - Framework CSS
- `eslint` - Linter JavaScript/TypeScript
- `@typescript-eslint/*` - Regras ESLint para TS
- `eslint-plugin-react-*` - Regras ESLint para React

## Comandos úteis durante desenvolvimento

```bash
# Instalar nova dependência
npm install nome-do-pacote

# Instalar dependência de desenvolvimento
npm install -D nome-do-pacote

# Remover dependência
npm uninstall nome-do-pacote

# Verificar dependências desatualizadas
npm outdated

# Atualizar dependências
npm update

# Limpar cache do npm
npm cache clean --force

# Verificar vulnerabilidades
npm audit

# Corrigir vulnerabilidades automáticas
npm audit fix
```
