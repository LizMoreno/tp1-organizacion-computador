nasm -f elf32 fresolvente.asm -o resolvente1.o
sudo gcc -m32 fresolvente.c resolvente1.o -o resolvente1
./resolvente1
