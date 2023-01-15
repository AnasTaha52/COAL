dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
n1 db ?
n2 db ?

.code
main proc
mov ax , @data
mov ds , ax


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