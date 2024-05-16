global _start

section .data
	value:dd '1337'

section .text

_start:
	mov rax,1
	mov rdi,1
	mov rsi,value
	mov rdx,5
	syscall

	mov rax,60
	mov rdi,0
	syscall
