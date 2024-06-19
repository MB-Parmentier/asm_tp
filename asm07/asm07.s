global _start

section .bss

	input resw 5
	buffer resb 20

section .data

	zr db '0'

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

	cmp word[rsi],0 ; vérifier si l'input est vide
	je error

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
	; NOMBRE DANS R13

	; contrôler le zéro
	mov rax,0
	mov r9,1
	cmp r13,0
	je zero

addition:

	; r8 = compteur 1
	; r9 = compteur 2
	cmp r9,r13
	je done
	;inc r9
	add r8,r9
	inc r9
	jmp addition

done:

	; NOMBRE DANS R8
  ; conversion en ASCII
	mov rax,r8
	lea rsi, [buffer + 19]
	mov byte [rsi], 0
	mov rbx, 10

itoa:
	;dec rsi
	xor rdx, rdx
	div rbx
	add dl, '0'
	dec rsi
	mov [rsi], dl
	test rax, rax
	jnz itoa

print:

	; rsi pointe maintenant sur le début de la chaîne convertie
	mov rax, 1    ; Appel système pour écrire
	mov rdi, 1    ; Sortie standard
	mov rdx, buffer + 20 ; Calculer la longueur de la chaîne
	sub rdx, rsi
	syscall       ; Afficher la chaîne


exit:
	mov rax,60
	mov rdi,0
	syscall

error:

	mov rax,60
	mov rdi,1
	syscall

zero:

	mov rax,1
	mov rdi,1
	mov rsi,zr
	mov rdx,1
	syscall
	jmp exit
