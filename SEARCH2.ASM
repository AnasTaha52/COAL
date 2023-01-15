dosseg
print macro str 
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
arr db "Anas$"
outputStr db "String :: $" 
s1 db "Enter char to search :: $"
s2 db "Found!$"
s3 db "Not Found!$"
char db ?
.code
main proc
mov ax , @data
mov ds , ax
print outputStr
print arr
call nextline
print s1
mov ah , 1
int 21h

mov si , offset arr
searchLoop:
mov bl , [si]
cmp al , bl
je found
inc si
cmp bl , "$"
jnz searchLoop

print s3
jmp exit

found:
print s2
exit:
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

