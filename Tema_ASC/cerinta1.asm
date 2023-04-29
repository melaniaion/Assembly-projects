.data
	formatScanf: .asciz "%[^\n]s"
	decFormat: .asciz "%d "
	charFormat: .asciz "%c "
	x: .space 100
	bits: .space 10000
	string_var: .asciz "x "
	let: .asciz "let "
	add: .asciz "add "
	sub: .asciz "sub "
	mul: .asciz "mul "
	div: .asciz "div "
	endl: .asciz "\n"
	minus: .asciz "-"

.text

.global main

decode:
	movl (%ecx, %esi), %edi
	cmpb $0, (%ecx, %esi)
	jne ok
	ret
	ok:
	pushl %ebp
	movl %esp, %ebp
	movl $bits, %ecx
	movl $0, %edi
	cmpb $0, 11(%ecx, %esi)
	je skip_11
	addl $1, %edi
	skip_11:
		cmpb $0, 10(%ecx, %esi)
		je skip_10
		addl $2, %edi

	skip_10:
		cmpb $0, 9(%ecx, %esi)
		je skip_9
		addl $4, %edi

	skip_9:
		cmpb $0, 8(%ecx, %esi)
		je skip_8
		addl $8, %edi

	skip_8:
		cmpb $0, 7(%ecx, %esi)
		je skip_7
		addl $16, %edi

	skip_7:
		cmpb $0, 6(%ecx, %esi)
		je skip_6
		addl $32, %edi

	skip_6:
		cmpb $0, 5(%ecx, %esi)
		je skip_5
		addl $64, %edi

	skip_5:
		cmpb $0, 4(%ecx, %esi)
		je skip_4
		addl $128, %edi

	skip_4:
		cmpb $0, 3(%ecx, %esi)
		je skip_3
		pushl %esi
		pushl %ecx
		pushl $minus
		call printf
		popl %ebx
		popl %ecx
		popl %esi

	skip_3:
	dif_1:
		cmpb $0, 1(%ecx, %esi)
		jne dif_2
		cmpb $0, 2(%ecx, %esi)
		jne dif_1_1
		cmpl $0, %edi
		pushl %esi
		pushl %ecx
		pushl %edi
		pushl $decFormat
		call printf
		popl %ebx
		popl %ebx
		popl %ecx
		jmp end

		dif_1_1:
			pushl %esi
			pushl %ecx
			pushl %edi
			pushl $charFormat
			call printf
			popl %ebx
			popl %ebx
			popl %ecx
			popl %esi
			jmp end
	dif_2:
		cmpl $0, %edi
		jne skip_let
		pushl %esi
		pushl %ecx
		pushl $let
		call printf
		popl %ebx
		popl %ecx
		popl %esi
		jmp end

	skip_let:
		cmpl $1, %edi
		jne skip_add
		pushl %esi
		pushl %ecx
		pushl $add
		call printf
		popl %ebx
		popl %ecx
		popl %esi
		jmp end

	skip_add:
		cmpl $2, %edi
		jne skip_sub
		pushl %esi
		pushl %ecx
		pushl $sub
		call printf
		popl %ebx
		popl %ecx
		popl %esi
		jmp end

	skip_sub:
		cmpl $3, %edi
		jne skip_mul
		pushl %esi
		pushl %ecx
		pushl $mul
		call printf
		popl %ebx
		popl %ecx
		popl %esi
		jmp end

	skip_mul:
		cmpl $4, %edi
		jne skip_div
		pushl %esi
		pushl %ecx
		pushl $div
		call printf
		popl %ebx
		popl %ecx
		popl %esi
		jmp end

	skip_div:

	end:
	addl $12, %esi
	call decode
	movl %ebp, %esp
	popl %ebp
	ret

main:
	pushl $x
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	movb (%ebx), %al
	movl $-1, %esi
	movl $bits, %ecx
	pushl %ebp

	loop_char:
		incl %esi
		movb (%ebx, %esi), %al
		cmpb $48, (%ebx, %esi)
		jne if_1
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		jmp loop_char
		if_1:
		cmpb $49, (%ebx, %esi)
		jne if_2
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		jmp loop_char
		if_2:
		cmpb $50, (%ebx, %esi)
		jne if_3
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		jmp loop_char
		if_3:
		cmpb $51, (%ebx, %esi)
		jne if_4
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		jmp loop_char
		if_4:
		cmpb $52, (%ebx, %esi)
		jne if_5
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		jmp loop_char
		if_5:
		cmpb $53, (%ebx, %esi)
		jne if_6
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		jmp loop_char
		if_6:
		cmpb $54, (%ebx, %esi)
		jne if_7
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		jmp loop_char
		if_7:
		cmpb $55, (%ebx, %esi)
		jne if_8
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		jmp loop_char
		if_8:
		cmpb $56, (%ebx, %esi)
		jne if_9
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		jmp loop_char
		if_9:
		cmpb $57, (%ebx, %esi)
		jne if_A
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		jmp loop_char
		if_A:
		cmpb $65, (%ebx, %esi)
		jne if_B
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		jmp loop_char
		if_B:
		cmpb $66, (%ebx, %esi)
		jne if_C
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		jmp loop_char
		if_C:
		cmpb $67, (%ebx, %esi)
		jne if_D
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		jmp loop_char
		if_D:
		cmpb $68, (%ebx, %esi)
		jne if_E
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		jmp loop_char
		if_E:
		cmpb $69, (%ebx, %esi)
		jne if_F
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $0, (%ecx)
		incl %ecx
		jmp loop_char
		if_F:
		cmpb $70, (%ebx, %esi)
		jne end_loop
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		movl $1, (%ecx)
		incl %ecx
		jmp loop_char
		end_loop:

	movl $0, %esi
	movl $bits, %ecx
	call decode
	pushl $endl
	call printf
	popl %ebx
	pushl $0
	call fflush
	popl %ebx

exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
