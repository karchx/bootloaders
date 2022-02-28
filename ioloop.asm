bits 16
org 0x7c00

main:
	; clear screen
	mov ah, 0x00
	mov al, 0x03
	int 0x10

.loop:
	mov ah, 0
	int 0x16

	;; Print character
	mov ah, 0x0e
	int 0x10

	jmp .loop

times 510 - ($-$$) db 0
dw 0xaa55

