dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
s1 db "Numerator = $"
s2 db "Denomerator = $"
s3 db "Quotient = $"
s4 db "Remainder = $"
n1 db ?
n2 db ?
.code
main proc
mov ax , @data
mov ds , ax

print s1
mov ah , 1
int 21h
sub al , 48
mov n1 , al

call nextline
print s2
mov ah , 1
int 21h
sub al , 48
mov n2 , al

mov ah , 0
mov al , n1
mov bl , n2
div bl

mov cl , al
mov ch , ah
call nextline
print s3
mov dl , cl
add dl , 48
mov ah , 2
int 21h

call nextline
print s4
mov dl , ch
add dl , 48
mov ah , 2
int 21h

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
