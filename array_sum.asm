dosseg
print macro st
          lea dx,st
          mov ah,9
          int 21h
endm
.model small
.stack 100h
.data
    inp   db "Input an element : $"
    arr   db 20 dup(?)
    arrIs db "Array = $"
    sum   db "SUM = $"
    line  db 13,10,"$"
    s     db 0
    space db 32,"$"

.code
main proc
              mov   ax,@data
              mov   ds,ax
              mov   cx,20
              lea   si,arr
    while:
              print inp
              mov   ah,1
              int   21h
              and   al,0fh
              mov   [si],al
              add   s,al
              inc   si
              print line
              loop  while
              print line
              print arrIs
              call  outputArr
              print line
              print sum

              mov   bx,10
              xor   dx,dx
              mov   cx,0
              mov   al,s
              mov   ah,0
    chk:
              mov   dx , 0
              div   bx
              push  dx
              inc   cx
              mov   ah,0
              cmp   ax,0
              jnz   chk
    l1:
              pop   dx
              add   dx,48
              mov   ah,2
              int   21h
              xor   dx,dx
              loop  l1

              mov   ah,4ch
              int   21h

outputArr proc
              mov   cl,20
              lea   si,arr
    again:
              mov   dl,[si]
              or    dl,30h
              mov   ah,2
              int   21h
              inc   si
              print space
              loop  again
              ret
outputArr endp
main endp
end main