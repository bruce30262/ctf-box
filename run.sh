#!/usr/bin/env sh
tag=${1:-latest}
docker ps -aq --filter "name=ctf" | grep -q . && echo "stop and deleting ctf..." && docker stop ctf && docker rm -fv ctf
docker run -e TERM --privileged --security-opt seccomp:unconfined -v /home/bruce30262/Desktop:/mnt/files --name=ctf -it bruce30262/ctf-box:$tag /bin/bash -c 'cd /mnt/files; exec "/usr/bin/zsh"'
