.MODEL large
.STACK 64
.DATA
    SCREENCELLSCOUNT   equ 2080
    backgroundColor    equ 07h
    playerColor        equ 16h
    carColor1          equ 0Ch
    carColor2          equ 0Fh
    carPixelCount      equ 178
    playerPos          dw  3920
    carPositions       dw  390, 780, 1010, 1240, 1310, 1700, 1930, 2160, 2390, 2620, 2850, 3080, 3310, 3540, 3770
    initialTilesPos    dw  390, 780, 1010, 1240, 1310, 1700, 1930, 2160, 2390, 2620, 2850, 3080, 3310, 3540, 3770
   
    carsMovementPoints dw  -8, 6, 8, -4, 4, 4, -4, -4, 2, 6, -4, -4, 8, 2, 2
    ;Adding 320 Limits
    carsLowLimits      dw  320, 640, 960, 1120, 1280, 1600, 1920, 2080, 2240, 2560, 2720, 3040, 3200, 3520, 3680
    ;Adding 320 Limits
    carsHighLimits     dw  476, 796, 1116, 1276, 1436, 1756, 2076, 2236, 2396, 2716, 2876, 3196, 3356, 3676, 3836
    ;time adjustment
    currentDeciSec     db  ?
    currentSec         db  ?
    gameScore          db  0
    wasPlayerOnStrip   db  0
    PlayerPress        db  ?
    yellowLinePos      db  0
    milliSecSpeed      db  6
    scoreMultiplier    db  0
    collisionDetected  db  0
