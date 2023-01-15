dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
s1 db "String :: $"
s2 db "Pakistan$"
s3 db "Enter Character to be searched :: $"
s4 db "Found!$"
s5 db "NotFound!$"
.code 
main proc
mov ax, @data
mov ds , ax
print s1
print s2

call nextline
print s3
mov ah , 1
int 21h
mov si , offset s2
searchLoop:
mov bl , [si]
cmp al ,bl
je found
inc si
cmp bl , "$"
jnz searchLoop
call nextline
print s5
jmp exit

found:
call nextline
print s4
jmp exit

exit:
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