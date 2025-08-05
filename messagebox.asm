BITS 64
SECTION .text
global main
main:

	sub rsp, 0x28
	and rsp, 0xFFFFFFFFFFFFFFF0
	xor rcx, rcx
	mov rax, [gs:rcx + 0x60]
	mov rax, [rax + 0x18]
	mov rsi, [rax + 0x10]
	mov rsi, [rsi]
	mov rsi, [rsi]
	mov rbx, [rsi + 0x30]     ;kernel32
	mov r8, rbx		  ;kernel32
	
	xor rdx, rdx
	mov edx, [r8 + 0x3C]
	add rdx, r8
	mov edx, [rdx + 0x88]
	add rdx, r8		 	;export directory
	mov esi, [rdx + 0x14]		;number of function
	xor r9,  r9
	mov r9d, [rdx + 0x20]
	add r9,  r8			;address of  names
	
	mov rcx, rsi			;loop counter
	mov rax, 0x0000737365726464
	push rax
	mov rax, 0x41636F7250746547
	push rax
	mov rax, rsp
	
	findgetproc:
		xor r10, r10
		mov r10d, [r9 + rcx * 4]
		add r10, r8
		dec rcx
		
		mov r11, qword [r10]
		cmp [rax], r11
		jnz findgetproc
		
		mov r11d, dword [r10 + 8]
		cmp [rax + 8], r11d
		jz findOrdinal
			jnz findgetproc
	
	findOrdinal:
		inc rcx
		xor r10, r10
		mov r10d, [rdx + 0x24]
		add r10, r8
		
		xor r11, r11
		mov r11w, [r10 + rcx * 2]		;holds ordinal 
		
		mov r10d, [rdx + 0x1C]
		add r10, r8				;address of function
		
		mov ebx, [r10 + r11 * 4]
		add rbx, r8				; holds GetProcAddress
		
		mov r13, rbx				; copy of GetProcAddress
		
		mov rcx, r8						
		mov rbx, 0x0000000041797261		
		push rbx
		mov rbx, 0x7262694C64616F4C
		push rbx
		mov rbx, rsp
		mov rdx, rbx
		sub rsp, 0x30
		call r13
		add rsp, 0x30
		mov r11, rax				; holds LoadLibraryA
		
		;	find user32.dll
		mov rax, 0x0000000000006C6C
		push rax
		mov rax, 0x642E323372657375
		push rax
		mov rax, rsp
		mov rcx, rax
		sub rsp, 0x30
		call r11
		add rsp, 0x30
		mov r12, rax				; holds user32.dll
		
		;	find MessageBox
		mov rcx, r12					
		
		mov rax, 0x000000000041786F
		push rax
		mov rax, 0x426567617373654D
		push rax
		mov rdx, rsp 					
		sub rsp, 0x30
		call r13				; call LoadLibraryA
		add rsp, 0x30
		mov rbx, rax				; holds MessageBox address
		
		;	pop MessageBox
		xor rcx, rcx
		mov rax, 0x0000616863746F47
		push rax
		mov rdx, rsp
		mov r8, 0x0000000000657265
		push r8
		mov r8, 0x68545F6F6C6C6548
		push r8
		mov r8, rsp
		xor r9d, r9d
		sub rsp, 0x38
		call rbx				; call
		add rsp, 0x38
	
