# 📦 Requisitos e Dependências do Projeto

## Requisitos do Sistema

### Node.js
- **Versão mínima:** 18.0.0
- **Versão recomendada:** 20.x LTS ou superior
- **Download:** https://nodejs.org/

### npm
- **Versão mínima:** 9.0.0
- **Geralmente incluído com Node.js**
- **Verificação:** `npm --version`

### Sistema Operacional
- ✅ Windows 10/11
- ✅ macOS 10.15+
- ✅ Linux (Ubuntu 20.04+, Debian 11+, etc.)

### Navegador (para desenvolvimento)
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## Dependências de Produção

As seguintes dependências são necessárias para a execução da aplicação:

### @hono/zod-validator
- **Versão:** ^0.5.0
- **Descrição:** Validador Zod para Hono framework
- **Uso:** Validação de dados no backend

### hono
- **Versão:** 4.7.7
- **Descrição:** Framework web rápido para Workers
- **Uso:** Backend API

### lucide-react
- **Versão:** ^0.510.0
- **Descrição:** Biblioteca de ícones SVG para React
- **Uso:** Ícones na interface

### react
- **Versão:** 19.0.0
- **Descrição:** Biblioteca JavaScript para construção de interfaces
- **Uso:** Framework principal da aplicação

### react-dom
- **Versão:** 19.0.0
- **Descrição:** Renderizador React para DOM
- **Uso:** Renderização da aplicação no navegador

### react-router
- **Versão:** ^7.5.3
- **Descrição:** Roteamento para aplicações React
- **Uso:** Navegação entre páginas

### zod
- **Versão:** ^3.24.3
- **Descrição:** Biblioteca de validação TypeScript-first
- **Uso:** Validação de esquemas e tipos

## Dependências de Desenvolvimento

As seguintes dependências são necessárias apenas para desenvolvimento:

### @cloudflare/vite-plugin
- **Versão:** ^1.12.0
- **Descrição:** Plugin Vite para Cloudflare Workers
- **Uso:** Deploy em Cloudflare Workers
- **Nota:** Pode ser desabilitado para desenvolvimento local

### @eslint/js
- **Versão:** 9.25.1
- **Descrição:** Core ESLint em JavaScript
- **Uso:** Linting do código

### @getmocha/vite-plugins
- **Versão:** latest
- **Descrição:** Plugins Vite personalizados da Mocha
- **Uso:** Configurações específicas do projeto

### @getmocha/users-service
- **Versão:** ^0.0.4
- **Descrição:** Serviço de usuários da Mocha
- **Uso:** Funcionalidades de autenticação

### @types/node
- **Versão:** 22.14.1
- **Descrição:** Definições de tipos TypeScript para Node.js
- **Uso:** Tipagem TypeScript

### @types/react
- **Versão:** 19.0.10
- **Descrição:** Definições de tipos TypeScript para React
- **Uso:** Tipagem TypeScript para React

### @types/react-dom
- **Versão:** 19.0.4
- **Descrição:** Definições de tipos TypeScript para React DOM
- **Uso:** Tipagem TypeScript para React DOM

### @vitejs/plugin-react
- **Versão:** ^4.0.0
- **Descrição:** Plugin oficial do Vite para React
- **Uso:** Suporte a React no Vite

### autoprefixer
- **Versão:** ^10.4.21
- **Descrição:** Adiciona prefixos de vendor ao CSS
- **Uso:** Compatibilidade de CSS

### eslint
- **Versão:** 9.25.1
- **Descrição:** Linter JavaScript/TypeScript
- **Uso:** Análise estática de código

### eslint-plugin-react-hooks
- **Versão:** 5.2.0
- **Descrição:** Regras ESLint para React Hooks
- **Uso:** Validação de hooks do React

### eslint-plugin-react-refresh
- **Versão:** 0.4.19
- **Descrição:** Plugin ESLint para React Refresh
- **Uso:** Suporte ao Fast Refresh

### globals
- **Versão:** 15.15.0
- **Descrição:** Variáveis globais para ESLint
- **Uso:** Configuração do ESLint

### postcss
- **Versão:** ^8.5.3
- **Descrição:** Ferramenta para transformar CSS
- **Uso:** Processamento de CSS

### tailwindcss
- **Versão:** ^3.4.17
- **Descrição:** Framework CSS utility-first
- **Uso:** Estilização da aplicação

