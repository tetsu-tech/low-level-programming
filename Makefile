run:
	./scripts/run.sh

build:
	./scripts/build.sh

hello: mkout
	nasm -felf64 ./asm/hello.asm -o ./out/hello.o
	ld ./out/hello.o -o ./out/hello

mkout:
	./scripts/mkout.sh
