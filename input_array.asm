;Printing 10 elemets using array
dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
ar db 10 dup(?)
inputs db "Enter Array Elements :: $"
outputs db "Array :: $"
.code
main proc
mov ax , @data
mov ds , ax

print inputs
mov cx , 10
mov si , offset ar
l1:
mov ah , 1
int 21h
mov [si] , al
inc si
loop l1

call nextline
print outputs
mov cx , 10
mov si , offset ar
l2:
mov dl , [si]
add dl , 0
mov ah , 2
int 21h
call space
inc si
loop l2

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