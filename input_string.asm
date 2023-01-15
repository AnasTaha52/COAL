dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
arr db 100 dup("$")
inputs db "Enter String :: $"
s2 db "String :: $"
.code
main proc
mov ax , @data
mov ds , ax
print inputs
mov si , offset arr
l1:
mov ah , 1
int 21h
mov [si] , al
cmp al , 13
je output
inc si
jmp l1

output:
print S2
mov dx , offset arr
mov ah , 9
int 21h

mov ah ,4ch
int 21h
nextline proc
mov dl , 10
mov ah , 2
int 21h
ret
nextline endp
main endp
end main