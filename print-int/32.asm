global start

section .text
func_print:
	; print a 32-bit unsigned integer

	; base pointer
	push	ebp
	mov	ebp, esp

	; local vars

	; callee-saved site
	push	ebx
	push	edi
	push	esi

	; int to be printed
	mov	eax, dword [ebp + 8]  ; as the first arg

	push	dword 10  ; end symbol
	mov	ecx, 10   ; divider, divide by 10 each time

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
	inc	ebx      ; buffer length, is buffer offset + 1
	jmp	print

print:	push	ebx
	push	dword buffer
	push	dword 1
	mov	eax, 4
	sub	esp, 4
	int	0x80
	add	esp, 16

	; return in eax, nothing

	; restore callee-saved registers
	pop	esi
	pop	edi
	pop	ebx

	; deallocate local vars, nothing

	; restore ebp
	pop	ebp

	; return to caller
	ret


start:
	; print a 32-bit unsigned int at eax
	mov	eax, 4959

	; save caller-saved site
	push	eax
	push	ebx
	push	ecx

	; parameters
	push	eax
	
	call	func_print

	; remove parameters
	add	esp, 4

	; restore caller-saved site
	add	esp, 12

	push	dword 0
	mov	eax, 1
	sub	esp, 12
	int	0x80

section .data
buffer:	times 33	db 0

