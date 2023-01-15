dosseg
print macro pa
mov dx , offset pa
mov ah , 9
int 21h
endm

.model small 
.stack 100h
.data
str1 db "Numerator = $"
str2 db "Denominator = $"
str3 db "Quotient = $"
str4 db "Remainder = $"
n1 db ?
n2 db ?
d db ?
q db ?
r db ?
.code 
main proc
mov ax , @data 
mov ds , ax 

print str1 

mov ah , 1 
int 21h
mov n1 , al

mov ah , 1 
int 21h
mov n2 , al


call nextline
print str2
mov ah , 1
int 21h
mov d , al 

mov ah , n1
mov al , n2
mov bl , d 


sub ah , 48
sub al , 48
sub bl, 48

AAD 
div bl 

mov q , al
mov r , ah 

call nextline
print str3
mov dl , q
add dl , 48
mov ah , 2
int 21h

call nextline
print str4
mov dl , r 
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