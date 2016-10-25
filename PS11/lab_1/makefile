ASM=nasm
LINKER=ld
SRC = $(wildcard *.asm)
OBJ = $(SRC:.asm=.o)

loop: $(OBJ)
	$(LINKER) $< -o loop

loop.o: $(SRC)
	$(ASM) $< -f elf64
