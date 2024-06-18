global _start

section .bss

	input resw 5
	racine resq 1

section .data

section .text

_start:

	mov rax,0
	mov rdi,0
	mov rsi,input
	mov rdx,5
	syscall

        ; Supprimer le caractère de nouvelle ligne
        mov rbx, input
        mov rcx, 5 ; Longueur maximale de l'entrée

remove_newline:
        cmp byte [rbx], 0xa ; Vérifier si le caractère est \n
        je replace_newline
        inc rbx
        loop remove_newline
        jmp continue

replace_newline:
        mov byte [rbx], 0 ; Remplacer \n par \0
        jmp continue

continue:

	mov rdi,rsi
	mov rdx,0
atoi:
   	mov rax, 0
	atoi_loop:
        	movzx rdx, byte [rdi]
	        test rdx, rdx
        	jz atoi_done
	        sub rdx, '0'
	        imul rax, rax, 10
        	add rax, rdx
	        inc rdi
        	jmp atoi_loop
	atoi_done:
	mov r13,rax

	;call atoi
	;mov r8,rax
	; NOMBRE DANS R13
	mov rax,0

boucle:

	cmp rax,r13
	je error
	jg fin_boucle
	inc r9
	mov rax,r9
	mul r9
	jmp boucle

fin_boucle:

	; R9 > RACINE
	mov [racine],r9
	mov r9,0
	; r8 = compteur 1
	; r9 = compteur 2
	jmp loop_start

loop_:

	inc r8
	mov rax,r8
	mul r9
	cmp rax,r13
	je error
	inc r9
	mov rax,r8
	mul r9
	cmp rax,r13
	je error
	cmp r8,[racine]
	je exit
	jmp loop_

loop_start:

	mov r8,2
	mov r9,2
loop:
	mov rax,r8
	mul r9
	cmp rax,r13
	je error
	jg exit
	cmp r9,r13
	je suite
	inc r9
	jmp loop
suite:
	inc r8
	mov r9,2
	jmp loop

	jmp exit

atoi_: 
    mov rax, 0
    atoi_loop_: 
        movzx rdx, byte [rdi]
        test rdx, rdx
        jz atoi_done
        sub rdx, '0' 
        imul rax, rax, 10
        add rax, rdx 
        inc rdi
        jmp atoi_loop
    atoi_done_:
        ret

exit:
	mov rax,60
	mov rdi,0
	syscall

error:
	mov rax,60
	mov rdi,1
	syscall
