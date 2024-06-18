global _start

section .bss

	arg1 resq 4
	arg2 resq 4
	val resb 6

section .text

_start:

	pop rax
	cmp rax,3
	jne error

	pop rsi

	pop r8 ;arg1
	pop r9 ;arg2

	xor rax,rax

	mov [arg1] ,r8
	mov [arg2] ,r9

	; Vérifier que le nombre est un nombre !!!!!!!!!!!!!!

	mov rdi, [arg1]

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
	mov [arg1],rax

; Récupérer l'autre argument --------------------

	mov rdi,[arg2]

atoi2:
	mov rax,0
	atoi_loop2:
		movzx rdx,byte[rdi]
		test rdx,rdx
		jz atoi_done2
		sub rdx,'0'
		imul rax,rax,10
		add rax,rdx
		inc rdi
		jmp atoi_loop2
	atoi_done2:
		; valeur dans rax

addition:

	add rax,[arg1]
	;mov r13,rax
	mov rdi,rax

itoa:

	mov rcx,0
	mov rcx,10
	mov r13,0

	itoa_loop:
		cmp rax,10
		jl itoa_done
		div rcx ; diviser nb par 10
		quotient:
		add rdx,'0'
		mov [val+r13],rdx
		xor rdx,rdx
		inc r13
		;inc rdi
		jmp itoa_loop
	itoa_done:
		; valeur dans rax
		add rax,'0'
		mov [val+r13],rax

affichage:

	cmp r13,0
	jl exit

        movzx rsi,byte[val+r13]
	mov [buffer],rsi
	mov byte[buffer+1],0

	mov rax,1
	mov rdi,1
	mov rsi,buffer
	mov rdx,2
	syscall

	dec r13
	jmp affichage ; affichage des caractères à l'envers du tableau

exit:

	mov rax,60
	mov rdi,0
	syscall

error:
	mov rax,60
	mov rdi,1
	syscall

section .bss

	buffer resb 2