### typescript
- **Versão:** 5.8.3
- **Descrição:** Superset tipado do JavaScript
- **Uso:** Linguagem de programação

### typescript-eslint
- **Versão:** 8.31.0
- **Descrição:** ESLint parser para TypeScript
- **Uso:** Linting de código TypeScript

### vite
- **Versão:** ^5.0.0
- **Descrição:** Build tool e servidor de desenvolvimento
- **Uso:** Ferramenta de build principal

### wrangler
- **Versão:** ^4.33.0
- **Descrição:** CLI para Cloudflare Workers
- **Uso:** Deploy e gerenciamento de Workers

## Instalação de Dependências

### Instalação Completa

```bash
npm install --legacy-peer-deps
```

### Instalação Apenas de Produção

```bash
npm install --legacy-peer-deps --production
```

### Atualização de Dependências

```bash
# Verificar dependências desatualizadas
npm outdated

# Atualizar dependências
npm update --legacy-peer-deps
```

### Verificação de Vulnerabilidades

```bash
# Verificar vulnerabilidades
npm audit

# Corrigir vulnerabilidades automaticamente
npm audit fix --legacy-peer-deps
```

## Arquivos de Configuração

### package.json
- Contém todas as dependências e scripts do projeto
- **Localização:** Raiz do projeto

### package-lock.json
- Lock file gerado automaticamente
- Garante versões consistentes das dependências
- **Não edite manualmente**

### node_modules/
- Pasta com todas as dependências instaladas
- Gerada automaticamente após `npm install`
- **Não commite no Git** (adicione ao .gitignore)

## Resolução de Conflitos

### Conflito de Versões

Se encontrar erros de conflito de versões:

```bash
# Limpar cache
npm cache clean --force

# Remover node_modules e package-lock.json
rm -rf node_modules package-lock.json

# Reinstalar com legacy-peer-deps
npm install --legacy-peer-deps
```

### Versões Específicas

Se precisar instalar uma versão específica:

```bash
npm install nome-pacote@versão --legacy-peer-deps
```

## Verificação de Instalação

Após instalar as dependências, verifique:

```bash
# Verificar Node.js
node --version

# Verificar npm
npm --version

# Verificar dependências instaladas
npm list --depth=0

# Verificar se há problemas
npm audit
```

## Tamanho das Dependências

- **node_modules/:** ~200-300 MB (aprox.)
- **Tempo de instalação:** 2-5 minutos (dependendo da conexão)
- **Número de pacotes:** ~400+ pacotes (incluindo dependências transitivas)

## Notas Importantes

1. **--legacy-peer-deps:** 
   - Necessário devido a conflitos de versão entre algumas dependências
   - Não afeta a funcionalidade do projeto
   - Use sempre este flag ao instalar dependências

2. **Plugins Cloudflare:**
   - Podem ser desabilitados para desenvolvimento local
   - Necessários apenas para deploy em Cloudflare Workers

3. **Versões do Node.js:**
   - Versões muito antigas podem não funcionar
   - Versões muito novas podem ter avisos, mas geralmente funcionam
   - Recomendado: Node.js 20.x LTS

4. **Cache do npm:**
   - Se tiver problemas, limpe o cache: `npm cache clean --force`
   - O cache acelera instalações futuras

## Compatibilidade

### Node.js
- ✅ Node.js 18.x
- ✅ Node.js 20.x (recomendado)
- ✅ Node.js 22.x
- ⚠️ Node.js 16.x (pode ter problemas)
- ❌ Node.js < 16 (não suportado)

### npm
- ✅ npm 9.x
- ✅ npm 10.x
- ✅ npm 11.x
- ⚠️ npm < 9 (pode ter problemas)

### Sistemas Operacionais
- ✅ Windows 10/11
- ✅ macOS 10.15+
- ✅ Linux (Ubuntu 20.04+, Debian 11+)
- ⚠️ Windows 8.1 (pode ter problemas)
- ❌ Windows 7 (não suportado)

## Recursos Adicionais

- **Documentação do npm:** https://docs.npmjs.com/
- **Documentação do Node.js:** https://nodejs.org/docs/
- **Documentação do Vite:** https://vitejs.dev/
- **Documentação do React:** https://react.dev/
- **Documentação do TypeScript:** https://www.typescriptlang.org/

---

**Última atualização:** Novembro 2024

