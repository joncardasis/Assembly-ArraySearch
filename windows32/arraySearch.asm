; Program Name: Assignment 3 - Array Load and Search
; Programmer Name: Jonathan Cardasis
; Description: Takes input for a collection of positive integers and stored them into an array of 
;              doublewords (maximum of 10 elements). Any number n<=0 can be used to stop reading input
;              values for the array. The user enters a value to search for in the array, and can continue
;              to search for more values, to stop searching and end the program "N" or "n" is entered.
;              
; Date Created: 11/22/16

.586
.MODEL FLAT

INCLUDE io-asm.h                              ; header file for input/output

.STACK 4096

.DATA
string          BYTE  40 DUP (?)              ; used for user input
numbers         DWORD 10 dup (?)              ; array of ten possible elements 
numbersCount    DWORD 0
searchValue     DWORD ?
count           DWORD ?
outputString    BYTE  11 DUP (?), 0           ; used to print out

; Input Prompts
inputPrompt          BYTE "Enter a value to add to the array: ", 0
searchPrompt         BYTE "Enter a value to search for:", 0
continuePrompt       BYTE "Would you like to search for more numbers?", 0

; Output Prompts
invalidInputPrompt   BYTE "input is invalid", 0
emptyOutputPrompt    BYTE "array is empty", 0
valueNotFoundPrompt  BYTE " not in the array", 0
valueFoundPrompt     BYTE " is element ", 0



.CODE
_MainProc PROC
		lea esi, numbers                      ; load array address
		mov ecx, 10                          ; max number of elements we can add

arrayInput:
        input   inputPrompt, string, 40       ; read input
        atod    string                        ; convert to integer
		
		cmp eax, 0				              ; loop while input > 0
		jle endArrayInput       
		;cmp numbersCount, 10                 ; AND loop while numbersCount < 10
		;jge endArrayInput

		inc numbersCount                      ; add 1 to array count
		mov [esi], eax                        ; add element to array
		add esi, 4                            ; point esi to next element

		loop arrayInput                       ; repeat

endArrayInput:
		; Check for zero elements
		cmp numbersCount, 0
		jne search
		output emptyOutputPrompt, emptyOutputPrompt
		jmp end_program

search:
		input searchPrompt, string, 40
		atod  string
		mov searchValue, eax

		cmp searchValue, 0
		jg validInput
		dtoa outputString, searchValue		  ; Do for invalid input
		output invalidInputPrompt, outputString
		jmp search

 validInput:
		lea esi, numbers                      ; load array address
		mov count, 0                          ; start count at zero

 forever:
		mov eax, numbersCount
		cmp count, eax
		jle canSearch
		dtoa outputString, searchValue
		output valueNotFoundPrompt, outputString    ; do if we count value is outside array bounds
		jmp endSearch

 canSearch:
		;if searchvalue == current array element
		mov eax, searchValue
		cmp eax, [esi]
		jne notEqual

		; They are equal:
		dtoa outputString, count
		output valueFoundPrompt, outputString      ; will print 'is element ' + index it was found at
		jmp endSearch

 notEqual:
        inc count
		add esi, 4                                 ; point esi to next element
		jmp forever

endSearch:
		input continuePrompt, string, 40
		mov dl, byte PTR [string]                  ; get first character of string and store in low byte

		cmp dl, 'N'                                ; compare input for "N" and "n" to stop program
		je end_program
		cmp dl, 'n'
		je end_program
		jmp search                                 ; do search loop again if continue input was not "N"/"n"

end_program:
        mov     eax, 0                   ; exit with return code 0
        ret

_MainProc ENDP
END                                      ; end of source code

