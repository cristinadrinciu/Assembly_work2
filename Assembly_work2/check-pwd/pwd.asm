section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0
	; declare global vars here

section .text
	extern strcmp
	global pwd

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories
pwd:
	enter 0, 0
	pusha
	mov edi, [ebp + 8]  ; edi = directories
    mov ecx, [ebp + 12] ; ecx = n
    mov esi, [ebp + 16] ; esi = output

    xor ebx, ebx
    lea ebx, [esi] ; Initialize ebx with the output buffer address
    mov byte [esi], '/'

    xor edx, edx ; the index through the directories

loop1:
    cmp edx, ecx  ; Check if edx is equal to n (boundary condition)
    jge end

    ; first verify if it is .. or .
    xor eax, eax
    mov ecx, dword [edi + 4 * edx]

    push edx ; Preserve edx

    push ecx
    push back
    call strcmp
    add esp, 8 ; Adjust the stack pointer
    test eax, eax
    jz go_back

    pop edx  ; Restore edx

    mov ecx, dword [edi + 4 * edx]

    push edx ; Preserve edx

    push ecx
    push curr
    call strcmp
    add esp, 8 ; Adjust the stack pointer
    test eax, eax
    jz next_step

    pop edx ; Restore edx
    ; if it is a word, concatenate to the output
    push edx  ; preserve edx
    xor edx, edx
    xor eax, eax ; index for the source

copy_source:
    mov dl, byte [esi + eax] ; take letter from source
    mov byte [ebx + eax], dl ; put in destination
    inc eax
    test dl, dl
    jnz copy_source
    
    pop edx
    mov ecx, dword [edi + 4 * edx]
	push edx
	push edi

	xor edi, edi ; index for the directory
	dec eax
copy_directory:
	mov dl, byte [ecx + edi] ; take letter from directory
	mov byte [ebx + eax], dl ; put in destination
	inc eax
	inc edi
	test dl, dl
	jnz copy_directory

	dec eax
	mov byte [ebx + eax], '/' ; add / for directory
	inc eax
	mov byte [ebx + eax], 0 ; add terminator
	pop edi
	pop edx
	push edx

	mov esi, ebx

	jmp next_step
	
go_back:
	pop edx  ; Restore edx
    push edx  ; preserve edx
    xor edx, edx
    xor eax, eax ; index for the source
	inc eax
	mov dl, byte [esi + eax]
	test dl, dl
	jz next_step
	xor edx, edx
	xor eax, eax
loop2:
	mov dl, byte [esi + eax] ; copy the output that already exists
	mov byte [ebx + eax], dl ; put in destination
	inc eax
	test dl, dl
	jnz loop2

	dec eax
	mov byte [ebx + eax], 0 ; remove the /
	dec eax
	mov byte [ebx + eax], 0
	dec eax
remove_directory:
	mov dl, byte [ebx + eax] ; remove letter by leter until /
	cmp dl, '/'
	je next_step
	mov byte [ebx + eax], 0
	dec eax
	jmp remove_directory

next_step:
	pop edx ; restore index for directories
    mov ecx, [ebp + 12] ; restore number of directories
	mov esi, ebx
    inc edx
	cmp edx, ecx
    jl loop1
	jmp end

end:
	popa
	leave
	ret