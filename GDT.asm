CODE_SEG equ gdt_code - gdt_struct_start
DATA_SEG equ gdt_data - gdt_struct_start

gdt_struct_start:

gdt_null:
	dd 0x00000000
	dd 0x00000000

gdt_code:
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10011010b
	db 11001111b
	db 0x00

gdt_data:
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10010010b
	db 11001111b
	db 0x00
	
gdt_end:

gdt_descriptor:
	dw gdt_end-gdt_struct_start-1
	dd gdt_struct_start
	


[bits 16]
enter_PM:
	cli
load_gdt:
	lgdt [gdt_descriptor]
	
	mov eax,cr0
	or eax,0x01
	mov cr0,eax
	;ret
	jmp CODE_SEG:init_pm

[bits 32]
init_pm:
	mov ax,DATA_SEG ; Now in PM , our old segments are meaningless ,
	mov ds,ax ; so we point our segment registers to the
	;mov ax,0x0
	mov ss,ax ; data selector we defined in our GDT
	mov ax,DATA_SEG
	mov es,ax
	mov fs,ax
	mov gs,ax
	mov ebp,0x90000 ; Update our stack position so it is right
	mov esp,ebp

	call PM_Start;in bootsect.asm
	;ret

