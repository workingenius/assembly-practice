; env nasm -f macho 32.asm && ld -macosx_version_min 10.7.0 -o 32 32.o && ./32

global start

section .text
start:
	mov	eax, a
	mov	ebx, b

	cmp	eax, ebx
	jl	noswap
swap:	push	ecx
	mov	ecx, eax
	mov	eax, ebx
	mov	ebx, ecx
	pop	ecx

noswap:	mov	edx, 0
	idiv	ebx
	cmp	edx, 0
	je	fin
	mov	ebx, edx
	jmp	swap

fin:	cmp	eax, 2
	je	print

print:	push	dword msg.len
	push	dword msg
	push	dword 1
	mov	eax, 4
	sub	esp, 4
	int	0x80
	add	esp, 16

	push	dword 0
	mov	eax, 1
	sub	esp, 12
	int	0x80

section .data

a:	dw	4
b:	dw	2
msg:	db	"H", 1
.len:	equ	$ - msg


