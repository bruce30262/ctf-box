FROM phusion/baseimage:latest
MAINTAINER bruce30262

# apt-get
#RUN sed -i "s/archive.ubuntu.com/tw.archive.ubuntu.com/g" /etc/apt/sources.list
RUN dpkg --add-architecture i386 && apt-get update \
        && apt-get install build-essential -y \
        && apt-get install -y \
        sudo \
        git \
        gcc \
        g++ \
        gcc-multilib \
        g++-multilib \
        gdb \
        gdb-multiarch \
        ltrace \
        strace \
        make \
        man \
        nasm \
        nmap \
        ruby \
        python2.7\
        python2.7-dev\
        python-pip \
        python3-dev\
        python3-pip \
        libffi-dev \
        libssl-dev \
        libssh-dev \
        netcat \
        net-tools \
        lsof \
        wget \
        curl \
        tmux \
        zsh \
        vim

# dotfiles
RUN git clone https://github.com/bruce30262/dotfiles.git ~/dotfiles &&\
    cd ~/dotfiles &&\
    bash set_vim.sh &&\
    ruby install.rb --tmux --zsh --dbg=all &&\
    bash set_arm_env.sh

# install ctf-tools for pwning
# if NEWPWN = timestamp then install new tools
ARG NEWPWN=0
RUN cd ~/dotfiles &&\
    ruby install_ctf_pwn.rb

# enable ssh
RUN rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh

# add ssh public key
ADD ssh /root/.ssh/

# create dir for workspace
RUN mkdir -p /root/desktop && chown root:root /root/desktop
COPY restart_ssh.sh /root/desktop/restart_ssh.sh
RUN chmod u+x /root/desktop/restart_ssh.sh
COPY testing/ /root/desktop/testing/

# set working space
WORKDIR /root/desktop

CMD ["/usr/bin/zsh"]
