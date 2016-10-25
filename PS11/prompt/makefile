ASM=nasm
LINKER=ld
SRC = $(wildcard *.asm)
OBJ = $(SRC:.asm=.o)

prompt: $(OBJ)
	$(LINKER) $< -o hello

prompt: $(SRC)
	$(ASM) $< -f elf64
