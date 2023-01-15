dosseg
.model small
.stack 100h
.data
.code
main proc

; *
; **
; ***
; ****
; *****
mov bx , 1
mov cx , 5
l1:
push cx
mov cx , bx
mov dl , '*'
l2:
mov ah , 2 
int 21h
loop l2
call nextline
pop cx
inc bx
loop l1
call nextline
; *****
; ****
; ***
; **
; *

mov bx , 5
mov cx , 5
l3:
push cx
mov cx , bx

l4:
mov dl , '*'
mov ah , 2
int 21h
loop l4
call nextline
pop cx
dec bx
loop l3 
call nextline
; 1
; 12
; 123
; 1234
; 12345

mov bx , 1
mov cx , 5
l5:
push cx
mov cx , bx
mov dx , 49
l6:
mov ah , 2
int 21h
inc dx
loop l6
call nextline
pop cx
inc bx
loop l5
call nextline
; 1
; 22
; 333
; 4444
; 55555

mov bx , 1
mov cx , 5
l7:
push cx
mov cx , bx
l8:
mov dx , bx
add dx , 48
mov ah , 2
int 21h
inc dx
loop l8
call nextline
pop cx
inc bx
loop l7
call nextline

; a
; ab
; abc
; abcd
; abcde

mov bx , 1
mov cx , 5
l9:
push cx
mov cx , bx
mov dx , 97
l10:
mov ah , 2
int 21h
inc dx
loop l10
call nextline
pop cx
inc bx
loop l9
call nextline

; a
; bb
; ccc
; dddd
; eeeee

mov bx , 1
mov cx, 5
l12:
push cx
mov cx , bx
l11:
mov dx , bx
add dx , 96
mov ah , 2
int 21h

loop l11
call nextline
pop cx
inc bx
loop l12
call nextline

; 12345
; 1234
; 123
; 12
; 1
mov bx , 5
mov cx , 5
l13:
push cx
mov cx , bx
mov dx , 49
l14:
mov ah , 2
int 21h
inc dx
loop l14
call nextline
pop cx
dec bx
loop l13
call nextline

call nextline

; 54321
; 4321
; 321
; 21
; 1
mov bx , 5
mov cx , 5
l15:
push cx
mov cx , bx
mov dx , 53
l16:
mov ah , 2
int 21h
dec dx
loop l16
call nextline
pop cx
dec bx
loop l15
call nextline

; 55555
; 4444
; 333
; 22
; 1
mov bx , 5
mov cx , 5
l17:
push cx
mov cx , bx

l18:
mov dx , bx
add dx , 48
mov ah , 2
int 21h
loop l18
dec dx
call nextline
pop cx
dec bx
loop l17

call nextline 
mov bx , 6
mov cx, 3
loopA:
push cx
mov cx , bx
loopB:
mov dl , '*'
mov ah , 2
int 21h
loop loopB
call nextline
call nextline
pop cx
dec bx
loop loopA
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