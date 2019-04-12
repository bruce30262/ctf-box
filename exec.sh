#!/usr/bin/env sh
# access to the running docker container
docker exec -it ctf /bin/bash -c 'cd /mnt/files; exec "/usr/bin/zsh"'
