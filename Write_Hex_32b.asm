[bits 32];Receive data from EDX
printhex_32b:
	sub sp,11
	mov word [esp],'0x'
	add sp,2
	
	mov ebx,0xf0000000
	mov cl,28;shr Digit
	;mov ch,0x00;require push flag
	push_bit_loop:
		mov eax,edx
		and eax,ebx;Fetch highest bit
		
		shr eax,cl
		shr ebx,4
		
		cmp al,0x09
		jg deal_alpha_32b
		deal_digit_32b:
			add al,48
			jmp end_deal_bit
		deal_alpha_32b:
			add al,87
		end_deal_bit:
		
		mov [ss:esp],al
		add esp,1
		
		cmp cl,0
		je push_bit_loop_end
		sub cl,4
		jmp push_bit_loop
	push_bit_loop_end:
	mov byte [esp],0x00;0x7e9e
	add sp,1
	
	sub esp,11
	mov ebx,esp
	call printf_char_32b
	add esp,11;0x7eb0
	ret

cnt_ones_16b:;receive data from dx
	mov bx,0x8000
	mov cx,0x000f

	:st
	mov ax,dx
	and ax,bx
	shr ax,cl
	cmp ax,0
	je fin_add
	inc ch
	:fin_add
	shr bx,1
	dec cx
	cmp bx,0
	jne st
	inc cx;cl=0-1+1
;%include "C:\\Download\\OSDev\\Write_String.asm"