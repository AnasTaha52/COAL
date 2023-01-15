;decimal to binary conversion
dosseg
print macro st
          lea dx,st
          mov ah,9
          int 21h
endm
.model small
.stack 100h
.data
    inp  db "Input a number  : $"
    bin  db "Binary Number   : $"
    deci db "Decimal Number : $"
    line db 13,10,"$"
    num  db ?
.code
main proc

          mov   ax,@data
          mov   ds,ax
          print inp
          mov   ah,1
          int   21h
          sub   al,48
          mov   num,al
          print line
          print deci
          mov   dl,num
          add   dl,48
          mov   ah,2
          int   21h
          print line
          mov   dx,0
          mov   cx,0
          mov   bx,2
          mov   al,num
         
    again:
          mov   ah,0
          div   bx
          push  dx
          inc   cx
          cmp   ax,0
          jne   again
          print bin
    disp: 
          pop   dx
          add   dx,48
          mov   ah,2
          int   21h
          loop  disp
          print line
          mov   ah,4ch
          int   21h

main endp
end main