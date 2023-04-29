.data
    formatScanf: .asciz "%[^\n]s"
    decFormat: .asciz "%d\n"
    space: .asciz " "
    x: .space 1000
.text

.global main


main:
    pushl $x
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    pushl $space
    pushl %ebx
    call strtok
    popl %edx
    popl %ebx
    popl %ebx

    loop_read:

        pushl %edx
        pushl %edx
        call atoi
        popl %ecx
        popl %edx

        cmpl $0, %eax
        je operator
        pushl %eax
        jmp end_ifs

        operator:

            cmpb $97, (%edx)
            jne skip_add
            popl %ecx
            popl %eax
            addl %eax, %ecx
            pushl %ecx
            jmp end_ifs

        skip_add:
            cmpb $115, (%edx)
            jne skip_sub
            popl %ecx
            popl %eax
            subl %ecx, %eax
            pushl %eax
            jmp end_ifs

        skip_sub:
            cmpb $109, (%edx)
            jne skip_mul
            popl %ecx
            popl %eax
            imul %ecx
            pushl %eax
            jmp end_ifs

        skip_mul:
            cmpb $100, (%edx)
            jne end_ifs
            popl %ecx
            popl %eax
            pushl %edx
            movl $0, %edx
            idiv %ecx
            popl %edx
            pushl %eax
            jmp end_ifs

        end_ifs:

        pushl $space
        pushl $0
        call strtok
        popl %edx
        popl %ebx
        movl %eax, %edx

        cmpl $0, %edx
        jne loop_read

    pushl $decFormat
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx

exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
