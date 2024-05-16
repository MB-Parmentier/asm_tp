global _start
 
section .data
 
	value: dw '1337',10
	msg_neq: db 'notequal',10
	msg_eq: db 'equal',10
 
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
 
	;mov ax,'4'
	cmp byte [rsi],'4'
	jne notequal
 
equal:
 
	cmp byte [rsi+1],'2'
	jne notequal
 
	mov rax,1
	mov rsi,1
	mov rdi,msg_eq
	mov rdx,6
	syscall
	jmp exit
 
notequal:
 
	mov rax,1
	mov rsi,1
	mov rdi,msg_neq
	mov rdx,9
	syscall
	jmp exitnoteq
 
exit:
	mov rax,60
	mov rdi,0
	syscall
 
exitnoteq:
	mov rax,60
	mov rdi,1
	syscall
