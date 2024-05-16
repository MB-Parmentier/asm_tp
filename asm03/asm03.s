global _start
 
section .data
	value: db '1337',10
 
section .text
 
_start:

	pop rax
	cmp rax, 1 ; nb d'elem
	jne noteq
 
	mov r8,[rsp+16]
 
	mov rax,1
	mov rdi,0
	mov rsi,value
	mov rdx,5
	syscall
 
	mov al,[r8]
	cmp al,'4'
	jne noteq
 
	mov al,[r8+1]
	cmp al,'2'
	jne noteq
 
	mov al,[r8+2]
	cmp al,0
	jne noteq

	mov rax,1
	mov rdi,0
	mov rsi,value
	mov rdx,5
	syscall
 
	mov rax,60
	mov rdi,0
	syscall
 
noteq:
 
	mov rax,60
	mov rdi,1
	syscall
 
