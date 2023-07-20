section .text
    global get_words
    global compare_func
    global sort
    extern qsort
    extern strcmp
    format db "%d", 10, 0
section .text

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix

compare_func:
    enter 0, 0
    ; preserve registrez in the stack
    push edi
    push esi
    push edx
    push ecx
    push ebx

    ; Get the pointers to the words
    mov eax, [ebp + 8] ; ebx = pointer to a
    mov ebx, [ebp + 12] ; eax = pointer to b

    mov eax, dword [eax]
    mov ebx, dword [ebx]

    xor edi, edi ; length for first word
length1:
    mov cl, byte [eax + edi]
    cmp cl, 0
    je out1
    inc edi
    jmp length1

out1:

    xor esi, esi ; length for second word
length2:
    mov dl, byte [ebx + esi]
    cmp dl, 0
    je out2
    inc esi
    jmp length2

out2:

    ; Compare the lengths
    cmp edi, esi
    jne substract

    ; if they are equal, compare lexico
    ; use strcmp
    push ebx
    push eax
    call strcmp
    add esp, 8
    jmp compare_func_done

substract:
    sub edi, esi
    mov eax, edi
compare_func_done:

    ; clear the stack
    pop ebx
    pop ecx
    pop edx
    pop esi
    pop edi
    leave
    ret

sort:
    enter 0, 0
    pusha

    ; Get the arguments
    mov edx, [ebp + 8]  ; edx = pointer to words
    mov ecx, [ebp + 12] ; ecx = number_of_words
    mov ebx, [ebp + 16] ; ebx = size

    ; Call qsort
    push compare_func   ; push the comparison function
    push ebx            ; size
    push ecx            ; number of elements
    push edx            ; pointer to words
    call qsort

    add esp, 16         ; Cleanup stack after qsort call

    popa
    leave
    ret


;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0
    mov eax, dword [ebp + 8] ;  esi = text
    mov edx, dword [ebp + 12] ; edx = words
    mov ecx, dword [ebp + 16] ; ecx = nr_word
    pusha

    xor ebx, ebx ; index for the words
    xor esi, esi ; index for the text
    dec esi
loop1:
    xor edi, edi
skip_delim:
    inc esi
    cmp byte [eax + esi], ' '
    je skip_delim
    cmp byte [eax + esi], '.'
    je skip_delim
    cmp byte [eax + esi], ','
    je skip_delim

    push ecx
    mov ecx, dword [edx + 4 * ebx]
    push ebx
copy_word:
    mov bl, byte [eax + esi]  ; get char from text
    mov byte [ecx + edi], bl  ; put char in word 
    inc edi
    inc esi
    ; check for delimitator
    cmp bl, ' '
    je put_endword
    cmp bl, ','
    je put_endword
    cmp bl, '.'
    je put_endword
    cmp bl, 0
    je put_endword
    jmp copy_word
put_endword:
    dec edi
    dec esi
    mov byte [ecx + edi], 0 ; put terminator
    pop ebx ; restore the reigistres
    mov dword [edx + 4 * ebx], ecx
    pop ecx ; restor ecx
    inc ebx
    cmp ebx, ecx
    jl loop1 ; go to the next word, but keep the index for the text


    popa
    leave
    ret
