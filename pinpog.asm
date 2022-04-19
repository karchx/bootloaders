	org 0x7C00
%define WIDTH   320
%define HEIGHT  200
%define COLUMNS 40
%define ROWS    25

%define COLOR_BLACK  				0
%define COLOR_BLUE   				1
%define COLOR_GREEN  				2
%define COLOR_CYAN   				3
%define COLOR_RED      			4
%define COLOR_MAGENTA   		5
%define COLOR_BROWN  				6
%define COLOR_LIGHTGRAY  		7
%define COLOR_DARKGRAY  		8
%define COLOR_LIGHTBLUE  		9
%define COLOR_LIGHTGREEN 		10
%define COLOR_LIGHTCYAN  		11
%define COLOR_LIGHTRED 		  12
%define COLOR_LIGHTMAGENTA 	13
%define COLOR_YELLOW 		  	14
%define COLOR_WHITE 		  	15

%define BACKGROUND_COLOR COLOR_BLACK

%define BALL_WIDTH  	16
%define BALL_HEIGHT 	16
%define BALL_VELOCITY 16
%define BAR_VELOCITY  10

%define VGA_OFFSET 0xA00 	; direccion del vga

%define SCORE_DIGIT_COUNT 5

struc GameState
  .running: resb 1
  .ball_x: resw 1
  .ball_y: resw 1
  .ball_dx: resw 1
  .ball_dy: resw 1
  .bar_x: resw 1
  .bar_y: resw 1
  .bar_dw: resw 1
  .score_sign resb SCORE_DIGIT_COUNT
endstruc

entry:
  ; VGA mode 0x13
  ; 320x200 256 colors
  mov ax, 0x13
  int 0x10

  xor ax, ax
  mov es, ax
  mov ds, ax
  mov cs, GameState_size
  mov si, initial_game_state
  mov di, game_state
  rep movsb
  
  mov dword [0x0070], draw_frame
.loop:
	hlt
	mov ah, 0x1
	int 0x16
	jz .loop

	xor ah, ah
	int 0x16

	cmp al, 'a'
	jz .swipe_left

	cmp al, 'd'
	jz .swipe_right

	cmp al, ' '
	jz .toggle_pause

	cmp al, 'f'
	jz entry

	jmp .loop

.swipe_left:
	mov word [game_state + GameState.bar_dx], - BAR_VELOCITY
	jmp .loop
.swipe_right:
	mov word [game_state + GameState.bar_dx], - BAR_VELOCITY
	jmp .loop

.toogle_pause:
	not byte [game_state + GameState.running]
	jmp .loop

draw_frame:
  pusha

  xor ax, ax
  mov ds, ax

  mov es, ax
  mov ah, 0x13
  mov bx, 0x0064
  mov cl, SCORE_DIGIT_COUNT
  mov dx, dx
  mov bp, game_state + GameState.score_sign
  int 10h

  mov ax, VGA_OFFSET
  mov es, ax
  test byte [game_state + GateState.running], 1
  jz stop_state

stop_state:
  popa
  iret

