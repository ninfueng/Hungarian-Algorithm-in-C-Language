CC      := riscv32-unknown-elf-gcc
LD      := riscv32-unknown-elf-ld
OBJCOPY := riscv32-unknown-elf-objcopy
OBJDUMP := riscv32-unknown-elf-objdump

all: main.hex main2.hex

main2.hex: main.elf
	$(OBJDUMP) -d  main.elf > main2.hex

main.hex: main.bin
	hexdump -v -e '1/4 "%08x" "\n"' main.bin > main.hex

main.bin: main.elf
	$(OBJCOPY) -O binary main.elf main.bin

main.elf: main.o
	$(LD) -Tlink.ld -o main.elf main.o

main.o: main.c
	$(CC) -g -c -O3 -fno-builtin -march=rv32im -Wall $(CFLAGS) -x c -o main.o  main.c

clean:
	rm -f main.o
	rm -f main.bin
	rm -f main.elf
	rm -f main.hex
	rm -f main2.hex
