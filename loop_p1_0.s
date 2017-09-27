.text
.globl _start

start  = 0
max    = 10
stdout = 1

_start:     
        
        mov	x15, start
	mov	x16, max
loop:

        /* Body of our loop */
        mov	w10, 48
	adr     x1, msg         /* message location (memory address) */      
	
        /* Copy one byte into x1+6 */
        strb    w10, [x1, 6]

	/* Print message */
	mov     x0, stdout       /* file descriptor: 1 is stdout */
	mov     x2, len   	/* message length (bytes) */ 

	mov     x8, 64     	/* write is syscall #64 */
	svc     0          	/* invoke syscall */
 
	/* Loop Logic */
	add     x15, x15, 1
	cmp 	x15, x16
	b.ne	loop

 	/* Exit the program */
	mov     x0, 0     	/* status -> 0 */
	mov     x8, 93    	/* exit is syscall #93 */
	svc     0          	/* invoke syscall */
 
.data
msg: 	.ascii      "Loop:  \n"
len= 	. - msg
