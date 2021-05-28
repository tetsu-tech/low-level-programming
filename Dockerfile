FROM debian:9

RUN apt-get update
RUN apt-get install -y binutils nasm gdb gcc make
RUN apt-get install -y vim
