nasm ipl.asm -o ipl.bin
nasm papier.asm -o disk/papier.sys
mkfloppy -b ipl.bin -d disk papieros.img
