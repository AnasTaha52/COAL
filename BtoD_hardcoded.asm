dosseg
printString macro s1
                lea dx , s1
                mov ah , 9
                int 21h
endm
printNumber macro n1
                mov dl , n1
                add dl , 48
                mov ah , 2
                int 21h
endm
takeInput macro i1
              mov ah , 1
              int 21h
              mov i1 , al
endm
pow macro base , expo , res
             push cx
             cmp  expo , 0
             jnz  continue
             mov  res , 1
             jmp  endMacro
    continue:
             mov  al , 1
             mov  bl , base
             mov  cl , expo
    pLoop:   
             mul  bl
             loop pLoop
             mov  res , al
    endMacro:
             pop  cx
endm
.model small
.stack 100h
.data
    binary db 0,1,0,1
    deci   db 0
    res    db ?
    pw     db ?
.code
main proc
          mov         ax , @data
          mov         ds , ax

          mov         si , 0
          mov         cx ,'3'
          mov         pw , 3
    loop1:
          pow         2  pw  res
          mov         al , res
          mov         bl , binary[si]
          mul         bl
          add         deci ,al
          inc         si
          dec         pw
          dec         cx
          cmp         cx , '/'
          jg          loop1
          printNumber deci
          mov         ah , 4ch
          int         21h
main endp
endl proc
          mov         dl , 10
          mov         ah , 2
          int         21h
          ret
endl endp
end main