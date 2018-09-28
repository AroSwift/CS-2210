ASM=nasm
LINKER=ld
SRC = $(wildcard *.asm)
OBJ = $(SRC:.asm=.o)

hello: $(OBJ)
	$(LINKER) $< -o hello

hello: $(SRC)
	$(ASM) $< -f elf64
