org 0x0100 				; The entry address to copy the code to

start:
	mov ax, 0x0002 	; Set 80-25 text mode
	int 0x10

	mov ax, 0xb800 	; Segment for the video data
	mov es, ax
	cld

exit:
	int 0x20

draw-box:
	mov bp, sb
