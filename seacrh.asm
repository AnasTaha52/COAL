dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
ar db 2,4,5,6,1
arr db "2,4,5,6,1$"
s1 db "Array :: $"
s2 db "Enter a Number :: $"
f db "FOund!$"
d db "Not Found$"
.code
main proc
mov ax , @data
mov ds , ax
print s1
mov si , offset ar
mov cx , 5
l1:
mov dl , [si]
add dl ,48
mov ah , 2
int 21h
inc si
loop l1

call nextline
print s2
mov ah  , 1
int 21h

mov si , offset arr
l2:
mov bl , [si]
cmp al , bl
je found
inc si
cmp bl , "$"
jnz l2

print d
jmp exit

found:
call nextline
print f
jmp exit

exit:
mov ah , 4
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