.code
MAIN PROC FAR
                               MOV  AX,@DATA
                               MOV  DS,AX

    
                               mov  ax, 0b800h
                               mov  es, ax

                               jmp  InitializeGame

    RetryGameSelected:         
                               call FAR ptr RetryGameInitializations

    InitializeGame:            
                               call FAR ptr initScene


    GameLoop:                  
  
    checkCarMovement:          
                               mov  ah,2Ch
                               int  21h
                               cmp  dh, currentSec
                               jne  moveTheCars
                               mov  cl, currentDeciSec
                               add  cl,milliSecSpeed
                               cmp  dl, cl
                               ja   moveTheCars
                               jmp  checkUserInput
    moveTheCars:               
                               mov  currentDeciSec, dl
                               mov  currentSec, dh
                               call FAR ptr moveCars

  
    checkingCollision:         
                               mov  si, playerPos
                               mov  al, es:[si+1]
                               cmp  al, BYTE PTR 0Ch
                               jne  checkUserInput
                               call FAR ptr drawPlayer
                               jmp  gameOver

    checkUserInput:            
                               mov  ax, 0
                               mov  ah, 1
                               int  16h
                               mov  playerPress, ah
                               jnz  getUserInput
                               jmp  CHECKYELLOW

    getUserInput:              
   
                               cmp  playerPress,10h
                               jne  checkRetryPressed
    consumeAndQuit:            
                               mov  ah,0
                               int  16h
                               jmp  exit

   
    checkRetryPressed:         
                               cmp  playerPress, 13h
                               jne  CheckArrowUP
    consumeAndRetry:           
                               mov  ah,0
                               int  16h
                               jmp  RetryGameSelected

    
    CheckArrowUP:              
                               cmp  PlayerPress, 48h
                               jne  CheckArrowDOWN
    CheckUpValidMove:          
                               mov  ax, playerPos
                               cmp  ax, BYTE PTR 320
                               jb   DisapproveUpMove
                               mov  di, playerPos
                               sub  di,  160
                               call FAR ptr movePlayer
    DisapproveUpMove:          
                               jmp  consumeInput

   
    CheckArrowDOWN:            
                               cmp  PlayerPress, 50h
                               jne  CheckArrowLEFT
    CheckDownValidMove:        
                               mov  ax, playerPos
                               cmp  ax, WORD PTR 3840                     
                               jae  DisapproveDownMove
                               mov  di, playerPos
                               add  di,  160
                               call FAR ptr movePlayer
    DisapproveDownMove:        
                               jmp  consumeInput

  
    CheckArrowLEFT:            
                               cmp  PlayerPress, 4Bh
                               jne  CheckArrowRIGT
    CheckLeftValidMove:        
                               mov  ax, playerPos
                               mov  dl, 160
                               div  dl
                               mov  dl, ah
                               cmp  dl, 0
                               je   DisapproveLeftMove
                               mov  di, playerPos
                               sub  di, BYTE PTR 2
                               call FAR ptr movePlayer
    DisapproveLeftMove:        
                               jmp  consumeInput

    CheckArrowRIGT:            
                               cmp  PlayerPress, 4Dh
                               jne  consumeInput
    CheckRightValidMove:       
                               mov  ax, playerPos
                               cmp  ax, 158
                               je   DisapproveRightMove
                               cmp  ax, 158
                               jb   approveRightMove
                               sub  ax, 158
                               mov  dl, 160
                               div  dl
                               mov  dl, ah
                               cmp  dl, 0
                               je   DisapproveRightMove
    approveRightMove:          
                               mov  di, playerPos
                               add  di, BYTE PTR 2
                               call FAR ptr movePlayer
    DisapproveRightMove:       


    consumeInput:              
                               mov  ah,0
                               int  16h

    checkCollision:            
                               mov  al, collisionDetected
                               cmp  al, 1
                               jne  CHECKYELLOW
                               int  3
                               jmp  gameOver

    CHECKYELLOW:               

                               mov  ax, playerPos
                               cmp  yellowLinePos, 0
                               jne  YellowatBottom
    YellowatTop:               
                               cmp  ax, WORD PTR 320
                               jb   ReachedTop
                               jmp  speedCheck
    ReachedTop:                
                               inc  gameScore

                               call FAR ptr drawYellowLine
                               jmp  speedCheck
    YellowatBottom:            
                               cmp  ax, WORD PTR 3840
                               jae  ReachedBottom
                               jmp  speedCheck
    ReachedBottom:             
                               inc  gameScore
    
                               call FAR ptr drawYellowLine

    speedCheck:                
    
                               call FAR ptr drawPlayer
  
                               mov  al,  gameScore
                               sub  al, scoreMultiplier
                               cmp  al, 02h
                               jae  increaseSpeed
    dontIncreaseSpeed:         
                               jmp  continueGameLoop
    increaseSpeed:             
                               mov  al, milliSecSpeed
                               cmp  al,1
                               je   DontIncreaseAlsoReachecone
                               dec  al
                               mov  milliSecSpeed, al
    DontIncreaseAlsoReachecone:
                               mov  ax, WORD PTR gameScore
                               mov  scoreMultiplier, al
    continueGameLoop:          
                               call FAR ptr drawScore
                               jmp  GameLoop

  
    gameOver:                  
                               call FAR ptr drawGameOverMsg
    gameOverWait:              
    getDecision:               
                               mov  ax, 0
                               mov  ah, 1
                               int  16h
                               jz   getDecision
                               mov  playerPress, ah
    consumeLetter:             
                               mov  ah,0
                               int  16h
                               cmp  playerPress, 10h
                               jne  checkRetry
                               jmp  exit
    checkRetry:                
                               cmp  playerPress, 13h
                               jne  gameOverWait
                               jmp  RetryGameSelected

    exit:                      
                               MOV  AH, 4Ch
                               MOV  AL, 0
                               INT  21h
MAIN ENDP
initScene PROC FAR

                               mov  cx,WORD PTR SCREENCELLSCOUNT
                               mov  di,00h
    drawRoad:                  
                               mov  es:[di],BYTE PTR 219
                               mov  es:[di+1],BYTE PTR backgroundColor
                               add  di, 2
                               loop drawRoad

                               mov  cx, WORD PTR 80
                               mov  di, 00h
    drawStatusLine:            
                               mov  es:[di],BYTE PTR 219
                               mov  es:[di+1],BYTE PTR 00
                               add  di, 2
                               loop drawStatusLine
 
                               mov  cx, WORD PTR 80
                               mov  di, WORD PTR 160
    drawGoalLineOne:           
                               mov  es:[di],BYTE PTR 219
                               mov  es:[di+1],BYTE PTR 0Eh
                               add  di, 2
                               loop drawGoalLineOne
   
                               call FAR ptr drawRoadLines
  
                               call FAR ptr generateCars

                               call FAR ptr drawPlayer
  
                               call FAR ptr initTimer
                               ret
