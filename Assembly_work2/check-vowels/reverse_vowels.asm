section .data
	; declare global vars here

section .text
	global reverse_vowels
	extern strchr
	extern printf

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:
	; get the stack
	push ebp
	push esp
	pop ebp
	pusha ; push all the registres 

	push dword [ebp + 8]
	pop edx ; edx = string

	xor ebx, ebx ; index for the characters in the string
get_vowels:
	cmp byte [edx + ebx], 0
	je out1 ; end loop if it is terminator
	; check if it is vowel
	cmp byte [edx + ebx], 'a'
	je store_stack
	cmp byte [edx + ebx], 'e'
	je store_stack
	cmp byte [edx + ebx], 'i'
	je store_stack
	cmp byte [edx + ebx], 'o'
	je store_stack
	cmp byte [edx + ebx], 'u'
	je store_stack

next_loop_step:
	inc ebx ; go to the next letter
	jmp get_vowels

store_stack:
	; push in the stack the vowel
	push word [edx + ebx]
	; get back to the loop
	jmp next_loop_step

out1: ; end of the first loop

	xor ebx, ebx ; refresh the index
put_vowels:
	cmp byte [edx + ebx], 0
	je out2 ; check if it is end of word
	; check if it is a vowel
	cmp byte [edx + ebx], 'a'
	je pop_stack
	cmp byte [edx + ebx], 'e'
	je pop_stack
	cmp byte [edx + ebx], 'i'
	je pop_stack
	cmp byte [edx + ebx], 'o'
	je pop_stack
	cmp byte [edx + ebx], 'u'
	je pop_stack

next_loop_step2:
	inc ebx
	jmp put_vowels

pop_stack:
	; put the vowel from the stack in the string
	pop cx ; put in a registre
	xor eax, eax ; get an auxiliar one and make it 0
	and byte [edx + ebx], al ; make the character from the string 0
	add byte [edx + ebx], cl ; add the character from the stack in the string
	jmp next_loop_step2  ; go back to loop
out2:

	popa  ; pop all the registres
	; make the leave function
	push ebp
	pop esp
	pop ebp
	ret
