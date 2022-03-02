ARG ARCH=amd64
FROM archlinux:latest

WORKDIR /archlinux

# Update the repositories
RUN	 pacman -Syy

# Install base-devel
RUN	 pacman -S --noconfirm base-devel nasm python3 vim\
    xorg xorg-server

# Install qemu
RUN pacman -S --noconfirm qemu

ENV LANG=en_US.UTF-8

COPY hello.asm /archlinux/
COPY run.sh /archlinux/

CMD ["/usr/bin/bash", "run.sh", "hello"]