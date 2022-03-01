ARG ARCH=amd64
FROM archlinux:latest

WORKDIR /archlinux

# Update the repositories
RUN	 pacman -Syy

# Install base-devel
RUN	 pacman -S --noconfirm base-devel

ENV LANG=en_US.UTF-8

CMD ["/usr/bin/bash"]