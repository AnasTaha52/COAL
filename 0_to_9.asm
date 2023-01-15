dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
.code
main proc
mov ax, @data
mov ds , ax

mov cx , 10
mov bx , 48
l1:
mov dx , bx
mov ah , 2
int 21h
inc bx
call space
loop l1

mov cx , 10
mov bx , 48
l2:
mov dx , bx
mov ah , 2
int 21h
call nextline
inc bx
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