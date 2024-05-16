global _start
 
section .data
 
	value: dw '1337',10
 
section .bss
 
	number: resw 10
 
section .text
 
_start:
 
	; affichage de 1337 à ajouter
	mov rax,1
	mov rdi,0
	mov rsi,value
	mov rdx,5
	syscall
 
	mov rax,0
	mov rdi,0
	mov rsi, number
	mov rdx,10
	syscall
 
comparison:
 
	cmp byte [rsi],'4'
	jne exitnoteq
 
equal:
 
	cmp byte [rsi+1],'2'
	jne exitnoteq
 
	cmp byte [rsi+2],0xa
	jne exitnoteq
 
exit:
	mov rax,60
	mov rdi,0
	syscall
 
exitnoteq:
	mov rax,60
	mov rdi,1
	syscall
 
