global _start

section .data

	value: dw '1337'

section .bss

	number: resw 10 ; entrée de l'utilisateur

section .text

_start:
	mov rax,0
	mov rdi,0
	mov rsi, number
	mov rdx,10
	syscall

comparison:

	cmp byte [rsi],'4'
	jne exitnoteq
	; premier chiffre = 4
equal:

	cmp byte [rsi+1],'2'
	jne exitnoteq
 	; premier chiffre = 2

	cmp byte [rsi+2],0xa
	jne exitnoteq
 	; pas de troisième chiffre

 	; affichage de 1337 si input = 42
	mov rax,1
	mov rdi,1
	mov rsi,value
	mov rdx,4
	syscall

exit:
	mov rax,60
	mov rdi,0
	syscall

exitnoteq:
	mov rax,60
	mov rdi,1
	syscall
