dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
s db "Assembly$"
s1 db "Reversed String :: $"
.code 
main proc
mov ax, @data
mov ds , ax

print s
mov si , offset s
mov cx , 8
l1:
mov bx , [si]
push bx
inc si
loop l1

call nextline
print s1
mov cx , 8
l2:
pop dx
mov ah , 2
int 21h
loop l2

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