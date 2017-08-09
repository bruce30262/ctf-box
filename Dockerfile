FROM phusion/baseimage:latest
MAINTAINER bruce30262

# Set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# apt-get
# not using dockerhub auto-build, so better fetch those packages from TW
RUN sed -i "s/archive.ubuntu.com/tw.archive.ubuntu.com/g" /etc/apt/sources.list
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
        libc6-dbg:i386 \
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
RUN cd ~/dotfiles/ctf-tool &&\
    ruby install_ctf_tool.rb --all --exclude="qira,angr,afl,pin"

# numpy
RUN pip install numpy

# one_gadget by david942j
RUN gem install one_gadget

# create dir for workspace
RUN mkdir -p /root/desktop && chown root:root /root/desktop
COPY testing/ /root/desktop/testing/

# set working space
WORKDIR /root/desktop

CMD ["/usr/bin/zsh"]