initScene ENDP
drawSingleStripe PROC FAR
   
                               push cx
                               push bx
                               mov  cx, 8
                               add  bx, 154
    drawSingleStripeLoop:      
                               cmp  di, bx
                               jge  exitDSS
                               mov  es:[di],BYTE PTR 219
                               mov  es:[di+1],BYTE PTR 0Fh
                               add  di, 2h
                               loop drawSingleStripeLoop
    exitDSS:                   
                               pop  bx
                               pop  cx
                               ret
drawSingleStripe ENDP

drawCar PROC FAR
                               mov  es:[di],BYTE PTR carPixelCount
                               mov  es:[di+1],BYTE PTR carColor1
                               mov  es:[di+2],BYTE PTR carPixelCount
                               mov  es:[di+3],BYTE PTR carColor2
                               mov  es:[di+4],BYTE PTR carPixelCount
                               mov  es:[di+5],BYTE PTR carColor2
                               mov  es:[di+6],BYTE PTR carPixelCount
                               mov  es:[di+7],BYTE PTR carColor1
                               ret
drawCar ENDP

drawScore PROC FAR
    ;saving values in stack
                               push ax
                               push bx
  
                               mov  ah, 0
                               mov  al, gameScore
                               mov  bl, BYTE PTR 11
                               div  bl
                               add  ah, '0'
                               add  al, '0'
                               mov  es:[0], BYTE PTR 'S'
                               mov  es:[1], BYTE PTR 0Ah
                               mov  es:[2], BYTE PTR 'C'
                               mov  es:[3], BYTE PTR 0Ah
                               mov  es:[4], BYTE PTR 'O'
                               mov  es:[5], BYTE PTR 0Ah
                               mov  es:[6], BYTE PTR 'R'
                               mov  es:[7], BYTE PTR 0Ah
                               mov  es:[8], BYTE PTR 'E'
                               mov  es:[9], BYTE PTR 0Ah
                               mov  es:[10], BYTE PTR ':'
                               mov  es:[11], BYTE PTR 0Ah
                               mov  es:[12], BYTE PTR ' '
                               mov  es:[13], BYTE PTR 0Ah
                               mov  es:[14], al
                               mov  es:[15], BYTE PTR 0Ah
                               mov  es:[16], ah
                               mov  es:[17], BYTE PTR 0Ah
                               mov  es:[30], BYTE PTR 'C'
                               mov  es:[31], BYTE PTR 0Ah
                               mov  es:[32], BYTE PTR 'R'
                               mov  es:[33], BYTE PTR 0Ah
                               mov  es:[34], BYTE PTR 'O'
                               mov  es:[35],BYTE PTR 0Ah
                               mov  es:[36], BYTE PTR 'S'
                               mov  es:[37], BYTE PTR 0Ah
                               mov  es:[38], BYTE PTR 'S'
                               mov  es:[39], BYTE PTR 0Ah
                               mov  es:[128], BYTE PTR 'Q'
                               mov  es:[129], BYTE PTR 0Ah
                               mov  es:[130], BYTE PTR ':'
                               mov  es:[131], BYTE PTR 0Ah
                               mov  es:[132], BYTE PTR 'Q'
                               mov  es:[133], BYTE PTR 0Ah
                               mov  es:[134], BYTE PTR 'U'
                               mov  es:[135], BYTE PTR 0Ah
                               mov  es:[136], BYTE PTR 'I'
                               mov  es:[137], BYTE PTR 0Ah
                               mov  es:[138], BYTE PTR 'T'
                               mov  es:[139], BYTE PTR 0Ah
                               mov  es:[142], BYTE PTR 'R'
                               mov  es:[143], BYTE PTR 0Ah
                               mov  es:[144], BYTE PTR ':'
                               mov  es:[145], BYTE PTR 0Ah
                               mov  es:[146], BYTE PTR 'R'
                               mov  es:[147], BYTE PTR 0Ah
                               mov  es:[148], BYTE PTR 'E'
                               mov  es:[149], BYTE PTR 0Ah
                               mov  es:[150], BYTE PTR 'T'
                               mov  es:[151], BYTE PTR 0Ah
                               mov  es:[152], BYTE PTR 'R'
                               mov  es:[153], BYTE PTR 0Ah
                               mov  es:[154], BYTE PTR 'Y'
                               mov  es:[155], BYTE PTR 0Ah
                               pop  bx
                               pop  ax
                               ret
