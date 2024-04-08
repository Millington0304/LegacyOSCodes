[bits 32]
VIDEO_MEMORY equ 0xb8000	;@ 0xb8000+2*(Row*80+col)
WB_COLOR_MODE equ 0x0f

printf_char_32b:
	pusha
	mov edx,VIDEO_MEMORY
printf_char_32b_loop:
	mov al,[ebx]
	mov ah,WB_COLOR_MODE
	
	cmp al,0	;EOS?
	je printf_char_32b_done
	
	mov [edx],ax
	
	add ebx,1
	add edx,2
	
	jmp printf_char_32b_loop
printf_char_32b_done:
	popa
	ret

[bits 16]
print_char :
	mov ah,0x0e ; int =10/ ah =0 x0e -> BIOS tele - type output
	int 0x10 ; print the character in al
	ret
	
print_string:
	mov ah,0x0e
	printstr_start:
	cmp cx,0
	je printstr_end
	mov al,[bx]
	int 0x10
	dec cx
	inc bx
	jmp printstr_start
	printstr_end:
	ret
