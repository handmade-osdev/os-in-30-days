; Description of the FAT-12 floppy disk
DB 0xeb, 0x4e, 0x90
DB "HELLOIPL"            ; Name of boot sector (8 bytes)    (choose any)
DW 512                   ; Sector size in bytes             (don't change)
DB 1                     ; Size of cluster                  (don't change)
DW 1                     ; FAT start sector
DB 2                     ; Number of FAT's                  (don't change)
DW 224                   ; Number of root directory entries
DW 2880                  ; Size of disk in sectors          (don't change)
DB 0xf0                  ; Media type                       (don't change)
DW 9                     ; Sectors per FAT                  (don't change)
DW 18                    ; Sectors per track                (don't change)
DW 2                     ; Number of heads                  (don't change)
DD 0                     ; LBA of first partition           (don't change)
DD 2880                  ; Size of disk in sectors (again)  (don't change)
DB 0,0,0x29              ; Some stuff                       (don't change)
DD 0xffffffff            ; Volume serial                    (choose any)
DB "HELLO-OS   "         ; Disk labbel (11 bytes)           (choose any)
DB "FAT12   "            ; Filesystem name                  (don't change)
RESB 18

; The program
DB 0xb8, 0x00, 0x00, 0x8e, 0xd0, 0xbc, 0x00, 0x7c
DB 0x8e, 0xd8, 0x8e, 0xc0, 0xbe, 0x74, 0x7c, 0x8a
DB 0x04, 0x83, 0xc6, 0x01, 0x3c, 0x00, 0x74, 0x09
DB 0xb4, 0x0e, 0xbb, 0x0f, 0x00, 0xcd, 0x10, 0xeb
DB 0xee, 0xf4, 0xeb, 0xfd

; The messages
DB 0x0a, 0x0a                ; Two line breaks
DB "hello, world"
DB 0x0a                      ; Line break
DB 0

TIMES 0x1fe-($-$$) DB 0x00   ; Filling up 0x00 until 0x1fe
DB 0x55, 0xaa

; Not boot sector
DB 0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
RESB 4600
DB 0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
RESB 1469432