drawScore ENDP
drawGameOverMsg PROC FAR
                               mov  es:[68], BYTE PTR 'G'
                               mov  es:[69], BYTE PTR 0Ch
                               mov  es:[70], BYTE PTR 'A'
                               mov  es:[71], BYTE PTR 0Ch
                               mov  es:[72], BYTE PTR 'M'
                               mov  es:[73], BYTE PTR 0Ch
                               mov  es:[74], BYTE PTR 'E'
                               mov  es:[75], BYTE PTR 0Ch
                               mov  es:[76], BYTE PTR ' '
                               mov  es:[77], BYTE PTR 0Ch
                               mov  es:[78], BYTE PTR 'O'
                               mov  es:[79], BYTE PTR 0Ch
                               mov  es:[80], BYTE PTR 'V'
                               mov  es:[81], BYTE PTR 0Ch
                               mov  es:[82], BYTE PTR 'E'
                               mov  es:[83], BYTE PTR 0Ch
                               mov  es:[84], BYTE PTR 'R'
                               mov  es:[85], BYTE PTR 0Ch
                               mov  es:[86], BYTE PTR ' '
                               mov  es:[87], BYTE PTR 0Ch
                               mov  es:[88], BYTE PTR ':'
                               mov  es:[89], BYTE PTR 0Ch
                               mov  es:[90], BYTE PTR '('
                               mov  es:[91], BYTE PTR 0Ch
                               ret
drawGameOverMsg ENDP
generateCars PROC FAR
                               mov  cx, 15
                               mov  bx, offset carPositions
    generateCarsLoop:          
                               mov  di, [bx]
                               call FAR ptr drawCar
                               add  bx,BYTE PTR 2
                               loop generateCarsLoop
                               ret
generateCars ENDP
drawRoadLines PROC FAR
                               mov  cx, BYTE PTR 17
                               mov  bx, 486
                               mov  di, bx
    drawStripes:               
                               mov  dx, BYTE PTR 5
    drawRowStripes:            
                               call FAR ptr drawSingleStripe
                               add  di, BYTE PTR 18
                               dec  dx
                               jnz  drawRowStripes
                               add  bx, WORD PTR 3C0h
                               mov  di,  bx
                               loop drawStripes
                               ret
drawRoadLines ENDP
drawPlayer PROC FAR
                               push di
                               mov  di, playerPos
                               mov  es:[di],BYTE PTR 219
                               mov  es:[di+1],BYTE PTR playerColor
                               pop  di
                               ret
drawPlayer ENDP
moveCars PROC FAR
                               mov  cx, 15
    movingCars:                
                               mov  bx, offset carPositions
                               mov  ax, 15
                               sub  ax, cx
                               add  bx, ax
                               add  bx, ax
                               mov  di, offset carsMovementPoints
                               add  di, ax
                               add  di, ax
                               mov  dx, [bx]
                               add  dx, [di]
    checkLowBoundaries:        
                               mov  si, offset carsLowLimits
                               add  si, ax
                               add  si, ax
                               cmp  dx, ds:[si]
                               jae  checkHighBoundries
                               jmp  limitFail
    checkHighBoundries:        
                               mov  si, offset carsHighLimits
                               add  si, ax
                               add  si, ax
                               cmp  dx, ds:[si]
                               jb   limitPass
                               jmp  limitFail
    limitPass:                 
                               call FAR ptr moveSingleCar
    limitFail:                 
                               mov  ax, 0
                               sub  ax, ds:[di]
                               mov  ds:[di], ax
    keepMovingCars:            
                               dec  cx
                               jz   returnMovingCars
                               jmp  movingCars
    returnMovingCars:          
                               RET
moveCars ENDP
moveSingleCar PROC FAR
                               mov  di, [bx]
                               mov  es:[di],BYTE PTR 219
                               mov  es:[di+1],BYTE PTR backgroundColor
                               mov  es:[di+2],BYTE PTR 219
                               mov  es:[di+3],BYTE PTR backgroundColor
                               mov  es:[di+4],BYTE PTR 219
                               mov  es:[di+5],BYTE PTR backgroundColor
                               mov  es:[di+6],BYTE PTR 219
                               mov  es:[di+7],BYTE PTR backgroundColor
                               mov  [bx], dx
                               mov  di, [bx]
                               call FAR ptr drawCar
                               RET
