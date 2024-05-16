global _start
 
section .data
 
	cpt: db 0x0
 
section .bss
 
	number: resw 5
 
section .text
 
_start:
 
	;Inviter l'utilisateur à saisir un nombre
 
	mov rax,0
	mov rdi,0
	mov rsi,number
	mov rdx,5
	syscall
 
lun:
 
	mov r8,[rsi]
	inc rsi
	cmp byte[rsi],0x30
	jb mar
	cmp byte[rsi],0x39
	ja mar
	jmp lun
 
	; r8 contient "0xaXX"
mar:
 
	sub r8,0xa30
	jmp mer
 
mardi:
 
	mov rcx,1
	and r8,rcx
 
mer:
 
	cmp r8,0
	je normal
	cmp r8,2
	je normal
        cmp r8,4
        je normal
        cmp r8,6
        je normal
        cmp r8,8
        je normal
	jmp exit
 
	mov rax,0
	jmp compar
 
dinc:
	;inc al
	;inc al
	inc rax
	inc rax
 
compar:
 
	cmp rax,rsi
	jl dinc
	je normal
	jne exit
 
normal:
 
	mov rax,60
	mov rdi,0
	syscall
 
exit:
	mov rax,60
	mov rdi,1
	syscall
 
