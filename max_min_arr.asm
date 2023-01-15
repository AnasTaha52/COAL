dosseg
print macro str
mov dx , offset str
mov ah , 9
int 21h
endm
.model small
.stack 100h
.data
arr db 1,6,4,0,8
outputs db "Array :: $"
max db "Largest Number :: $"
min db "Smallest Number :: $"
.code
main proc
mov ax , @data
mov ds , ax

print outputs
mov cx , 5
mov si , offset arr
l1:
mov dl , [si]
add dl , 48
mov ah , 2
int 21h
call space
inc si
loop l1

mov cx , 5
mov si , offset arr
mov bl , [si]
l2:
cmp bl , [si]
jg increment
mov bl , [si]
increment:
inc si
loop l2

call nextline
print max
mov dl , bl
add dl , 48
mov ah , 2
int 21h


mov si , offset arr
mov cx , 5
mov bl , [si]
l3:
cmp bl , [si]
jl incre
mov  bl , [si]
incre:
inc si
loop l3

call nextline
print min

mov dl , bl
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

space proc
mov dl , 32
mov ah , 2
int 21h
ret
space endp
main endp
end main