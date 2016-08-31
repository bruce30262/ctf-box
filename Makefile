all: build run

build:
	docker build --rm -t bruce30262/ctf-box .

build_newpwn:
	docker build --rm -t bruce30262/ctf-box --build-arg NEWPWN=$(shell date +%s) .

run:
	docker run -e TERM --privileged --security-opt seccomp:unconfined -p 2222:22 -p 3002:3002 -p 4000:4000 -v /home/bruce30262/Desktop:/mnt/files --name=ctf -it bruce30262/ctf-box /usr/bin/zsh
