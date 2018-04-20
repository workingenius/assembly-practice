; /usr/local/bin/nasm -f macho64 64.asm && ld -macosx_version_min 10.7.0 -lSystem -o 64 64.o && ./64

global start

section .text

start:
	mov	rax, a
	mov	rbx, b

	cmp	eax, ebx
	jl	noswap
swap:	push	rcx
	mov	ecx, eax
	mov	eax, ebx
	mov	ebx, ecx
	pop	rcx

noswap:	mov	edx, 0
	idiv	ebx
	cmp	edx, 0
	je	fin
	jmp	swap

fin:	mov	rax, 0x2000004 ; write
	mov	rdi, 1 ; stdout
	mov	rsi, eax
	mov	rdx, 4

	mov	rax, 0x20000001 ; exit
	mov	rdi, 0
	syscall

section .data

a:	dw	4
b:	dw	2

