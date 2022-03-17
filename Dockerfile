ARG ARCH=amd64
FROM archlinux:latest

WORKDIR /karch

# Update the repositories
RUN	 pacman -Syyuu --disable-download-timeout --noconfirm

# Install base-devel
RUN	 pacman -S --disable-download-timeout --noconfirm base-devel nasm python3 vim

# Install qemu
RUN pacman -S --disable-download-timeout --noconfirm qemu

ENV LANG=en_US.UTF-8

COPY pinpog.asm /karch/
COPY run.sh /karch/

CMD ["./run.sh", "pinpog"]
