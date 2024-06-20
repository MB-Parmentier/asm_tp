global _start

section .bss

	bin resb 15
	lng resb 5
	buffer resb 20

section .data

section .text

	; ----------------------
	; Ce code prend un nombre binaire en paramètre
	; Et renvoie la version décimale
	; ----------------------

_start:

	pop r8 ; argc
	pop rsi ; chemin script
	pop r9 ; nombre
	mov [bin],r9

	mov r8,0

longueur:

	; obtenir la longueur de la chaîne
	inc r8
	cmp byte[r9+r8],0
	jne longueur

	; r8 = longueur de la chaîne
	mov [lng],r8

	; r8 = compteur 1 (nombre décimal)
	; r9 = compteur 2 (puissance de 2)
	; gestion du bit de poids faible (2⁰)

	mov r15,0 ; décalage
	mov r14,1 ; puissance 2
	mov r13,0 ; décimal

boucle:
	mov al, [r9 + r15]  ; Charger le bit courant
	cmp al, '1'
	jne skip_add
	add r13, r14        ; Ajouter la puissance de 2 si le bit est 1

skip_add:
	shl r14, 1          ; Multiplier la puissance de 2 par 2
	inc r15             ; Passer au bit suivant
	cmp r15, r8         ; Vérifier si on a traité tous les bits
	jle boucle

fin:

	; NOMBRE DANS R13
	mov rax,r13
	lea rsi, [buffer + 19]
	mov byte [rsi], 0
	mov rbx, 10

itoa:
	; Conversion en ASCII pour affichage
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
