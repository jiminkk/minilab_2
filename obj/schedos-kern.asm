
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 32 02 00 00       	call   10024b <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 47 01 00 00       	call   1001b9 <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	56                   	push   %esi
  10009d:	53                   	push   %ebx
  10009e:	83 ec 04             	sub    $0x4,%esp
	pid_t pid = current->p_pid;
  1000a1:	a1 fc 8d 10 00       	mov    0x108dfc,%eax
  1000a6:	8b 10                	mov    (%eax),%edx
	unsigned int lowest_val;
	lowest_val = 0xffffffff; // INTMAX

	if (scheduling_algorithm == __EXERCISE_1__)
  1000a8:	a1 00 8e 10 00       	mov    0x108e00,%eax
  1000ad:	85 c0                	test   %eax,%eax
  1000af:	75 1c                	jne    1000cd <schedule+0x31>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b1:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b6:	8d 42 01             	lea    0x1(%edx),%eax
  1000b9:	99                   	cltd   
  1000ba:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bc:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000bf:	83 b8 1c 84 10 00 01 	cmpl   $0x1,0x10841c(%eax)
  1000c6:	75 ee                	jne    1000b6 <schedule+0x1a>
  1000c8:	e9 bb 00 00 00       	jmp    100188 <schedule+0xec>
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == __EXERCISE_2__)
  1000cd:	83 f8 02             	cmp    $0x2,%eax
  1000d0:	75 35                	jne    100107 <schedule+0x6b>
  1000d2:	b0 01                	mov    $0x1,%al
  1000d4:	ba 01 00 00 00       	mov    $0x1,%edx
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
				if(proc_array[pid].p_state == P_RUNNABLE)
  1000d9:	6b ca 5c             	imul   $0x5c,%edx,%ecx
  1000dc:	83 b9 1c 84 10 00 01 	cmpl   $0x1,0x10841c(%ecx)
  1000e3:	75 11                	jne    1000f6 <schedule+0x5a>
					run(&proc_array[pid]);
  1000e5:	6b c0 5c             	imul   $0x5c,%eax,%eax
  1000e8:	83 ec 0c             	sub    $0xc,%esp
  1000eb:	05 c8 83 10 00       	add    $0x1083c8,%eax
  1000f0:	50                   	push   %eax
  1000f1:	e8 7b 04 00 00       	call   100571 <run>
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == __EXERCISE_2__)
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
  1000f6:	8d 42 01             	lea    0x1(%edx),%eax
  1000f9:	83 f8 05             	cmp    $0x5,%eax
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == __EXERCISE_2__)
  1000fc:	89 c2                	mov    %eax,%edx
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
  1000fe:	7e d9                	jle    1000d9 <schedule+0x3d>
  100100:	b8 01 00 00 00       	mov    $0x1,%eax
  100105:	eb cd                	jmp    1000d4 <schedule+0x38>
				if(proc_array[pid].p_state == P_RUNNABLE)
					run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == __EXERCISE_4A__)
  100107:	83 f8 29             	cmp    $0x29,%eax
  10010a:	75 45                	jne    100151 <schedule+0xb5>
  10010c:	83 c9 ff             	or     $0xffffffff,%ecx
					&& proc_array[i].p_priority < lowest_val){
					lowest_val = proc_array[i].p_priority;
				}
			}
			//alternate if same priority value
			pid = (pid+1) % NPROCS;
  10010f:	bb 05 00 00 00       	mov    $0x5,%ebx
				if(proc_array[pid].p_state == P_RUNNABLE)
					run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == __EXERCISE_4A__)
  100114:	31 c0                	xor    %eax,%eax
	{
		while(1) {
			pid_t i;
			//find process with highest priority = lowest value
			for(i=1; i<=NPROCS; ++i){
				if(proc_array[i].p_state == P_RUNNABLE
  100116:	83 b8 78 84 10 00 01 	cmpl   $0x1,0x108478(%eax)
  10011d:	75 0c                	jne    10012b <schedule+0x8f>
  10011f:	8b b0 28 84 10 00    	mov    0x108428(%eax),%esi
  100125:	39 f1                	cmp    %esi,%ecx
  100127:	76 02                	jbe    10012b <schedule+0x8f>
  100129:	89 f1                	mov    %esi,%ecx
  10012b:	83 c0 5c             	add    $0x5c,%eax
	else if (scheduling_algorithm == __EXERCISE_4A__)
	{
		while(1) {
			pid_t i;
			//find process with highest priority = lowest value
			for(i=1; i<=NPROCS; ++i){
  10012e:	3d cc 01 00 00       	cmp    $0x1cc,%eax
  100133:	75 e1                	jne    100116 <schedule+0x7a>
					&& proc_array[i].p_priority < lowest_val){
					lowest_val = proc_array[i].p_priority;
				}
			}
			//alternate if same priority value
			pid = (pid+1) % NPROCS;
  100135:	8d 42 01             	lea    0x1(%edx),%eax
  100138:	99                   	cltd   
  100139:	f7 fb                	idiv   %ebx
			//run highest priority process
			if(proc_array[pid].p_state == P_RUNNABLE
  10013b:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10013e:	83 b8 1c 84 10 00 01 	cmpl   $0x1,0x10841c(%eax)
  100145:	75 cd                	jne    100114 <schedule+0x78>
  100147:	39 88 cc 83 10 00    	cmp    %ecx,0x1083cc(%eax)
  10014d:	77 c5                	ja     100114 <schedule+0x78>
  10014f:	eb 37                	jmp    100188 <schedule+0xec>
				&& proc_array[pid].p_priority <= lowest_val){
				run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == __EXERCISE_4B__)
  100151:	83 f8 2a             	cmp    $0x2a,%eax
  100154:	75 42                	jne    100198 <schedule+0xfc>
				else{
					proc_array[pid].p_num++;		
					run(&proc_array[pid]);
				}
			}
			pid = (pid+1) % NPROCS;
  100156:	b9 05 00 00 00       	mov    $0x5,%ecx
				}
			}
			pid = (pid+1) % NPROCS;
		}*/
		while(1){
			if(proc_array[pid].p_state == P_RUNNABLE){
  10015b:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10015e:	83 b8 1c 84 10 00 01 	cmpl   $0x1,0x10841c(%eax)
  100165:	75 29                	jne    100190 <schedule+0xf4>
				if(proc_array[pid].p_num >= proc_array[pid].p_share){
  100167:	8b 98 d4 83 10 00    	mov    0x1083d4(%eax),%ebx
  10016d:	3b 98 d0 83 10 00    	cmp    0x1083d0(%eax),%ebx
  100173:	72 0c                	jb     100181 <schedule+0xe5>
					proc_array[pid].p_num = 0;
  100175:	c7 80 d4 83 10 00 00 	movl   $0x0,0x1083d4(%eax)
  10017c:	00 00 00 
  10017f:	eb 0f                	jmp    100190 <schedule+0xf4>
				}
				else{
					proc_array[pid].p_num++;		
  100181:	43                   	inc    %ebx
  100182:	89 98 d4 83 10 00    	mov    %ebx,0x1083d4(%eax)
					run(&proc_array[pid]);
  100188:	83 ec 0c             	sub    $0xc,%esp
  10018b:	e9 5b ff ff ff       	jmp    1000eb <schedule+0x4f>
				}
			}
			pid = (pid+1) % NPROCS;
  100190:	8d 42 01             	lea    0x1(%edx),%eax
  100193:	99                   	cltd   
  100194:	f7 f9                	idiv   %ecx
		}
  100196:	eb c3                	jmp    10015b <schedule+0xbf>
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100198:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10019e:	50                   	push   %eax
  10019f:	68 30 0b 10 00       	push   $0x100b30
  1001a4:	68 00 01 00 00       	push   $0x100
  1001a9:	52                   	push   %edx
  1001aa:	e8 67 09 00 00       	call   100b16 <console_printf>
  1001af:	83 c4 10             	add    $0x10,%esp
  1001b2:	a3 00 80 19 00       	mov    %eax,0x198000
  1001b7:	eb fe                	jmp    1001b7 <schedule+0x11b>

001001b9 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001b9:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001ba:	a1 fc 8d 10 00       	mov    0x108dfc,%eax
  1001bf:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001c4:	56                   	push   %esi
  1001c5:	53                   	push   %ebx
  1001c6:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001ca:	8d 78 10             	lea    0x10(%eax),%edi
  1001cd:	89 de                	mov    %ebx,%esi
  1001cf:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001d1:	8b 53 28             	mov    0x28(%ebx),%edx
  1001d4:	83 fa 32             	cmp    $0x32,%edx
  1001d7:	74 1c                	je     1001f5 <interrupt+0x3c>
  1001d9:	77 0e                	ja     1001e9 <interrupt+0x30>
  1001db:	83 fa 30             	cmp    $0x30,%edx
  1001de:	74 1d                	je     1001fd <interrupt+0x44>
  1001e0:	77 20                	ja     100202 <interrupt+0x49>
  1001e2:	83 fa 20             	cmp    $0x20,%edx
  1001e5:	74 5d                	je     100244 <interrupt+0x8b>
  1001e7:	eb 60                	jmp    100249 <interrupt+0x90>
  1001e9:	83 fa 33             	cmp    $0x33,%edx
  1001ec:	74 2b                	je     100219 <interrupt+0x60>
  1001ee:	83 fa 34             	cmp    $0x34,%edx
  1001f1:	74 3a                	je     10022d <interrupt+0x74>
  1001f3:	eb 54                	jmp    100249 <interrupt+0x90>
	
	case INT_SYS_SET_PRIORITY:
		current->p_priority = reg->reg_eax;
  1001f5:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001f8:	89 50 04             	mov    %edx,0x4(%eax)
  1001fb:	eb 27                	jmp    100224 <interrupt+0x6b>
		run(current);

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001fd:	e8 9a fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100202:	a1 fc 8d 10 00       	mov    0x108dfc,%eax
		current->p_exit_status = reg->reg_eax;
  100207:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10020a:	c7 40 54 03 00 00 00 	movl   $0x3,0x54(%eax)
		current->p_exit_status = reg->reg_eax;
  100211:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  100214:	e8 83 fe ff ff       	call   10009c <schedule>

	case INT_SYS_SET_SHARE:
		/* Set register for p_share */
		current->p_share = reg->reg_eax;
  100219:	a1 fc 8d 10 00       	mov    0x108dfc,%eax
  10021e:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100221:	89 50 08             	mov    %edx,0x8(%eax)
		run(current);
  100224:	83 ec 0c             	sub    $0xc,%esp
  100227:	50                   	push   %eax
  100228:	e8 44 03 00 00       	call   100571 <run>

	case INT_SYS_PRINT:
		*cursorpos++ = reg->reg_eax;
  10022d:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100233:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  100236:	66 89 0a             	mov    %cx,(%edx)
  100239:	83 c2 02             	add    $0x2,%edx
  10023c:	89 15 00 80 19 00    	mov    %edx,0x198000
  100242:	eb e0                	jmp    100224 <interrupt+0x6b>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100244:	e8 53 fe ff ff       	call   10009c <schedule>
  100249:	eb fe                	jmp    100249 <interrupt+0x90>

0010024b <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10024b:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10024c:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100251:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100252:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100254:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100255:	bb 24 84 10 00       	mov    $0x108424,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10025a:	e8 f1 00 00 00       	call   100350 <segments_init>
	interrupt_controller_init(1);
  10025f:	83 ec 0c             	sub    $0xc,%esp
  100262:	6a 01                	push   $0x1
  100264:	e8 e2 01 00 00       	call   10044b <interrupt_controller_init>
	console_clear();
  100269:	e8 66 02 00 00       	call   1004d4 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10026e:	83 c4 0c             	add    $0xc,%esp
  100271:	68 cc 01 00 00       	push   $0x1cc
  100276:	6a 00                	push   $0x0
  100278:	68 c8 83 10 00       	push   $0x1083c8
  10027d:	e8 32 04 00 00       	call   1006b4 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100282:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100285:	c7 05 c8 83 10 00 00 	movl   $0x0,0x1083c8
  10028c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10028f:	c7 05 1c 84 10 00 00 	movl   $0x0,0x10841c
  100296:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100299:	c7 05 24 84 10 00 01 	movl   $0x1,0x108424
  1002a0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002a3:	c7 05 78 84 10 00 00 	movl   $0x0,0x108478
  1002aa:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ad:	c7 05 80 84 10 00 02 	movl   $0x2,0x108480
  1002b4:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002b7:	c7 05 d4 84 10 00 00 	movl   $0x0,0x1084d4
  1002be:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002c1:	c7 05 dc 84 10 00 03 	movl   $0x3,0x1084dc
  1002c8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002cb:	c7 05 30 85 10 00 00 	movl   $0x0,0x108530
  1002d2:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002d5:	c7 05 38 85 10 00 04 	movl   $0x4,0x108538
  1002dc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002df:	c7 05 8c 85 10 00 00 	movl   $0x0,0x10858c
  1002e6:	00 00 00 
		
		proc->p_priority = 0;
		proc->p_share = 1;
		proc->p_num = 0;
		// Initialize the process descriptor
		special_registers_init(proc);
  1002e9:	83 ec 0c             	sub    $0xc,%esp
  1002ec:	53                   	push   %ebx
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;
		
		proc->p_priority = 0;
  1002ed:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
		proc->p_share = 1;
  1002f4:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
		proc->p_num = 0;
  1002fb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
		// Initialize the process descriptor
		special_registers_init(proc);
  100302:	e8 81 02 00 00       	call   100588 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100307:	58                   	pop    %eax
  100308:	5a                   	pop    %edx
  100309:	8d 43 40             	lea    0x40(%ebx),%eax
		proc->p_num = 0;
		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10030c:	89 7b 4c             	mov    %edi,0x4c(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10030f:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100315:	50                   	push   %eax
  100316:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100317:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100318:	e8 a7 02 00 00       	call   1005c4 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10031d:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100320:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  100327:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10032a:	83 fe 04             	cmp    $0x4,%esi
  10032d:	75 ba                	jne    1002e9 <start+0x9e>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;

	// Switch to the first process.
	run(&proc_array[1]);
  10032f:	83 ec 0c             	sub    $0xc,%esp
  100332:	68 24 84 10 00       	push   $0x108424
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100337:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10033e:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;
  100341:	c7 05 00 8e 10 00 00 	movl   $0x0,0x108e00
  100348:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10034b:	e8 21 02 00 00       	call   100571 <run>

00100350 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100350:	b8 94 85 10 00       	mov    $0x108594,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100355:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10035a:	89 c2                	mov    %eax,%edx
  10035c:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10035f:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100360:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100365:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100368:	66 a3 be 1b 10 00    	mov    %ax,0x101bbe
  10036e:	c1 e8 18             	shr    $0x18,%eax
  100371:	88 15 c0 1b 10 00    	mov    %dl,0x101bc0
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100377:	ba fc 85 10 00       	mov    $0x1085fc,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10037c:	a2 c3 1b 10 00       	mov    %al,0x101bc3
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100381:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100383:	66 c7 05 bc 1b 10 00 	movw   $0x68,0x101bbc
  10038a:	68 00 
  10038c:	c6 05 c2 1b 10 00 40 	movb   $0x40,0x101bc2
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100393:	c6 05 c1 1b 10 00 89 	movb   $0x89,0x101bc1

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10039a:	c7 05 98 85 10 00 00 	movl   $0x180000,0x108598
  1003a1:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003a4:	66 c7 05 9c 85 10 00 	movw   $0x10,0x10859c
  1003ab:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003ad:	66 89 0c c5 fc 85 10 	mov    %cx,0x1085fc(,%eax,8)
  1003b4:	00 
  1003b5:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003bc:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003c1:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003c6:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003cb:	40                   	inc    %eax
  1003cc:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003d1:	75 da                	jne    1003ad <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003d3:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003d8:	ba fc 85 10 00       	mov    $0x1085fc,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003dd:	66 a3 fc 86 10 00    	mov    %ax,0x1086fc
  1003e3:	c1 e8 10             	shr    $0x10,%eax
  1003e6:	66 a3 02 87 10 00    	mov    %ax,0x108702
  1003ec:	b8 30 00 00 00       	mov    $0x30,%eax
  1003f1:	66 c7 05 fe 86 10 00 	movw   $0x8,0x1086fe
  1003f8:	08 00 
  1003fa:	c6 05 00 87 10 00 00 	movb   $0x0,0x108700
  100401:	c6 05 01 87 10 00 8e 	movb   $0x8e,0x108701

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100408:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10040f:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100416:	66 89 0c c5 fc 85 10 	mov    %cx,0x1085fc(,%eax,8)
  10041d:	00 
  10041e:	c1 e9 10             	shr    $0x10,%ecx
  100421:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100426:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10042b:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100430:	40                   	inc    %eax
  100431:	83 f8 3a             	cmp    $0x3a,%eax
  100434:	75 d2                	jne    100408 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100436:	b0 28                	mov    $0x28,%al
  100438:	0f 01 15 84 1b 10 00 	lgdtl  0x101b84
  10043f:	0f 00 d8             	ltr    %ax
  100442:	0f 01 1d 8c 1b 10 00 	lidtl  0x101b8c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100449:	5b                   	pop    %ebx
  10044a:	c3                   	ret    

0010044b <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10044b:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  10044c:	b0 ff                	mov    $0xff,%al
  10044e:	57                   	push   %edi
  10044f:	56                   	push   %esi
  100450:	53                   	push   %ebx
  100451:	bb 21 00 00 00       	mov    $0x21,%ebx
  100456:	89 da                	mov    %ebx,%edx
  100458:	ee                   	out    %al,(%dx)
  100459:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10045e:	89 ca                	mov    %ecx,%edx
  100460:	ee                   	out    %al,(%dx)
  100461:	be 11 00 00 00       	mov    $0x11,%esi
  100466:	bf 20 00 00 00       	mov    $0x20,%edi
  10046b:	89 f0                	mov    %esi,%eax
  10046d:	89 fa                	mov    %edi,%edx
  10046f:	ee                   	out    %al,(%dx)
  100470:	b0 20                	mov    $0x20,%al
  100472:	89 da                	mov    %ebx,%edx
  100474:	ee                   	out    %al,(%dx)
  100475:	b0 04                	mov    $0x4,%al
  100477:	ee                   	out    %al,(%dx)
  100478:	b0 03                	mov    $0x3,%al
  10047a:	ee                   	out    %al,(%dx)
  10047b:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100480:	89 f0                	mov    %esi,%eax
  100482:	89 ea                	mov    %ebp,%edx
  100484:	ee                   	out    %al,(%dx)
  100485:	b0 28                	mov    $0x28,%al
  100487:	89 ca                	mov    %ecx,%edx
  100489:	ee                   	out    %al,(%dx)
  10048a:	b0 02                	mov    $0x2,%al
  10048c:	ee                   	out    %al,(%dx)
  10048d:	b0 01                	mov    $0x1,%al
  10048f:	ee                   	out    %al,(%dx)
  100490:	b0 68                	mov    $0x68,%al
  100492:	89 fa                	mov    %edi,%edx
  100494:	ee                   	out    %al,(%dx)
  100495:	be 0a 00 00 00       	mov    $0xa,%esi
  10049a:	89 f0                	mov    %esi,%eax
  10049c:	ee                   	out    %al,(%dx)
  10049d:	b0 68                	mov    $0x68,%al
  10049f:	89 ea                	mov    %ebp,%edx
  1004a1:	ee                   	out    %al,(%dx)
  1004a2:	89 f0                	mov    %esi,%eax
  1004a4:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004a5:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004aa:	89 da                	mov    %ebx,%edx
  1004ac:	19 c0                	sbb    %eax,%eax
  1004ae:	f7 d0                	not    %eax
  1004b0:	05 ff 00 00 00       	add    $0xff,%eax
  1004b5:	ee                   	out    %al,(%dx)
  1004b6:	b0 ff                	mov    $0xff,%al
  1004b8:	89 ca                	mov    %ecx,%edx
  1004ba:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004bb:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004c0:	74 0d                	je     1004cf <interrupt_controller_init+0x84>
  1004c2:	b2 43                	mov    $0x43,%dl
  1004c4:	b0 34                	mov    $0x34,%al
  1004c6:	ee                   	out    %al,(%dx)
  1004c7:	b0 8e                	mov    $0x8e,%al
  1004c9:	b2 40                	mov    $0x40,%dl
  1004cb:	ee                   	out    %al,(%dx)
  1004cc:	b0 01                	mov    $0x1,%al
  1004ce:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004cf:	5b                   	pop    %ebx
  1004d0:	5e                   	pop    %esi
  1004d1:	5f                   	pop    %edi
  1004d2:	5d                   	pop    %ebp
  1004d3:	c3                   	ret    

001004d4 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004d4:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004d5:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004d7:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004d8:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004df:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1004e2:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1004e8:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1004ee:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004f1:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1004f6:	75 ea                	jne    1004e2 <console_clear+0xe>
  1004f8:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004fd:	b0 0e                	mov    $0xe,%al
  1004ff:	89 f2                	mov    %esi,%edx
  100501:	ee                   	out    %al,(%dx)
  100502:	31 c9                	xor    %ecx,%ecx
  100504:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100509:	88 c8                	mov    %cl,%al
  10050b:	89 da                	mov    %ebx,%edx
  10050d:	ee                   	out    %al,(%dx)
  10050e:	b0 0f                	mov    $0xf,%al
  100510:	89 f2                	mov    %esi,%edx
  100512:	ee                   	out    %al,(%dx)
  100513:	88 c8                	mov    %cl,%al
  100515:	89 da                	mov    %ebx,%edx
  100517:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100518:	5b                   	pop    %ebx
  100519:	5e                   	pop    %esi
  10051a:	c3                   	ret    

0010051b <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10051b:	ba 64 00 00 00       	mov    $0x64,%edx
  100520:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100521:	a8 01                	test   $0x1,%al
  100523:	74 45                	je     10056a <console_read_digit+0x4f>
  100525:	b2 60                	mov    $0x60,%dl
  100527:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100528:	8d 50 fe             	lea    -0x2(%eax),%edx
  10052b:	80 fa 08             	cmp    $0x8,%dl
  10052e:	77 05                	ja     100535 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100530:	0f b6 c0             	movzbl %al,%eax
  100533:	48                   	dec    %eax
  100534:	c3                   	ret    
	else if (data == 0x0B)
  100535:	3c 0b                	cmp    $0xb,%al
  100537:	74 35                	je     10056e <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100539:	8d 50 b9             	lea    -0x47(%eax),%edx
  10053c:	80 fa 02             	cmp    $0x2,%dl
  10053f:	77 07                	ja     100548 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100541:	0f b6 c0             	movzbl %al,%eax
  100544:	83 e8 40             	sub    $0x40,%eax
  100547:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100548:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10054b:	80 fa 02             	cmp    $0x2,%dl
  10054e:	77 07                	ja     100557 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100550:	0f b6 c0             	movzbl %al,%eax
  100553:	83 e8 47             	sub    $0x47,%eax
  100556:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100557:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10055a:	80 fa 02             	cmp    $0x2,%dl
  10055d:	77 07                	ja     100566 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10055f:	0f b6 c0             	movzbl %al,%eax
  100562:	83 e8 4e             	sub    $0x4e,%eax
  100565:	c3                   	ret    
	else if (data == 0x53)
  100566:	3c 53                	cmp    $0x53,%al
  100568:	74 04                	je     10056e <console_read_digit+0x53>
  10056a:	83 c8 ff             	or     $0xffffffff,%eax
  10056d:	c3                   	ret    
  10056e:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100570:	c3                   	ret    

00100571 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100571:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100575:	a3 fc 8d 10 00       	mov    %eax,0x108dfc

	asm volatile("movl %0,%%esp\n\t"
  10057a:	83 c0 10             	add    $0x10,%eax
  10057d:	89 c4                	mov    %eax,%esp
  10057f:	61                   	popa   
  100580:	07                   	pop    %es
  100581:	1f                   	pop    %ds
  100582:	83 c4 08             	add    $0x8,%esp
  100585:	cf                   	iret   
  100586:	eb fe                	jmp    100586 <run+0x15>

00100588 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100588:	53                   	push   %ebx
  100589:	83 ec 0c             	sub    $0xc,%esp
  10058c:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100590:	6a 44                	push   $0x44
  100592:	6a 00                	push   $0x0
  100594:	8d 43 10             	lea    0x10(%ebx),%eax
  100597:	50                   	push   %eax
  100598:	e8 17 01 00 00       	call   1006b4 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  10059d:	66 c7 43 44 1b 00    	movw   $0x1b,0x44(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005a3:	66 c7 43 34 23 00    	movw   $0x23,0x34(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005a9:	66 c7 43 30 23 00    	movw   $0x23,0x30(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005af:	66 c7 43 50 23 00    	movw   $0x23,0x50(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005b5:	c7 43 48 00 02 00 00 	movl   $0x200,0x48(%ebx)
}
  1005bc:	83 c4 18             	add    $0x18,%esp
  1005bf:	5b                   	pop    %ebx
  1005c0:	c3                   	ret    
  1005c1:	90                   	nop
  1005c2:	90                   	nop
  1005c3:	90                   	nop

001005c4 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005c4:	55                   	push   %ebp
  1005c5:	57                   	push   %edi
  1005c6:	56                   	push   %esi
  1005c7:	53                   	push   %ebx
  1005c8:	83 ec 1c             	sub    $0x1c,%esp
  1005cb:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005cf:	83 f8 03             	cmp    $0x3,%eax
  1005d2:	7f 04                	jg     1005d8 <program_loader+0x14>
  1005d4:	85 c0                	test   %eax,%eax
  1005d6:	79 02                	jns    1005da <program_loader+0x16>
  1005d8:	eb fe                	jmp    1005d8 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1005da:	8b 34 c5 c4 1b 10 00 	mov    0x101bc4(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1005e1:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1005e7:	74 02                	je     1005eb <program_loader+0x27>
  1005e9:	eb fe                	jmp    1005e9 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005eb:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1005ee:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005f2:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005f4:	c1 e5 05             	shl    $0x5,%ebp
  1005f7:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1005fa:	eb 3f                	jmp    10063b <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005fc:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005ff:	75 37                	jne    100638 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100601:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100604:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100607:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10060a:	01 c7                	add    %eax,%edi
	memsz += va;
  10060c:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10060e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100613:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100617:	52                   	push   %edx
  100618:	89 fa                	mov    %edi,%edx
  10061a:	29 c2                	sub    %eax,%edx
  10061c:	52                   	push   %edx
  10061d:	8b 53 04             	mov    0x4(%ebx),%edx
  100620:	01 f2                	add    %esi,%edx
  100622:	52                   	push   %edx
  100623:	50                   	push   %eax
  100624:	e8 27 00 00 00       	call   100650 <memcpy>
  100629:	83 c4 10             	add    $0x10,%esp
  10062c:	eb 04                	jmp    100632 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10062e:	c6 07 00             	movb   $0x0,(%edi)
  100631:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100632:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100636:	72 f6                	jb     10062e <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100638:	83 c3 20             	add    $0x20,%ebx
  10063b:	39 eb                	cmp    %ebp,%ebx
  10063d:	72 bd                	jb     1005fc <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10063f:	8b 56 18             	mov    0x18(%esi),%edx
  100642:	8b 44 24 34          	mov    0x34(%esp),%eax
  100646:	89 10                	mov    %edx,(%eax)
}
  100648:	83 c4 1c             	add    $0x1c,%esp
  10064b:	5b                   	pop    %ebx
  10064c:	5e                   	pop    %esi
  10064d:	5f                   	pop    %edi
  10064e:	5d                   	pop    %ebp
  10064f:	c3                   	ret    

00100650 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100650:	56                   	push   %esi
  100651:	31 d2                	xor    %edx,%edx
  100653:	53                   	push   %ebx
  100654:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100658:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10065c:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100660:	eb 08                	jmp    10066a <memcpy+0x1a>
		*d++ = *s++;
  100662:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100665:	4e                   	dec    %esi
  100666:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100669:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10066a:	85 f6                	test   %esi,%esi
  10066c:	75 f4                	jne    100662 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10066e:	5b                   	pop    %ebx
  10066f:	5e                   	pop    %esi
  100670:	c3                   	ret    

00100671 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100671:	57                   	push   %edi
  100672:	56                   	push   %esi
  100673:	53                   	push   %ebx
  100674:	8b 44 24 10          	mov    0x10(%esp),%eax
  100678:	8b 7c 24 14          	mov    0x14(%esp),%edi
  10067c:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100680:	39 c7                	cmp    %eax,%edi
  100682:	73 26                	jae    1006aa <memmove+0x39>
  100684:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100687:	39 c6                	cmp    %eax,%esi
  100689:	76 1f                	jbe    1006aa <memmove+0x39>
		s += n, d += n;
  10068b:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10068e:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100690:	eb 07                	jmp    100699 <memmove+0x28>
			*--d = *--s;
  100692:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100695:	4a                   	dec    %edx
  100696:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100699:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10069a:	85 d2                	test   %edx,%edx
  10069c:	75 f4                	jne    100692 <memmove+0x21>
  10069e:	eb 10                	jmp    1006b0 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006a0:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006a3:	4a                   	dec    %edx
  1006a4:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006a7:	41                   	inc    %ecx
  1006a8:	eb 02                	jmp    1006ac <memmove+0x3b>
  1006aa:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006ac:	85 d2                	test   %edx,%edx
  1006ae:	75 f0                	jne    1006a0 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006b0:	5b                   	pop    %ebx
  1006b1:	5e                   	pop    %esi
  1006b2:	5f                   	pop    %edi
  1006b3:	c3                   	ret    

001006b4 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006b4:	53                   	push   %ebx
  1006b5:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006b9:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006bd:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006c1:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006c3:	eb 04                	jmp    1006c9 <memset+0x15>
		*p++ = c;
  1006c5:	88 1a                	mov    %bl,(%edx)
  1006c7:	49                   	dec    %ecx
  1006c8:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006c9:	85 c9                	test   %ecx,%ecx
  1006cb:	75 f8                	jne    1006c5 <memset+0x11>
		*p++ = c;
	return v;
}
  1006cd:	5b                   	pop    %ebx
  1006ce:	c3                   	ret    

001006cf <strlen>:

size_t
strlen(const char *s)
{
  1006cf:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006d3:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006d5:	eb 01                	jmp    1006d8 <strlen+0x9>
		++n;
  1006d7:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006d8:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1006dc:	75 f9                	jne    1006d7 <strlen+0x8>
		++n;
	return n;
}
  1006de:	c3                   	ret    

001006df <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1006df:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1006e3:	31 c0                	xor    %eax,%eax
  1006e5:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006e9:	eb 01                	jmp    1006ec <strnlen+0xd>
		++n;
  1006eb:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006ec:	39 d0                	cmp    %edx,%eax
  1006ee:	74 06                	je     1006f6 <strnlen+0x17>
  1006f0:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006f4:	75 f5                	jne    1006eb <strnlen+0xc>
		++n;
	return n;
}
  1006f6:	c3                   	ret    

001006f7 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006f7:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1006f8:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006fd:	53                   	push   %ebx
  1006fe:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100700:	76 05                	jbe    100707 <console_putc+0x10>
  100702:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100707:	80 fa 0a             	cmp    $0xa,%dl
  10070a:	75 2c                	jne    100738 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10070c:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100712:	be 50 00 00 00       	mov    $0x50,%esi
  100717:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100719:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10071c:	99                   	cltd   
  10071d:	f7 fe                	idiv   %esi
  10071f:	89 de                	mov    %ebx,%esi
  100721:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100723:	eb 07                	jmp    10072c <console_putc+0x35>
			*cursor++ = ' ' | color;
  100725:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100728:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100729:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10072c:	83 f8 50             	cmp    $0x50,%eax
  10072f:	75 f4                	jne    100725 <console_putc+0x2e>
  100731:	29 d0                	sub    %edx,%eax
  100733:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100736:	eb 0b                	jmp    100743 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100738:	0f b6 d2             	movzbl %dl,%edx
  10073b:	09 ca                	or     %ecx,%edx
  10073d:	66 89 13             	mov    %dx,(%ebx)
  100740:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100743:	5b                   	pop    %ebx
  100744:	5e                   	pop    %esi
  100745:	c3                   	ret    

00100746 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100746:	56                   	push   %esi
  100747:	53                   	push   %ebx
  100748:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  10074c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10074f:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100753:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100758:	75 04                	jne    10075e <fill_numbuf+0x18>
  10075a:	85 d2                	test   %edx,%edx
  10075c:	74 10                	je     10076e <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10075e:	89 d0                	mov    %edx,%eax
  100760:	31 d2                	xor    %edx,%edx
  100762:	f7 f1                	div    %ecx
  100764:	4b                   	dec    %ebx
  100765:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100768:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10076a:	89 c2                	mov    %eax,%edx
  10076c:	eb ec                	jmp    10075a <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10076e:	89 d8                	mov    %ebx,%eax
  100770:	5b                   	pop    %ebx
  100771:	5e                   	pop    %esi
  100772:	c3                   	ret    

00100773 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100773:	55                   	push   %ebp
  100774:	57                   	push   %edi
  100775:	56                   	push   %esi
  100776:	53                   	push   %ebx
  100777:	83 ec 38             	sub    $0x38,%esp
  10077a:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10077e:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100782:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100786:	e9 60 03 00 00       	jmp    100aeb <console_vprintf+0x378>
		if (*format != '%') {
  10078b:	80 fa 25             	cmp    $0x25,%dl
  10078e:	74 13                	je     1007a3 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100790:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100794:	0f b6 d2             	movzbl %dl,%edx
  100797:	89 f0                	mov    %esi,%eax
  100799:	e8 59 ff ff ff       	call   1006f7 <console_putc>
  10079e:	e9 45 03 00 00       	jmp    100ae8 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007a3:	47                   	inc    %edi
  1007a4:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007ab:	00 
  1007ac:	eb 12                	jmp    1007c0 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007ae:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007af:	8a 11                	mov    (%ecx),%dl
  1007b1:	84 d2                	test   %dl,%dl
  1007b3:	74 1a                	je     1007cf <console_vprintf+0x5c>
  1007b5:	89 e8                	mov    %ebp,%eax
  1007b7:	38 c2                	cmp    %al,%dl
  1007b9:	75 f3                	jne    1007ae <console_vprintf+0x3b>
  1007bb:	e9 3f 03 00 00       	jmp    100aff <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007c0:	8a 17                	mov    (%edi),%dl
  1007c2:	84 d2                	test   %dl,%dl
  1007c4:	74 0b                	je     1007d1 <console_vprintf+0x5e>
  1007c6:	b9 54 0b 10 00       	mov    $0x100b54,%ecx
  1007cb:	89 d5                	mov    %edx,%ebp
  1007cd:	eb e0                	jmp    1007af <console_vprintf+0x3c>
  1007cf:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007d1:	8d 42 cf             	lea    -0x31(%edx),%eax
  1007d4:	3c 08                	cmp    $0x8,%al
  1007d6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1007dd:	00 
  1007de:	76 13                	jbe    1007f3 <console_vprintf+0x80>
  1007e0:	eb 1d                	jmp    1007ff <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1007e2:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1007e7:	0f be c0             	movsbl %al,%eax
  1007ea:	47                   	inc    %edi
  1007eb:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1007ef:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1007f3:	8a 07                	mov    (%edi),%al
  1007f5:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007f8:	80 fa 09             	cmp    $0x9,%dl
  1007fb:	76 e5                	jbe    1007e2 <console_vprintf+0x6f>
  1007fd:	eb 18                	jmp    100817 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007ff:	80 fa 2a             	cmp    $0x2a,%dl
  100802:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100809:	ff 
  10080a:	75 0b                	jne    100817 <console_vprintf+0xa4>
			width = va_arg(val, int);
  10080c:	83 c3 04             	add    $0x4,%ebx
			++format;
  10080f:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100810:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100813:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100817:	83 cd ff             	or     $0xffffffff,%ebp
  10081a:	80 3f 2e             	cmpb   $0x2e,(%edi)
  10081d:	75 37                	jne    100856 <console_vprintf+0xe3>
			++format;
  10081f:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100820:	31 ed                	xor    %ebp,%ebp
  100822:	8a 07                	mov    (%edi),%al
  100824:	8d 50 d0             	lea    -0x30(%eax),%edx
  100827:	80 fa 09             	cmp    $0x9,%dl
  10082a:	76 0d                	jbe    100839 <console_vprintf+0xc6>
  10082c:	eb 17                	jmp    100845 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10082e:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100831:	0f be c0             	movsbl %al,%eax
  100834:	47                   	inc    %edi
  100835:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100839:	8a 07                	mov    (%edi),%al
  10083b:	8d 50 d0             	lea    -0x30(%eax),%edx
  10083e:	80 fa 09             	cmp    $0x9,%dl
  100841:	76 eb                	jbe    10082e <console_vprintf+0xbb>
  100843:	eb 11                	jmp    100856 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100845:	3c 2a                	cmp    $0x2a,%al
  100847:	75 0b                	jne    100854 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100849:	83 c3 04             	add    $0x4,%ebx
				++format;
  10084c:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  10084d:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100850:	85 ed                	test   %ebp,%ebp
  100852:	79 02                	jns    100856 <console_vprintf+0xe3>
  100854:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100856:	8a 07                	mov    (%edi),%al
  100858:	3c 64                	cmp    $0x64,%al
  10085a:	74 34                	je     100890 <console_vprintf+0x11d>
  10085c:	7f 1d                	jg     10087b <console_vprintf+0x108>
  10085e:	3c 58                	cmp    $0x58,%al
  100860:	0f 84 a2 00 00 00    	je     100908 <console_vprintf+0x195>
  100866:	3c 63                	cmp    $0x63,%al
  100868:	0f 84 bf 00 00 00    	je     10092d <console_vprintf+0x1ba>
  10086e:	3c 43                	cmp    $0x43,%al
  100870:	0f 85 d0 00 00 00    	jne    100946 <console_vprintf+0x1d3>
  100876:	e9 a3 00 00 00       	jmp    10091e <console_vprintf+0x1ab>
  10087b:	3c 75                	cmp    $0x75,%al
  10087d:	74 4d                	je     1008cc <console_vprintf+0x159>
  10087f:	3c 78                	cmp    $0x78,%al
  100881:	74 5c                	je     1008df <console_vprintf+0x16c>
  100883:	3c 73                	cmp    $0x73,%al
  100885:	0f 85 bb 00 00 00    	jne    100946 <console_vprintf+0x1d3>
  10088b:	e9 86 00 00 00       	jmp    100916 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100890:	83 c3 04             	add    $0x4,%ebx
  100893:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100896:	89 d1                	mov    %edx,%ecx
  100898:	c1 f9 1f             	sar    $0x1f,%ecx
  10089b:	89 0c 24             	mov    %ecx,(%esp)
  10089e:	31 ca                	xor    %ecx,%edx
  1008a0:	55                   	push   %ebp
  1008a1:	29 ca                	sub    %ecx,%edx
  1008a3:	68 5c 0b 10 00       	push   $0x100b5c
  1008a8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008ad:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008b1:	e8 90 fe ff ff       	call   100746 <fill_numbuf>
  1008b6:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008ba:	58                   	pop    %eax
  1008bb:	5a                   	pop    %edx
  1008bc:	ba 01 00 00 00       	mov    $0x1,%edx
  1008c1:	8b 04 24             	mov    (%esp),%eax
  1008c4:	83 e0 01             	and    $0x1,%eax
  1008c7:	e9 a5 00 00 00       	jmp    100971 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008cc:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008d4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008d7:	55                   	push   %ebp
  1008d8:	68 5c 0b 10 00       	push   $0x100b5c
  1008dd:	eb 11                	jmp    1008f0 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1008df:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1008e2:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008e5:	55                   	push   %ebp
  1008e6:	68 70 0b 10 00       	push   $0x100b70
  1008eb:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008f0:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008f4:	e8 4d fe ff ff       	call   100746 <fill_numbuf>
  1008f9:	ba 01 00 00 00       	mov    $0x1,%edx
  1008fe:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100902:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100904:	59                   	pop    %ecx
  100905:	59                   	pop    %ecx
  100906:	eb 69                	jmp    100971 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100908:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10090b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10090e:	55                   	push   %ebp
  10090f:	68 5c 0b 10 00       	push   $0x100b5c
  100914:	eb d5                	jmp    1008eb <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100916:	83 c3 04             	add    $0x4,%ebx
  100919:	8b 43 fc             	mov    -0x4(%ebx),%eax
  10091c:	eb 40                	jmp    10095e <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10091e:	83 c3 04             	add    $0x4,%ebx
  100921:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100924:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100928:	e9 bd 01 00 00       	jmp    100aea <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10092d:	83 c3 04             	add    $0x4,%ebx
  100930:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100933:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100937:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  10093c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100940:	88 44 24 24          	mov    %al,0x24(%esp)
  100944:	eb 27                	jmp    10096d <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100946:	84 c0                	test   %al,%al
  100948:	75 02                	jne    10094c <console_vprintf+0x1d9>
  10094a:	b0 25                	mov    $0x25,%al
  10094c:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100950:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100955:	80 3f 00             	cmpb   $0x0,(%edi)
  100958:	74 0a                	je     100964 <console_vprintf+0x1f1>
  10095a:	8d 44 24 24          	lea    0x24(%esp),%eax
  10095e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100962:	eb 09                	jmp    10096d <console_vprintf+0x1fa>
				format--;
  100964:	8d 54 24 24          	lea    0x24(%esp),%edx
  100968:	4f                   	dec    %edi
  100969:	89 54 24 04          	mov    %edx,0x4(%esp)
  10096d:	31 d2                	xor    %edx,%edx
  10096f:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100971:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100973:	83 fd ff             	cmp    $0xffffffff,%ebp
  100976:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10097d:	74 1f                	je     10099e <console_vprintf+0x22b>
  10097f:	89 04 24             	mov    %eax,(%esp)
  100982:	eb 01                	jmp    100985 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100984:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100985:	39 e9                	cmp    %ebp,%ecx
  100987:	74 0a                	je     100993 <console_vprintf+0x220>
  100989:	8b 44 24 04          	mov    0x4(%esp),%eax
  10098d:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100991:	75 f1                	jne    100984 <console_vprintf+0x211>
  100993:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100996:	89 0c 24             	mov    %ecx,(%esp)
  100999:	eb 1f                	jmp    1009ba <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  10099b:	42                   	inc    %edx
  10099c:	eb 09                	jmp    1009a7 <console_vprintf+0x234>
  10099e:	89 d1                	mov    %edx,%ecx
  1009a0:	8b 14 24             	mov    (%esp),%edx
  1009a3:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009a7:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009ab:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009af:	75 ea                	jne    10099b <console_vprintf+0x228>
  1009b1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009b5:	89 14 24             	mov    %edx,(%esp)
  1009b8:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009ba:	85 c0                	test   %eax,%eax
  1009bc:	74 0c                	je     1009ca <console_vprintf+0x257>
  1009be:	84 d2                	test   %dl,%dl
  1009c0:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009c7:	00 
  1009c8:	75 24                	jne    1009ee <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009ca:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009cf:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1009d6:	00 
  1009d7:	75 15                	jne    1009ee <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1009d9:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009dd:	83 e0 08             	and    $0x8,%eax
  1009e0:	83 f8 01             	cmp    $0x1,%eax
  1009e3:	19 c9                	sbb    %ecx,%ecx
  1009e5:	f7 d1                	not    %ecx
  1009e7:	83 e1 20             	and    $0x20,%ecx
  1009ea:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009ee:	3b 2c 24             	cmp    (%esp),%ebp
  1009f1:	7e 0d                	jle    100a00 <console_vprintf+0x28d>
  1009f3:	84 d2                	test   %dl,%dl
  1009f5:	74 40                	je     100a37 <console_vprintf+0x2c4>
			zeros = precision - len;
  1009f7:	2b 2c 24             	sub    (%esp),%ebp
  1009fa:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009fe:	eb 3f                	jmp    100a3f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a00:	84 d2                	test   %dl,%dl
  100a02:	74 33                	je     100a37 <console_vprintf+0x2c4>
  100a04:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a08:	83 e0 06             	and    $0x6,%eax
  100a0b:	83 f8 02             	cmp    $0x2,%eax
  100a0e:	75 27                	jne    100a37 <console_vprintf+0x2c4>
  100a10:	45                   	inc    %ebp
  100a11:	75 24                	jne    100a37 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a13:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a15:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a18:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a1d:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a20:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a23:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a27:	7d 0e                	jge    100a37 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a29:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a2d:	29 ca                	sub    %ecx,%edx
  100a2f:	29 c2                	sub    %eax,%edx
  100a31:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a35:	eb 08                	jmp    100a3f <console_vprintf+0x2cc>
  100a37:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a3e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a3f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a43:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a45:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a49:	2b 2c 24             	sub    (%esp),%ebp
  100a4c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a51:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a54:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a57:	29 c5                	sub    %eax,%ebp
  100a59:	89 f0                	mov    %esi,%eax
  100a5b:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a5f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a63:	eb 0f                	jmp    100a74 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a65:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a69:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a6e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a6f:	e8 83 fc ff ff       	call   1006f7 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a74:	85 ed                	test   %ebp,%ebp
  100a76:	7e 07                	jle    100a7f <console_vprintf+0x30c>
  100a78:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a7d:	74 e6                	je     100a65 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a7f:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a84:	89 c6                	mov    %eax,%esi
  100a86:	74 23                	je     100aab <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a88:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a8d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a91:	e8 61 fc ff ff       	call   1006f7 <console_putc>
  100a96:	89 c6                	mov    %eax,%esi
  100a98:	eb 11                	jmp    100aab <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a9a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a9e:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100aa3:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100aa4:	e8 4e fc ff ff       	call   1006f7 <console_putc>
  100aa9:	eb 06                	jmp    100ab1 <console_vprintf+0x33e>
  100aab:	89 f0                	mov    %esi,%eax
  100aad:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ab1:	85 f6                	test   %esi,%esi
  100ab3:	7f e5                	jg     100a9a <console_vprintf+0x327>
  100ab5:	8b 34 24             	mov    (%esp),%esi
  100ab8:	eb 15                	jmp    100acf <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100aba:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100abe:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100abf:	0f b6 11             	movzbl (%ecx),%edx
  100ac2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ac6:	e8 2c fc ff ff       	call   1006f7 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100acb:	ff 44 24 04          	incl   0x4(%esp)
  100acf:	85 f6                	test   %esi,%esi
  100ad1:	7f e7                	jg     100aba <console_vprintf+0x347>
  100ad3:	eb 0f                	jmp    100ae4 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100ad5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ad9:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100ade:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100adf:	e8 13 fc ff ff       	call   1006f7 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100ae4:	85 ed                	test   %ebp,%ebp
  100ae6:	7f ed                	jg     100ad5 <console_vprintf+0x362>
  100ae8:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100aea:	47                   	inc    %edi
  100aeb:	8a 17                	mov    (%edi),%dl
  100aed:	84 d2                	test   %dl,%dl
  100aef:	0f 85 96 fc ff ff    	jne    10078b <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100af5:	83 c4 38             	add    $0x38,%esp
  100af8:	89 f0                	mov    %esi,%eax
  100afa:	5b                   	pop    %ebx
  100afb:	5e                   	pop    %esi
  100afc:	5f                   	pop    %edi
  100afd:	5d                   	pop    %ebp
  100afe:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100aff:	81 e9 54 0b 10 00    	sub    $0x100b54,%ecx
  100b05:	b8 01 00 00 00       	mov    $0x1,%eax
  100b0a:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b0c:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b0d:	09 44 24 14          	or     %eax,0x14(%esp)
  100b11:	e9 aa fc ff ff       	jmp    1007c0 <console_vprintf+0x4d>

00100b16 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b16:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b1a:	50                   	push   %eax
  100b1b:	ff 74 24 10          	pushl  0x10(%esp)
  100b1f:	ff 74 24 10          	pushl  0x10(%esp)
  100b23:	ff 74 24 10          	pushl  0x10(%esp)
  100b27:	e8 47 fc ff ff       	call   100773 <console_vprintf>
  100b2c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b2f:	c3                   	ret    
