include MACROS.inc
EXtrn sentinvitechat:BYTE
EXtrn sentinvitegame:BYTE
EXtrn recinvitechat:BYTE
EXtrn recinvitegame:BYTE
extrn player1:BYTE
extrn highlightp1:BYTE

extrn sentchat:BYTE
extrn sentgame:BYTE
extrn receivedchat:BYTE
extrn receivedgame:BYTE
extrn SENDKEY:Far
extrn intializePort:Far
extrn chatfunc2:far
extrn gameblock:far
extrn printMenu:far
extrn othername:BYTE


extrn movcursor:far
extrn movcursorgame:far
public invites


.Model huge
.code
escape proc far
  
    cmp ah,1
    jne notescape
    mov al,ah
    call sendkey
    mov ah,4CH
    mov al,0
    int 21h
    notescape:
    ret
    escape endp


    escaperec proc far
    cmp al,1
   jne notescaperec
  
    mov ah,4CH
    mov al,0
    int 21h
    notescaperec:
    ret
   escaperec endp
   

invites proc far

    ;MAINMENUUU
    ;Text Mode
    
    call printMenu
	CALL intializePort
    mov sentinvitechat,0
    mov sentinvitegame,0
    mov recinvitechat ,0
    mov recinvitegame ,0
    mov player1,0
    mov highlightp1,0
	;CODE
	CHECKKEYPRESSEDinv:
	mov dx , 3FDH		; Line Status Register
    In al , dx 			;Read Line Status
    AND al , 00100000b
    JZ CHECKKEYSENTinv
	
	;CHECK IF THERE IS A KEY PRESSESD SEND TO THE OTHER USER
	MOV AH,01h
	INT 16H
	JZ CHECKKEYSENTinv   ;KEY recieved
	MOV AH,00
	INT 16H  
    call escape
    cmp ah,59
    jne notchat
    mov al,ah    ;put scan code in al
     CALL SENDKEY
    cmp recinvitechat,1
    jne dontenterchat

      call chatfunc2
    dontenterchat:
    mov sentinvitechat,1

    call movcursor
        mov ah,9h
    mov dx,offset othername
    int 21h 
        
    mov dx,offset sentchat
    int 21h 
    notchat:
	cmp ah,60
    jne notgame
    mov al,ah    ;put scan code in al
     CALL SENDKEY
    cmp recinvitegame,1
    jne dontentergame
    call gameblock
    dontentergame:
    mov player1,1
    mov highlightp1,1
    mov sentinvitegame,1
     call movcursorgame
      mov ah,9h
    mov dx,offset othername
    int 21h 
        
    mov dx,offset sentgame
    int 21h 

    notgame:

	CHECKKEYSENTinv:
	;CHECK STATE IF THERE IS DATA RECIVED
	;IF THERE IS NO DATA RECIVED
	MOV DX,3FDH
	IN AL,DX
	AND AL,1
	JnZ skipcheck
    JMP far ptr CHECKKEYPRESSEDinv 
    skipcheck:
	;IF THERE IS DATA RECIVED
	;RECIVE DATA AND CALL WRITE IN OUTPUT PROC
	MOV DX,03F8H
	IN AL,DX
    
   call escaperec
    cmp al,59
    jne notrecchat
    cmp sentinvitechat,1
    jne dontcallchat
    call chatfunc2

    dontcallchat:
    mov recinvitechat,1
     call movcursor
        mov ah,9h
    mov dx,offset othername
    int 21h 
        
    mov dx,offset receivedchat
    int 21h 
    notrecchat:
   
     cmp al,60
    jne notrecgame
    cmp sentinvitegame,1
    jne dontcallgame

    call gameblock

    dontcallgame:
    mov recinvitegame,1
    call movcursorgame
     mov ah,9h
    mov dx,offset othername
    int 21h
        
    mov dx,offset receivedgame
    int 21h 
    notrecgame:

	JMP far ptr CHECKKEYPRESSEDinv 
	;END CODE


ret
invites endp
end