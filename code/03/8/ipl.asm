ORG 0x7c00

CYLS equ 10              ; Read until CYLS

JMP entry
DB 0x90

; Description of the FAT-12 floppy disk
DB "PAPIEROS"            ; Name of boot sector (8 bytes)    (choose any)
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
DB "PAPIER OS! "         ; Disk labbel (11 bytes)           (choose any)
DB "FAT12   "            ; Filesystem name                  (don't change)
RESB 18

; The program
entry:
    MOV AX, 0                ; Register initialization
    MOV SS, AX
    MOV SP, 0x7c00
    MOV DS, AX

; Read the disk
    MOV AX, 0x0820
    MOV ES, AX
    MOV CH, 0                ; Cylinder 0
    MOV DH, 0                ; Head 0
    MOV CL, 2                ; Sector 2
readloop:
    MOV SI, 0                ; Register to count number of failures
retry:
    MOV AH, 0x02             ; AH=02h: read the disk
    MOV AL, 1                ; 1 Sector
    MOV BX, 0
    MOV DL, 0x00             ; Floppy A
    INT 0x13                 ; Call BIOS Disk function
    JNC next
    ADD SI, 1
    CMP SI, 5                ; If the number of failures reaches 5, admit error
    JE error
    MOV AH, 0x00
    MOV DL, 0x00
    INT 0x13                 ; Reset drive
    JMP retry
next:
    MOV AX, ES
    ADD AX, 0x20             ; Advance the address by 0x200
    MOV ES, AX
    ADD CL, 1
    CMP CL, 18
    JBE readloop             ; continue reading while CL <= 18
    MOV CL, 1
    ADD DH, 1
    CMP DH, 2
    JB readloop              ; repeat while DH < 2
    MOV DH, 0
    ADD CH, 1
    CMP CH, CYLS
    JB readloop              ; repeat while CH < CYLS
fin:
	MOV BYTE[0x0ff0], CH
	JMP 0xc200               ; execute papier.sys!

error:
    MOV SI, msg
putloop:
    MOV AL, [SI]
    ADD SI, 1                ; Add 1 to SI
    CMP AL, 0
    JE fin
    MOV AH, 0x0e,            ; Display one character function
    MOV BX, 15               ; Color code
    INT 0x10                 ; Call to BIOS
    JMP putloop

; The messages
msg:
    DB 0x0a, 0x0a            ; Two line breaks
    DB "load error"
    DB 0x0a                  ; Line break
    DB 0

TIMES 0x1fe-($-$$) DB 0x00   ; Filling up 0x00 until 0x1fe
DB 0x55, 0xaa
