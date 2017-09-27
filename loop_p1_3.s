.text
.globl _start

start  = 0
max    = 31
stdout = 1

_start:     
        
        mov	x15, start
	mov	x16, max
loop:

        /* Body of our loop */
       
	/* Init digits to zero  */
        mov	w10, 48
	mov	w11, 48
	
	mov	w2 , 10
        adr     x1, msg         /* message location (memory address) */      
	
	/* Getting quotient */	
	udiv	w0, w15, w2
	/* Getting remainder */
	msub	w3, w0, w2, w15

	/*  store quotient & remainder */
	add	w10, w10, w0
	add	w11, w11, w3

	/* Check if not 2 digit num */
	cmp	x15, 10
	b.lt	shift
	
	strb    w10, [x1, 6]
	strb    w11, [x1, 7]

	/* Execute this part for both cases*/
	B printl

shift:
	strb    w11, [x1, 6]

printl:
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
msg: 	.ascii      "Loop:   \n"
len= 	. - msg
