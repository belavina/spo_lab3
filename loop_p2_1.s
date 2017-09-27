.text
.globl    _start

start = 0                       /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 10                        /* loop exits when the index hits this number (loop condition is i<max) */
stdout = 1

_start:
    mov     $start, %r15         /* loop index */

loop:
    /* ... body of the loop ... do something useful here ... */
    mov    $0x30, %r10 /*  init to 0 in ASCII */

    /* Add loop counter to our digit register */
    add	   %r15, %r10

    /* Add number to our string:  */
    mov    %r10b, fd
    
    /*  Print Message to the stdout  */
    mov    $len, %rdx                       /* message length */
    mov    $msg, %rsi                       /* message location */
    mov    $stdout, %rdi                    /* file descriptor stdout */
    mov    $1, %rax                         /* syscall sys_write */
    syscall
    
    /* LOOP LOGIC */
    inc     %r15                /* increment index */
    cmp     $max, %r15           /* see if we're done */
    jne     loop                /* loop if we're not */

    /* Exit the program */
    mov     $0, %rdi             /* exit status */
    mov     $60, %rax            /* syscall sys_exit */
    syscall


.data

msg:    .ascii      "Loop:    \n"
.set len , . - msg
.set fd  , msg + 6  /* Position of our first digit is here Loop: <digit> */


