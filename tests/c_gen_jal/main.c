
int sub(int a, int b);

void main(void)
{
	int a = 10;
	int b = 20;
	int c = sub(a, b);
	return;
}

int sub(int a, int b)
{
	return a-b;
}
/**
 * COMPILING + LINKING
 * riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -O0 -nostartfiles -nostdlib \
    -T link.ld main.c -o main.elf
 * ELF to raw binary:
 * riscv32-unknown-elf-objcopy main.elf -O binary main.bin
 * Raw binary to one-32bit-word-per-line hex:
 * hexdump -v -e '1/4 "%08x\n"' main.bin > main.hex
 * 
riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -O0 -nostartfiles -nostdlib -T link.ld main.c -o main.elf
riscv32-unknown-elf-objcopy main.elf -O binary main.bin
hexdump -v -e '1/4 "%08x\n"' main.bin > main.hex
 */


/**
 * DISASEMBLING
riscv32-unknown-elf-objdump -d main.elf > main.txt
 */