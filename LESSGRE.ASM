; Program that Equal, greatrer , lesser
dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
first db "Enter first Number :: $"
second db "Enter Second Number :: $"
s1 db "Numbers Are Equal!$"
s3 db "First Number is greater than second!$"
s4 db "First Number is lesser than second!$"
.code

main proc
mov ax , @data
mov ds , ax

print first
mov ah , 1
int 21h
mov bl , al
call nextline
print second
mov ah , 1
int 21h
cmp bl , al
je Equal
jg Greater
jl Lesser

mov ah , 4ch
int 21h

Equal:
call nextline
print s1
mov ah , 4ch
int 21h
Greater:
call nextline
print s3
mov ah , 4ch
int 21h
lesser:
call nextline
print s4
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