moveSingleCar ENDP
initTimer PROC    FAR
                               mov  ah,2Ch
                               int  21h
                               mov  currentDeciSec, dl
                               mov  currentSec, dh
                               RET
initTimer ENDP
movePlayer PROC FAR
                               mov  al, es:[di+1]
                               cmp  al, 0Ch
                               jne  NOCOLLISION
                               mov  collisionDetected, 1
    NOCOLLISION:               
                               mov  si, playerPos
                               mov  al, 1
                               cmp  wasPlayerOnStrip, 1
                               je   drawWhiteBackgnd
    drawNormalBackgnd:         
                               mov  es:[si],BYTE PTR 219
                               mov  es:[si+1],BYTE PTR backgroundColor
                               jmp  cont
    drawWhiteBackgnd:          
                               mov  es:[si],BYTE PTR 219
                               mov  es:[si+1],BYTE PTR 0Fh
    cont:                      
                               mov  wasPlayerOnStrip, 0
                               mov  al, es:[di+1]
                               cmp  al, 0Fh
                               jne  NotAWhite
                               mov  wasPlayerOnStrip, 1
    NotAWhite:                 

                               mov  es:[di],BYTE PTR 219
                               mov  es:[di+1],BYTE PTR 01h
                               mov  playerPos, di
                               ret
movePlayer ENDP
  
  
drawYellowLine PROC    FAR
   
                               cmp  yellowLinePos, 0
                               jne  atBottom
    atTop:                     
                               mov  si, WORD PTR 160
                               mov  di, WORD PTR 3840
                               mov  yellowLinePos, 1
                               jmp  REMOVEDRAWNLINE
    atBottom:                  
                               mov  si, WORD PTR 3840
                               mov  di, WORD PTR 160
                               mov  yellowLinePos, 0
    REMOVEDRAWNLINE:           

                               mov  cx, WORD PTR 80
    removeYellow:              
                               mov  es:[si],BYTE PTR 219
                               mov  es:[si+1],BYTE PTR backgroundColor
                               add  si, 2
                               loop removeYellow
  
                               mov  cx, WORD PTR 80
    drawYellow:                
                               mov  es:[di],BYTE PTR 219
                               mov  es:[di+1],BYTE PTR 0Eh
                               add  di, 2
                               loop drawYellow
                               RET
drawYellowLine ENDP
getCarPosition PROC    FAR
                               mov  di, 480
                               mov  cx, 15
                               push cx
                               mov  ah, 2CH
                               int  21h
                               pop  cx
    getRandomCars:             
                               cmp  dx, WORD PTR 160
                               jb   isInRange
    notInRange:                
                               mov  dx, ax
                               mov  bl, BYTE PTR 160
                               div  bl
                               mov  ah, 0h
                               mov  dx, ax
    isInRange:                 
                               test dx, 00000001b
                               jz   isEvenContinue
    isOddMakeEven:             
                               and  dx, 11111110b
    isEvenContinue:            
                               add  di,dx
   
                               mov  bx, 15
                               sub  bx, cx
                               mov  ax, bx
                               add  bx, ax
                               add  bx, offset carPositions
                               mov  ds:[bx], di
                               add  di, WORD PTR 160
                               loop getRandomCars
                               RET
getCarPosition ENDP
 
RetryGameInitializations PROC    FAR
   
                               mov  cx, 15
                               mov  di, offset initialTilesPos
                               mov  si, offset carPositions
    reInitializeGamePos:       
                               mov  ax, [di]
                               mov  [si], ax
                               add  di, 2
                               add  si, 2
                               loop reInitializeGamePos
                               mov  playerPos, 3920
                               mov  wasPlayerOnStrip, 0
                               mov  yellowLinePos, 0h
                               mov  milliSecSpeed, 6
                               mov  scoreMultiplier, 0
                               mov  gameScore, 0
                               mov  collisionDetected, 0
                               RET
RetryGameInitializations ENDP
END MAIN