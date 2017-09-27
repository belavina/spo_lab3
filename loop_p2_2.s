.text
.globl    _start

start = 0                       /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 31                        /* loop exits when the index hits this number (loop condition is i<max) */
stdout = 1

_start:
    mov     $start, %r15         /* loop index */

loop:
    /* ... body of the loop ... do something useful here ... */
    mov    $0x30, %r10 /* 1st digit:  init to 0 in ASCII */
    mov    $0x30, %r11 /* 2nd digit */

    mov    $0   , %rdx /* init remainder  */
    mov    %r15 , %rax /* place counter (divident) */
    mov    $10  , %r14 /* place divisor */

    div	   %r14 

    /* Add result of division and remainder */
    add    %rax, %r10 
    add    %rdx, %r11

    /* Add number to our string:  */
    mov    %r10b, fd
    mov    %r11b, sd
    
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
.set sd  , fd + 1   /* Position of our second digit */
