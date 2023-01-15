dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
s db 100 dup("$")
s1 db "Enter String :: $"
s3 db "Reversed String :: $"
.code
main proc
mov ax , @data
mov ds , ax

print s1
mov bl , 0
mov si , offset s
l1:
mov ah , 1
int 21h
cmp al , 13
je l2
mov [si] , al
inc si
inc bl
jmp l1

l2:
mov cl , bl
print s3

l3:
dec si
mov dx , [si]
mov ah , 2
int 21h
loop l3


mov ah , 4ch
int 21h
nextline proc
mov dl , 10
mov ah , 2
int 21h
ret
nextline endp
main endp
end main
