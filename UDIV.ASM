dosseg

print macro pa
mov dx , offset pa
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
str1 db "Enter first number = $"
str2 db "Enter second number = $"
str3 db "Numerator = $"
str4 db "Denominator = $"
str5 db "Quotient = $"
str6 db "Remainder = $"
n1 db ?
n2 db ?
.code
main proc
mov ax , @data
mov ds , ax

print str1
mov ah , 1
int 21h
sub al , 48
mov n1 , al

call nextline
print str2
mov ah , 1
int 21h
sub al , 48
mov n2 , al


mov ah , 0
mov al , n1
mov bl , n2

div bl

mov ch , ah
mov cl , al

call nextline
print str5
mov dl , cl
add dl , 48
mov ah , 2
int 21h

call nextline
print str6
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
