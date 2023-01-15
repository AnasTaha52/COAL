dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
n1 db "Enter Number :: $"
n2 db "Positive $"
n3 db "Negative $"
n4 db "Zero $"

.code
main proc
mov ax , @data
mov ds , ax
print n1
mov ah , 1
int 21h
mov bl , al
mov cl ,30h

cmp bl , cl
jg grat
jl l
je e

grat:
call nextline
print n2
jmp exit

l:
call nextline
print n3
jmp exit

e:
call nextline
print n4
jmp exit

exit:
mov ah , 4ch
int 21h

nextline proc
mov dl ,10
mov ah , 2
int 21h
ret
nextline endp

space proc
mov dl , 32
mov ah , 2
int 21h
ret
space endp

main endp
end main