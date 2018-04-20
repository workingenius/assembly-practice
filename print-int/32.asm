global start

section .text
start:
	mov	eax, 4543

	push	dword 10  ; end symbol
	; mov	ebx, eax
	mov	ecx, 10

div:	mov	edx, 0
	idiv	ecx
	push	edx
	cmp	eax, 0
	je	bf
	jmp	div

; copy to buffer
bf:	mov	ebx, 0  ; buffer offset
bfloop:	pop	ecx
	cmp	ecx, 10  ; is end symbol or not
	jge	nl       ; is end symbol
	add	ecx, 48  ; num to a ascii char
	mov	[buffer + ebx], ecx
	inc	ebx
	jmp	bfloop

; append a newline
nl:	mov	[buffer + ebx], byte 10
	inc	ebx
	jmp	print

print:	push	ebx
	push	dword buffer
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
buffer:	times 10	db 0

