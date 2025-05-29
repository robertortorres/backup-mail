#!/bin/bash

USERS_FILE="mailusers.txt"
MAILDIR_ROOT="/dados/mail"

while IFS=';' read -r _ _ user2 _; do
  USERNAME=$(echo "$user2" | cut -d@ -f1)

  USER_PATH="${MAILDIR_ROOT}/${USERNAME}/Maildir"
  if [ ! -d "$USER_PATH" ]; then
    echo "==> Criando Maildir para $USERNAME"
    mkdir -p "$USER_PATH"/{cur,new,tmp}
    chown -R 1000:1000 "${MAILDIR_ROOT}/${USERNAME}"
  else
    echo "==> Maildir já existe para $USERNAME"
  fi
done < "$USERS_FILE"
