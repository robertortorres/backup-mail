# 📧 Email Backup e Consulta com Docker

Este projeto realiza o **backup de múltiplas caixas de e-mail IMAP**, armazena os dados localmente em formato Maildir e fornece uma **interface web para leitura e pesquisa** dos e-mails com Mailpile.

## 🔧 Componentes

- **Dovecot via Docker** – Servidor IMAP local que armazena os e-mails em `/dados/mail`.
- **ImapSync** – Ferramenta que sincroniza caixas IMAP remotas para o servidor local.
- **Mailpile** – Interface web para consultar os e-mails armazenados.
- **Scripts automatizados** – Criação de usuários, sincronização de contas e importação automática no Mailpile.

## 📁 Estrutura

```
email-backup/
├── docker-compose.yml              # Stack Docker com Dovecot + Mailpile
├── mailusers.txt                   # Lista de contas para backup
├── imapsync.sh                     # Script para importar os e-mails via IMAP
├── criar_usuarios.sh               # Criação de Maildirs locais
├── importar_maildirs_mailpile.sh  # Importa automaticamente para o Mailpile
```

## 📦 Pré-requisitos

- Docker e Docker Compose instalados
- Pasta local no host: `/dados/mail`
- Permissões corretas para o Docker acessar a pasta

```bash
sudo mkdir -p /dados/mail
sudo chown 1000:1000 /dados/mail
```

## 🛠️ Configuração

1. **Configure as contas no `mailusers.txt`**

```
usuario1@dominio.com;senha1;usuario1@backup.local;senhaLocal1
usuario2@dominio.com;senha2;usuario2@backup.local;senhaLocal2
```

2. **Suba os containers**

```bash
docker compose up -d
```

3. **Crie as Maildirs locais**

```bash
./criar_usuarios.sh
```

4. **Sincronize os e-mails**

```bash
./imapsync.sh
```

5. **Importe os Maildirs no Mailpile**

```bash
./importar_maildirs_mailpile.sh
```

## 🌐 Acessar o Mailpile

- URL: [http://localhost:33411](http://localhost:33411)
- Os e-mails aparecerão sob a tag `importado`, um por usuário

## ♻️ Backup recorrente (opcional)

Você pode adicionar os scripts ao `crontab` para executar diariamente:

```bash
crontab -e
```

Exemplo (backup todos os dias às 2h):

```
0 2 * * * /caminho/projeto/email-backup/imapsync.sh
5 2 * * * /caminho/projeto/email-backup/importar_maildirs_mailpile.sh
```

## ✅ Licença

Projeto de uso pessoal e corporativo interno. Você pode modificar e adaptar conforme necessário.
