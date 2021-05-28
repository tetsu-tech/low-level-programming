run:
	./scripts/run.sh

build:
	./scripts/build.sh

hello:
	nasm -felf64 ./asm/hello.asm -o ./asm/hello.o
	ld ./asm/hello.o -o ./asm/hello
