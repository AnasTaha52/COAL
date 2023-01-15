dosseg
print macro st
          lea dx,st
          mov ah,9
          int 21h
endm
.model small
.stack 100h
.data
    deci db "Decimal Number = $ "
    inp  db "Input a Binary Number : $ "
    line db 13,10,"$"
    erro db "Invalid Input $ "
.code
main proc


                mov   ax,@data
                mov   ds,ax
                print inp
                xor   bx,bx
    ;input binary number
                mov   cx,8
                mov   ah,1
    inputBin:   
                int   21h
                cmp   al,13
                je    endinputBin
                cmp   al,30h
                jb    error
                cmp   al,31h
                ja    error
                and   al,0fh
                shl   bx,1
                or    bl,al

                loop  inputBin
               
    endinputBin:
                print line
                print deci
                mov   cx,0
                xor   ax,ax
                mov   ax,bx
                mov   bx,10
            
    again:      
                xor   dx,dx
                div   bx
                push  dx
                inc   cx
                cmp   ax,0
                jnz   again
     
                mov   ah,2
    outputdeci: 
                pop   dx
                or    dx,30h
                int   21h
                loop  outputdeci
                jmp   exit
    error:      
                print line
                print erro

    exit:       
                mov   ah,4ch
                int   21h
main endp
end main
