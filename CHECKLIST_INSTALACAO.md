# ✅ Checklist de Instalação - StepCounter

Use este checklist para garantir que a instalação foi feita corretamente.

## 📋 Pré-Instalação

- [ ] Node.js instalado (versão 18 ou superior)
  - [ ] Verificado com: `node --version`
- [ ] npm instalado
  - [ ] Verificado com: `npm --version`
- [ ] Git instalado (opcional)
  - [ ] Verificado com: `git --version`
- [ ] Projeto baixado/clonado
  - [ ] Pasta do projeto acessível
  - [ ] Arquivo `package.json` presente

## 🔧 Instalação

- [ ] Navegou até a pasta do projeto
  - [ ] Comando: `cd StepCounter-main`
- [ ] Executou o script de instalação OU `npm install --legacy-peer-deps`
  - [ ] Windows: `install.bat`
  - [ ] Linux/macOS: `./install.sh`
  - [ ] Ou manual: `npm install --legacy-peer-deps`
- [ ] Instalação concluída sem erros críticos
  - [ ] Mensagem de sucesso exibida
  - [ ] Pasta `node_modules` criada
  - [ ] Arquivo `package-lock.json` criado/atualizado

## ✅ Verificação Pós-Instalação

- [ ] Dependências instaladas corretamente
  - [ ] Comando: `npm list --depth=0`
  - [ ] Sem erros críticos
- [ ] TypeScript compila sem erros
  - [ ] Comando: `npm run check` (opcional)
- [ ] Servidor de desenvolvimento inicia
  - [ ] Comando: `npm run dev`
  - [ ] Servidor roda na porta 5173
  - [ ] Mensagem: "Local: http://localhost:5173"

## 🌐 Teste no Navegador

- [ ] Acessou http://localhost:5173
- [ ] Aplicação carrega sem erros
- [ ] Interface é exibida corretamente
- [ ] Console do navegador sem erros críticos
  - [ ] Abrir DevTools (F12)
  - [ ] Verificar aba Console

## 📱 Teste em Dispositivo Móvel (Opcional)

- [ ] Dispositivo na mesma rede Wi-Fi
- [ ] IP local identificado
- [ ] Acessou `http://[IP]:5173` no dispositivo
- [ ] Aplicação carrega no dispositivo
- [ ] Sensores de movimento funcionam (se disponível)
  - [ ] Permissões concedidas (iOS)
  - [ ] Passos sendo detectados

## 🚨 Solução de Problemas (se necessário)

- [ ] Erros de instalação resolvidos
  - [ ] Cache limpo: `npm cache clean --force`
  - [ ] node_modules removido e reinstalado
- [ ] Erros de compilação resolvidos
  - [ ] TypeScript atualizado
  - [ ] Dependências atualizadas
- [ ] Erros de execução resolvidos
  - [ ] Porta 5173 disponível
  - [ ] Firewall configurado (se necessário)

## 📝 Notas Adicionais

### Comandos Úteis

```bash
# Verificar versões
node --version
npm --version

# Instalar dependências
npm install --legacy-peer-deps

# Executar servidor de desenvolvimento
npm run dev

# Criar build de produção
npm run build

# Verificar código
npm run lint

# Limpar e reinstalar
rm -rf node_modules package-lock.json
npm cache clean --force
npm install --legacy-peer-deps
```

### Arquivos Importantes

- `package.json` - Dependências e scripts
- `vite.config.ts` - Configuração do Vite
- `tsconfig.json` - Configuração do TypeScript
- `tailwind.config.js` - Configuração do Tailwind CSS
- `README.md` - Documentação completa
- `REQUIREMENTS.md` - Lista de dependências

### Próximos Passos

Após concluir a instalação:

1. ✅ Explore a aplicação
2. ✅ Teste os sensores de movimento (em dispositivo físico)
3. ✅ Personalize as configurações (se desejar)
4. ✅ Consulte a documentação para mais detalhes
5. ✅ Faça deploy em produção (opcional)

## 🎉 Conclusão

- [ ] Instalação completa e funcionando
- [ ] Aplicação acessível em http://localhost:5173
- [ ] Sem erros críticos
- [ ] Pronto para desenvolvimento

---

**Data da Instalação:** _______________

**Observações:** 
_______________________________________
_______________________________________
_______________________________________

---

**Precisa de ajuda?** Consulte o README.md ou abra uma issue no repositório.

