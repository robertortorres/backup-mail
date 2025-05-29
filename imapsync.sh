#!/bin/bash

ORIGEM_IMAP="mail.origem.com"
DESTINO_IMAP="mailbackup"

while IFS=';' read -r user1 pass1 user2 pass2; do
  echo "==> Sincronizando: $user1 -> $user2"

  docker run --rm gilleslamiral/imapsync \
    imapsync --host1 $ORIGEM_IMAP --user1 "$user1" --password1 "$pass1" \
             --host2 $DESTINO_IMAP --user2 "$user2" --password2 "$pass2" \
             --ssl1 --ssl2

  echo "OK."
done < mailusers.txt
