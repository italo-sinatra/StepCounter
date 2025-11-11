# StepCounter - Manual Completo de Instalação e Uso

## 📋 Índice

- [Sobre o Projeto](#sobre-o-projeto)
- [Pré-requisitos](#pré-requisitos)
- [Instalação do Projeto](#instalação-do-projeto)
- [Como Executar](#como-executar)
- [Configuração do Nginx](#configuração-do-nginx)
- [Acesso de Outros Dispositivos](#acesso-de-outros-dispositivos)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Scripts Disponíveis](#scripts-disponíveis)
- [Solução de Problemas](#solução-de-problemas)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)

## 🎯 Sobre o Projeto

StepCounter é uma aplicação web moderna para contagem de passos utilizando os sensores de movimento do dispositivo (acelerômetro e giroscópio). Desenvolvido com React, TypeScript e Vite, oferece uma interface intuitiva e responsiva para acompanhamento de atividade física.

A aplicação pode ser executada em modo de desenvolvimento ou servida via Nginx para acesso na rede local, permitindo que outros dispositivos na mesma rede Wi-Fi acessem a aplicação.

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

### 3. Nginx (para servir na rede local - Opcional)

**macOS:**
```bash
brew install nginx
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install nginx
```

**Windows:**
⚠️ **IMPORTANTE:** Para Windows, é **OBRIGATÓRIO** usar WSL (Windows Subsystem for Linux). O Nginx no Windows nativo apresenta problemas de configuração e não é recomendado.

**Instalar WSL no Windows:**

1. **Abrir PowerShell como Administrador:**
   - Clique com botão direito no menu Iniciar
   - Selecione "Windows PowerShell (Admin)" ou "Terminal (Admin)"

2. **Instalar WSL:**
   ```powershell
   wsl --install
   ```
   
   Ou para instalação manual:
   ```powershell
   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
   ```

3. **Reiniciar o computador** (se solicitado)

4. **Instalar distribuição Linux (Ubuntu recomendado):**
   ```powershell
   wsl --install -d Ubuntu
   ```
   
   Ou via Microsoft Store:
   - Abra a Microsoft Store
   - Procure por "Ubuntu"
   - Instale a versão mais recente

5. **Configurar usuário Linux:**
   - Após a instalação, abra o Ubuntu
   - Crie um usuário e senha quando solicitado

6. **Instalar Nginx no WSL:**
   ```bash
   sudo apt-get update
   sudo apt-get install nginx
   ```

7. **Verificar instalação:**
   ```bash
   nginx -v
   ```

### 4. Git (opcional, mas recomendado)

**Windows/macOS:**
- Baixe em: https://git-scm.com/

**Linux:**
```bash
sudo apt-get install git
```

## 🚀 Instalação do Projeto

### Método 1: Instalação Manual (Recomendado)

1. **Clone ou baixe o projeto:**
   ```bash
   git clone https://github.com/italo-sinatra/StepCounter.git
   cd StepCounter
   ```
   
   Ou extraia o arquivo ZIP em uma pasta de sua preferência.

2. **Navegue até a pasta do projeto:**
   ```bash
   cd StepCounter
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
# Execute o script install.bat
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

### Modo de Produção (Build Local)

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

## 🌐 Configuração do Nginx

Para servir a aplicação na rede local e permitir acesso de outros dispositivos, siga estes passos:

### ⚠️ IMPORTANTE: Windows + WSL

**Se você está usando Windows, DEVE usar WSL (Windows Subsystem for Linux).**

**Passos para Windows:**

1. **Instalar WSL (se ainda não instalado):**
   - Abra PowerShell como Administrador
   - Execute: `wsl --install`
   - Reinicie o computador
   - Instale Ubuntu: `wsl --install -d Ubuntu`

2. **Abrir WSL:**
   - Abra o Ubuntu no menu Iniciar
   - Ou execute `wsl` no PowerShell/CMD

3. **Acessar o projeto no WSL:**
   ```bash
   # O projeto Windows está em /mnt/c/Users/SeuUsuario/...
   # Exemplo:
   cd /mnt/c/Users/SeuUsuario/Downloads/StepCounter-main
   ```

4. **Instalar Node.js no WSL (se necessário):**
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

5. **Instalar dependências no WSL:**
   ```bash
   npm install --legacy-peer-deps
   ```

6. **Siga as instruções de configuração do Nginx abaixo (no WSL)**

### Passo 1: Fazer Build da Aplicação

Antes de configurar o Nginx, é necessário criar o build de produção:

**No WSL (Windows) ou Terminal (macOS/Linux):**
```bash
npm run build
```

Isso criará a pasta `dist/` com os arquivos estáticos da aplicação.

### Passo 2: Configurar o Nginx

#### Opção A: Configuração Automática (Recomendado)

1. **Execute o script de configuração:**
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

   ⚠️ **Nota:** Será solicitada a senha do sudo para configurar o Nginx.

#### Opção B: Configuração Manual

**Para macOS/Linux:**

1. **Criar diretório de servidores:**
   ```bash
   sudo mkdir -p /usr/local/etc/nginx/servers
   sudo chown $(whoami) /usr/local/etc/nginx/servers
   ```

2. **Copiar configuração:**
   ```bash
   sudo cp nginx-stepcounter.conf /usr/local/etc/nginx/servers/stepcounter.conf
   sudo chown $(whoami) /usr/local/etc/nginx/servers/stepcounter.conf
   ```

3. **Criar diretório de logs:**
   ```bash
   sudo mkdir -p /usr/local/var/log/nginx
   sudo chown $(whoami) /usr/local/var/log/nginx
   ```

4. **Verificar configuração:**
   ```bash
   sudo nginx -t
   ```

5. **Reiniciar Nginx:**
   ```bash
   sudo nginx -s reload
   ```

   Ou se não estiver rodando:
   ```bash
   sudo nginx
   ```

**Para Windows (WSL - Ubuntu):**

1. **Criar diretório de servidores:**
   ```bash
   sudo mkdir -p /etc/nginx/sites-available
   sudo mkdir -p /etc/nginx/sites-enabled
   ```

2. **Copiar configuração:**
   ```bash
   # Primeiro, ajuste o caminho no nginx-stepcounter.conf para o caminho do WSL
   # Exemplo: root /mnt/c/Users/SeuUsuario/Downloads/StepCounter-main/dist;
   
   sudo cp nginx-stepcounter.conf /etc/nginx/sites-available/stepcounter.conf
   sudo ln -s /etc/nginx/sites-available/stepcounter.conf /etc/nginx/sites-enabled/
   ```

3. **Ajustar configuração do Nginx principal:**
   ```bash
   sudo nano /etc/nginx/nginx.conf
   ```
   
   Adicione ou verifique esta linha no bloco `http`:
   ```nginx
   include /etc/nginx/sites-enabled/*;
   ```

4. **Criar diretório de logs:**
   ```bash
   sudo mkdir -p /var/log/nginx
   ```

5. **Ajustar caminho no arquivo de configuração:**
   ```bash
   sudo nano /etc/nginx/sites-available/stepcounter.conf
   ```
   
   Altere a linha `root` para o caminho completo do WSL:
   ```nginx
   root /mnt/c/Users/SeuUsuario/Downloads/StepCounter-main/dist;
   ```
   
   Altere os caminhos de log também:
   ```nginx
   access_log /var/log/nginx/stepcounter-access.log;
   error_log /var/log/nginx/stepcounter-error.log;
   ```

6. **Verificar configuração:**
   ```bash
   sudo nginx -t
   ```

7. **Iniciar Nginx:**
   ```bash
   sudo service nginx start
   ```
   
   Ou:
   ```bash
   sudo nginx
   ```

8. **Verificar status:**
   ```bash
   sudo service nginx status
   ```
   
   Ou:
   ```bash
   sudo nginx -s reload
   ```

### Passo 3: Verificar IP da Máquina

Para acessar de outros dispositivos, você precisa do IP da sua máquina:

**macOS/Linux:**
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

**Windows (WSL):**
```bash
# No WSL, você precisa do IP do Windows, não do WSL
# Execute no PowerShell do Windows:
ipconfig

# Ou no WSL, você pode usar:
hostname -I
```

**⚠️ IMPORTANTE para Windows:**
- O WSL tem seu próprio IP interno
- Para acesso de outros dispositivos, use o IP do **Windows Host**, não do WSL
- Para obter o IP do Windows a partir do WSL:
  ```bash
  # No WSL, execute:
  ip route show | grep -i default | awk '{ print $3}'
  ```
- Ou execute `ipconfig` no PowerShell do Windows e use o IP da sua placa de rede Wi-Fi/Ethernet

### Passo 4: Acessar a Aplicação

Após a configuração, a aplicação estará disponível em:

- **Local:** http://localhost
- **Rede Local:** http://[SEU_IP] (ex: http://192.168.0.89)

## 📱 Acesso de Outros Dispositivos

### Requisitos

1. **Mesma rede Wi-Fi:**
   - O dispositivo servidor e os dispositivos clientes devem estar na mesma rede Wi-Fi
   - Verifique se ambos estão conectados à mesma rede

2. **Firewall configurado:**
   - Certifique-se de que o firewall permite conexões na porta 80 (HTTP)
   - No macOS, pode ser necessário permitir o Nginx no firewall

### Como Acessar

1. **Obtenha o IP da máquina servidor:**
   ```bash
   # macOS/Linux
   ifconfig | grep "inet " | grep -v 127.0.0.1
   
   # Windows
   ipconfig
   ```

2. **No dispositivo cliente (celular, tablet, outro computador):**
   - Abra o navegador
   - Acesse: `http://[IP_DA_MAQUINA_SERVIDOR]`
   - Exemplo: `http://192.168.0.89`

3. **A aplicação deve carregar normalmente!**

### Configurar Firewall (macOS)

Se não conseguir acessar de outros dispositivos:

```bash
# Verificar status do firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# Permitir Nginx (se necessário)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/local/bin/nginx
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp /usr/local/bin/nginx
```

### Configurar Firewall (Linux)

```bash
# Ubuntu/Debian (UFW)
sudo ufw allow 80/tcp
sudo ufw reload

# Ou iptables
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```

### Configurar Firewall (Windows)

**⚠️ IMPORTANTE:** No Windows, você precisa configurar o firewall do Windows, não do WSL.

1. **Abrir Firewall do Windows:**
   - Pressione `Win + R`
   - Digite: `wf.msc`
   - Pressione Enter

2. **Criar regra de entrada:**
   - Clique em "Regras de Entrada" → "Nova Regra"
   - Selecione "Porta" → Avançar
   - Selecione "TCP" e "Portas locais específicas"
   - Digite: `80`
   - Selecione "Permitir a conexão"
   - Marque todas as opções (Domínio, Privada, Pública)
   - Dê um nome: "Nginx HTTP"
   - Clique em "Concluir"

3. **Verificar regra:**
   - A regra deve aparecer na lista de regras de entrada
   - Certifique-se de que está habilitada (verde)

4. **Testar:**
   - De outro dispositivo na mesma rede, tente acessar: `http://[IP_DO_WINDOWS]`

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

## 🛠️ Scripts Úteis do Nginx

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

**macOS/Linux:**
```bash
sudo nginx -t
pgrep -x nginx
```

**Windows (WSL):**
```bash
sudo nginx -t
sudo service nginx status
# Ou
pgrep -x nginx
```

### Ver Logs

**macOS/Linux:**
```bash
# Logs de acesso
tail -f /usr/local/var/log/nginx/stepcounter-access.log

# Logs de erro
tail -f /usr/local/var/log/nginx/stepcounter-error.log
```

**Windows (WSL):**
```bash
# Logs de acesso
sudo tail -f /var/log/nginx/stepcounter-access.log

# Logs de erro
sudo tail -f /var/log/nginx/stepcounter-error.log

# Logs gerais do Nginx
sudo tail -f /var/log/nginx/error.log
```

## 📁 Estrutura do Projeto

```
StepCounter/
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
├── dist/                   # Build de produção (gerado)
├── public/                 # Arquivos estáticos (se houver)
├── index.html             # Página HTML principal
├── package.json           # Dependências e scripts
├── vite.config.ts         # Configuração do Vite
├── tailwind.config.js     # Configuração do Tailwind CSS
├── tsconfig.json          # Configuração do TypeScript
├── nginx-stepcounter.conf # Configuração do Nginx
├── setup-nginx.sh         # Script de configuração do Nginx
├── start-nginx.sh         # Script para iniciar/reiniciar Nginx
├── stop-nginx.sh          # Script para parar Nginx
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

### Problema: Nginx não inicia

**Sintoma:**
- Erro ao executar `sudo nginx`
- Mensagem de erro na configuração

**Solução:**
```bash
# Verificar configuração
sudo nginx -t

# Ver logs de erro
tail -f /usr/local/var/log/nginx/error.log

# Verificar se a porta 80 está em uso
sudo lsof -i :80

# Se necessário, parar processo que está usando a porta
sudo kill -9 [PID]
```

### Problema: Não consigo acessar de outra máquina

**Sintoma:**
- Aplicação funciona localmente, mas não de outros dispositivos

**Solução:**
1. **Verificar firewall:**
   ```bash
   # macOS
   sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
   
   # Linux
   sudo ufw status
   ```

2. **Verificar IP:**
   ```bash
   ifconfig | grep "inet " | grep -v 127.0.0.1
   ```

3. **Verificar se está na mesma rede:**
   - Ambas as máquinas devem estar na mesma rede Wi-Fi
   - Verifique o IP da máquina servidor

4. **Testar localmente primeiro:**
   ```bash
   curl http://localhost
   ```

5. **Verificar logs do Nginx:**
   ```bash
   tail -f /usr/local/var/log/nginx/stepcounter-error.log
   ```

### Problema: Sensores de movimento não funcionam

**Sintoma:**
- O contador não detecta passos
- Mensagem de "sensores não suportados"

**Solução:**
1. **Use HTTPS em produção:**
   - Os sensores de movimento requerem HTTPS em produção
   - Para desenvolvimento local, use `http://localhost` (funciona)
   - Para acesso via Nginx na rede local, HTTP funciona para testes

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

### Problema: Porta 80 já está em uso

**Sintoma:**
- Nginx não consegue iniciar na porta 80

**Solução:**
```bash
# Verificar o que está usando a porta 80
sudo lsof -i :80

# Parar o processo ou usar outra porta
# Edite nginx-stepcounter.conf e altere:
listen 8080;  # Use outra porta
```

### Problema: Windows - WSL não consegue acessar arquivos do Windows

**Sintoma:**
- Erro ao acessar arquivos em `/mnt/c/...`
- Permissões negadas

**Solução:**
1. **Verificar montagem do Windows:**
   ```bash
   ls -la /mnt/c/Users/
   ```

2. **Ajustar permissões (se necessário):**
   ```bash
   # No Windows, certifique-se de que o WSL tem acesso aos arquivos
   # Você pode precisar ajustar as permissões do Windows
   ```

3. **Usar caminho completo:**
   - Certifique-se de usar o caminho completo no arquivo de configuração do Nginx
   - Exemplo: `/mnt/c/Users/SeuUsuario/Downloads/StepCounter-main/dist`

### Problema: Windows - Nginx no WSL não responde de outros dispositivos

**Sintoma:**
- Nginx funciona localmente no WSL
- Não consegue acessar de outros dispositivos na rede

**Solução:**
1. **Verificar IP do Windows:**
   ```powershell
   # No PowerShell do Windows:
   ipconfig
   ```
   - Use o IP do Windows Host (não do WSL)
   - Geralmente é o IP da placa Wi-Fi ou Ethernet

2. **Configurar firewall do Windows:**
   - Siga as instruções em [Configurar Firewall (Windows)](#configurar-firewall-windows)
   - Certifique-se de permitir a porta 80

3. **Verificar se o Nginx está escutando em 0.0.0.0:**
   ```bash
   # No WSL, edite o arquivo de configuração:
   sudo nano /etc/nginx/sites-available/stepcounter.conf
   ```
   - Certifique-se de que está: `listen 80;` (não `listen 127.0.0.1:80;`)

4. **Reiniciar Nginx:**
   ```bash
   sudo service nginx restart
   ```

5. **Verificar se está rodando:**
   ```bash
   sudo netstat -tlnp | grep :80
   ```

### Problema: Windows - Erro ao iniciar Nginx no WSL

**Sintoma:**
- Erro ao executar `sudo nginx` ou `sudo service nginx start`

**Solução:**
1. **Verificar se o Nginx está instalado:**
   ```bash
   nginx -v
   ```

2. **Verificar configuração:**
   ```bash
   sudo nginx -t
   ```

3. **Verificar se há outro processo usando a porta:**
   ```bash
   sudo netstat -tlnp | grep :80
   ```

4. **Verificar logs de erro:**
   ```bash
   sudo tail -f /var/log/nginx/error.log
   ```

5. **Iniciar manualmente:**
   ```bash
   sudo nginx -c /etc/nginx/nginx.conf
   ```

### Problema: Windows - Caminho não encontrado no Nginx

**Sintoma:**
- Erro 404 ao acessar a aplicação
- Nginx não encontra os arquivos

**Solução:**
1. **Verificar caminho no arquivo de configuração:**
   ```bash
   sudo nano /etc/nginx/sites-available/stepcounter.conf
   ```
   - Verifique se o caminho `root` está correto
   - Use caminho absoluto do WSL: `/mnt/c/Users/...`

2. **Verificar se a pasta dist existe:**
   ```bash
   ls -la /mnt/c/Users/SeuUsuario/Downloads/StepCounter-main/dist
   ```

3. **Fazer build novamente:**
   ```bash
   npm run build
   ```

4. **Verificar permissões:**
   ```bash
   # No Windows, certifique-se de que o WSL tem acesso de leitura
   chmod -R 755 /mnt/c/Users/SeuUsuario/Downloads/StepCounter-main/dist
   ```

### Problema: Windows - WSL não inicia

**Sintoma:**
- Erro ao executar `wsl`
- WSL não está disponível

**Solução:**
1. **Verificar se o WSL está instalado:**
   ```powershell
   wsl --list --verbose
   ```

2. **Instalar WSL:**
   ```powershell
   wsl --install
   ```

3. **Verificar recursos do Windows:**
   - Abra "Recursos do Windows"
   - Verifique se "Subsistema do Windows para Linux" está habilitado
   - Verifique se "Plataforma de Máquina Virtual" está habilitada

4. **Reiniciar o computador**

### Problema: Windows - Node.js não funciona no WSL

**Sintoma:**
- Comando `node` não encontrado no WSL
- npm não funciona

**Solução:**
1. **Instalar Node.js no WSL:**
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

2. **Verificar instalação:**
   ```bash
   node --version
   npm --version
   ```

3. **Se já tiver Node.js no Windows:**
   - O Node.js do Windows não funciona no WSL
   - Você precisa instalar Node.js separadamente no WSL

## 🛠️ Tecnologias Utilizadas

- **React 19** - Biblioteca para construção de interfaces
- **TypeScript** - Tipagem estática
- **Vite** - Build tool e servidor de desenvolvimento
- **Tailwind CSS** - Framework de estilo utility-first
- **React Router** - Roteamento single-page application
- **Lucide React** - Biblioteca de ícones
- **Hono** - Framework web para Workers
- **Zod** - Validação de esquemas
- **Nginx** - Servidor web para produção

## 📝 Notas Importantes

1. **HTTPS em Produção:**
   - Sensores de movimento requerem HTTPS em produção
   - Para desenvolvimento local e testes na rede local, HTTP funciona
   - Use serviços como Vercel, Netlify ou Cloudflare Pages para HTTPS automático

2. **Permissões:**
   - iOS 13+ requer permissão explícita do usuário
   - Android geralmente funciona automaticamente

3. **Precisão:**
   - A precisão depende da qualidade dos sensores do dispositivo
   - Resultados podem variar entre diferentes dispositivos

4. **Armazenamento:**
   - Os dados são salvos no `localStorage` do navegador
   - Limpar os dados do navegador apagará o histórico

5. **Rede Local:**
   - Para acesso via Nginx, ambos os dispositivos devem estar na mesma rede Wi-Fi
   - O firewall pode bloquear conexões - verifique as configurações

## 🌐 Deploy em Produção

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
5. Consulte os logs do Nginx: `/usr/local/var/log/nginx/stepcounter-error.log`

## 📞 Contato

Para dúvidas ou suporte, abra uma issue no repositório: https://github.com/italo-sinatra/StepCounter/issues

---

## 🚀 Guia Rápido - Do Zero ao Funcionamento

### 1. Instalar Dependências
```bash
npm install --legacy-peer-deps
```

### 2. Fazer Build
```bash
npm run build
```

### 3. Configurar Nginx
```bash
chmod +x setup-nginx.sh
./setup-nginx.sh
```

### 4. Acessar
- **Local:** http://localhost
- **Rede:** http://[SEU_IP]

### 5. Acessar de Outro Dispositivo
- Conecte na mesma rede Wi-Fi
- Acesse: http://[IP_DA_MAQUINA_SERVIDOR]

---

**Desenvolvido com ❤️ usando React, TypeScript e Nginx**
