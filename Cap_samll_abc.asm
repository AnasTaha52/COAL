dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data

s1 db "Capital Letters$"
s2 db "Small Letters$"

.code
main proc
mov ax, @data
mov ds , ax

print s1
call nextline
mov cx , 26
mov bx , 65
l1:
mov dx , bx
mov ah , 2
int 21h
call nextline
inc bx
loop l1
call nextline
print s2
call nextline
mov cx , 26
mov bx , 97
l2:
mov dx , bx
mov ah , 2
int 21h
inc bx
call space
loop l2
mov ah ,4ch
int 21h

nextline proc
mov dl , 10
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