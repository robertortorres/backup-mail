#!/bin/bash

MAILPILE_URL="http://localhost:33411"
MAILDIR_ROOT="/dados/mail"

echo "==> Verificando Maildirs em: $MAILDIR_ROOT"

for USERDIR in "$MAILDIR_ROOT"/*; do
  if [ -d "$USERDIR/Maildir" ]; then
    USERNAME=$(basename "$USERDIR")
    echo "==> Importando Maildir de $USERNAME"

    curl -s -X POST "$MAILPILE_URL/api/0/mailbox/import" \
      -d "path=/mail/$USERNAME/Maildir" \
      -d "mount=true" \
      -d "tags=importado" \
      -d "msg=Importando $USERNAME" \
      | jq '.status, .result'
  fi
done

echo "✅ Importação concluída!"
