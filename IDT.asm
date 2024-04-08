[bits 32]
interupt_Gate_Consts:
	SelectorOne equ 0000000000001000b;Seg Selector
	Flags equ 1000111000000000b;Const+SelectorOne
	OffsetH equ 0x0000;Offset High16b
	IDT_BASE_ADDR equ 0x5000;IDT Base Addr=5000h
loadCustomInts:
	
	;Write Int Location
	mov DWord [IDT_BASE_ADDR+70h*8h+0],interupt70
	mov DWord [IDT_BASE_ADDR+70h*8h+2],SelectorOne
	mov DWord [IDT_BASE_ADDR+70h*8h+4],Flags
	mov DWord [IDT_BASE_ADDR+70h*8h+6],OffsetH
	
	mov DWord [IDT_BASE_ADDR+71h*8h+0],interupt71
	mov DWord [IDT_BASE_ADDR+71h*8h+2],SelectorOne
	mov DWord [IDT_BASE_ADDR+71h*8h+4],Flags
	mov DWord [IDT_BASE_ADDR+71h*8h+6],OffsetH
	
	mov DWord [IDT_BASE_ADDR+21h*8h+0],interupt21
	mov DWord [IDT_BASE_ADDR+21h*8h+2],SelectorOne
	mov DWord [IDT_BASE_ADDR+21h*8h+4],Flags
	mov DWord [IDT_BASE_ADDR+21h*8h+6],OffsetH
	;End Write Int Location
	
	;Load IDTR
	cli
	lidt [IDTR_Structure]
	ret
	
interupt70:
	iret
	dw 0xacad,0
interupt70end:nop

interupt71:
	iret
interupt71end:nop

interupt21:;KEYBOARD?!
	mov byte [0xb80000],'P'
	mov edx,0x1234abcd
	call printhex_32b
	iret
interupt21end:

	
IDTR_Structure:
	dw 2000h;Size Limit
	dd IDT_BASE_ADDR;IDT_BASE_ADDR;Base Addr
IDTR_Structure_End: