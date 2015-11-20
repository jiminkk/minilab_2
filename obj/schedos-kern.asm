
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
  100014:	e8 17 02 00 00       	call   100230 <start>
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
  10006d:	e8 45 01 00 00       	call   1001b7 <interrupt>

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
  1000a1:	a1 54 7d 10 00       	mov    0x107d54,%eax
  1000a6:	8b 10                	mov    (%eax),%edx
	unsigned int lowest_val;
	lowest_val = 0xffffffff; // INTMAX

	if (scheduling_algorithm == 0)
  1000a8:	a1 58 7d 10 00       	mov    0x107d58,%eax
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
  1000bf:	83 b8 74 73 10 00 01 	cmpl   $0x1,0x107374(%eax)
  1000c6:	75 ee                	jne    1000b6 <schedule+0x1a>
  1000c8:	e9 b9 00 00 00       	jmp    100186 <schedule+0xea>
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == 1)
  1000cd:	83 f8 01             	cmp    $0x1,%eax
  1000d0:	75 33                	jne    100105 <schedule+0x69>
  1000d2:	ba 01 00 00 00       	mov    $0x1,%edx
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
				if(proc_array[pid].p_state == P_RUNNABLE)
  1000d7:	6b ca 5c             	imul   $0x5c,%edx,%ecx
  1000da:	83 b9 74 73 10 00 01 	cmpl   $0x1,0x107374(%ecx)
  1000e1:	75 11                	jne    1000f4 <schedule+0x58>
					run(&proc_array[pid]);
  1000e3:	6b c0 5c             	imul   $0x5c,%eax,%eax
  1000e6:	83 ec 0c             	sub    $0xc,%esp
  1000e9:	05 20 73 10 00       	add    $0x107320,%eax
  1000ee:	50                   	push   %eax
  1000ef:	e8 65 04 00 00       	call   100559 <run>
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == 1)
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
  1000f4:	8d 42 01             	lea    0x1(%edx),%eax
  1000f7:	83 f8 05             	cmp    $0x5,%eax
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == 1)
  1000fa:	89 c2                	mov    %eax,%edx
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
  1000fc:	7e d9                	jle    1000d7 <schedule+0x3b>
  1000fe:	b8 01 00 00 00       	mov    $0x1,%eax
  100103:	eb cd                	jmp    1000d2 <schedule+0x36>
				if(proc_array[pid].p_state == P_RUNNABLE)
					run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == 2)
  100105:	83 f8 02             	cmp    $0x2,%eax
  100108:	75 45                	jne    10014f <schedule+0xb3>
  10010a:	83 c9 ff             	or     $0xffffffff,%ecx
					&& proc_array[i].p_priority < lowest_val){
					lowest_val = proc_array[i].p_priority;
				}
			}
			//alternate if same priority value
			pid = (pid+1) % NPROCS;
  10010d:	bb 05 00 00 00       	mov    $0x5,%ebx
				if(proc_array[pid].p_state == P_RUNNABLE)
					run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == 2)
  100112:	31 c0                	xor    %eax,%eax
	{
		while(1) {
			pid_t i;
			//find process with highest priority = lowest value
			for(i=1; i<=NPROCS; ++i){
				if(proc_array[i].p_state == P_RUNNABLE
  100114:	83 b8 d0 73 10 00 01 	cmpl   $0x1,0x1073d0(%eax)
  10011b:	75 0c                	jne    100129 <schedule+0x8d>
  10011d:	8b b0 80 73 10 00    	mov    0x107380(%eax),%esi
  100123:	39 f1                	cmp    %esi,%ecx
  100125:	76 02                	jbe    100129 <schedule+0x8d>
  100127:	89 f1                	mov    %esi,%ecx
  100129:	83 c0 5c             	add    $0x5c,%eax
	else if (scheduling_algorithm == 2)
	{
		while(1) {
			pid_t i;
			//find process with highest priority = lowest value
			for(i=1; i<=NPROCS; ++i){
  10012c:	3d cc 01 00 00       	cmp    $0x1cc,%eax
  100131:	75 e1                	jne    100114 <schedule+0x78>
					&& proc_array[i].p_priority < lowest_val){
					lowest_val = proc_array[i].p_priority;
				}
			}
			//alternate if same priority value
			pid = (pid+1) % NPROCS;
  100133:	8d 42 01             	lea    0x1(%edx),%eax
  100136:	99                   	cltd   
  100137:	f7 fb                	idiv   %ebx
			//run highest priority process
			if(proc_array[pid].p_state == P_RUNNABLE
  100139:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10013c:	83 b8 74 73 10 00 01 	cmpl   $0x1,0x107374(%eax)
  100143:	75 cd                	jne    100112 <schedule+0x76>
  100145:	39 88 24 73 10 00    	cmp    %ecx,0x107324(%eax)
  10014b:	77 c5                	ja     100112 <schedule+0x76>
  10014d:	eb 37                	jmp    100186 <schedule+0xea>
				&& proc_array[pid].p_priority <= lowest_val){
				run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == 3)
  10014f:	83 f8 03             	cmp    $0x3,%eax
  100152:	75 42                	jne    100196 <schedule+0xfa>
				else{
					proc_array[pid].p_num++;		
					run(&proc_array[pid]);
				}
			}
			pid = (pid+1) % NPROCS;
  100154:	b9 05 00 00 00       	mov    $0x5,%ecx
				}
			}
			pid = (pid+1) % NPROCS;
		}*/
		while(1){
			if(proc_array[pid].p_state == P_RUNNABLE){
  100159:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10015c:	83 b8 74 73 10 00 01 	cmpl   $0x1,0x107374(%eax)
  100163:	75 29                	jne    10018e <schedule+0xf2>
				if(proc_array[pid].p_num >= proc_array[pid].p_share){
  100165:	8b 98 2c 73 10 00    	mov    0x10732c(%eax),%ebx
  10016b:	3b 98 28 73 10 00    	cmp    0x107328(%eax),%ebx
  100171:	72 0c                	jb     10017f <schedule+0xe3>
					proc_array[pid].p_num = 0;
  100173:	c7 80 2c 73 10 00 00 	movl   $0x0,0x10732c(%eax)
  10017a:	00 00 00 
  10017d:	eb 0f                	jmp    10018e <schedule+0xf2>
				}
				else{
					proc_array[pid].p_num++;		
  10017f:	43                   	inc    %ebx
  100180:	89 98 2c 73 10 00    	mov    %ebx,0x10732c(%eax)
					run(&proc_array[pid]);
  100186:	83 ec 0c             	sub    $0xc,%esp
  100189:	e9 5b ff ff ff       	jmp    1000e9 <schedule+0x4d>
				}
			}
			pid = (pid+1) % NPROCS;
  10018e:	8d 42 01             	lea    0x1(%edx),%eax
  100191:	99                   	cltd   
  100192:	f7 f9                	idiv   %ecx
		}
  100194:	eb c3                	jmp    100159 <schedule+0xbd>
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100196:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10019c:	50                   	push   %eax
  10019d:	68 18 0b 10 00       	push   $0x100b18
  1001a2:	68 00 01 00 00       	push   $0x100
  1001a7:	52                   	push   %edx
  1001a8:	e8 51 09 00 00       	call   100afe <console_printf>
  1001ad:	83 c4 10             	add    $0x10,%esp
  1001b0:	a3 00 80 19 00       	mov    %eax,0x198000
  1001b5:	eb fe                	jmp    1001b5 <schedule+0x119>

001001b7 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001b7:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001b8:	a1 54 7d 10 00       	mov    0x107d54,%eax
  1001bd:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001c2:	56                   	push   %esi
  1001c3:	53                   	push   %ebx
  1001c4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001c8:	8d 78 10             	lea    0x10(%eax),%edi
  1001cb:	89 de                	mov    %ebx,%esi
  1001cd:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001cf:	8b 53 28             	mov    0x28(%ebx),%edx
  1001d2:	83 fa 31             	cmp    $0x31,%edx
  1001d5:	74 27                	je     1001fe <interrupt+0x47>
  1001d7:	77 0c                	ja     1001e5 <interrupt+0x2e>
  1001d9:	83 fa 20             	cmp    $0x20,%edx
  1001dc:	74 4b                	je     100229 <interrupt+0x72>
  1001de:	83 fa 30             	cmp    $0x30,%edx
  1001e1:	74 16                	je     1001f9 <interrupt+0x42>
  1001e3:	eb 49                	jmp    10022e <interrupt+0x77>
  1001e5:	83 fa 32             	cmp    $0x32,%edx
  1001e8:	74 07                	je     1001f1 <interrupt+0x3a>
  1001ea:	83 fa 33             	cmp    $0x33,%edx
  1001ed:	74 26                	je     100215 <interrupt+0x5e>
  1001ef:	eb 3d                	jmp    10022e <interrupt+0x77>
	
	case INT_SYS_SET_PRIORITY:
		current->p_priority = reg->reg_eax;
  1001f1:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001f4:	89 50 04             	mov    %edx,0x4(%eax)
  1001f7:	eb 27                	jmp    100220 <interrupt+0x69>
		run(current);

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001f9:	e8 9e fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001fe:	a1 54 7d 10 00       	mov    0x107d54,%eax
		current->p_exit_status = reg->reg_eax;
  100203:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100206:	c7 40 54 03 00 00 00 	movl   $0x3,0x54(%eax)
		current->p_exit_status = reg->reg_eax;
  10020d:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  100210:	e8 87 fe ff ff       	call   10009c <schedule>

	case INT_SYS_SET_SHARE:
		/* Set register for p_share */
		current->p_share = reg->reg_eax;
  100215:	a1 54 7d 10 00       	mov    0x107d54,%eax
  10021a:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10021d:	89 50 08             	mov    %edx,0x8(%eax)
		run(current);
  100220:	83 ec 0c             	sub    $0xc,%esp
  100223:	50                   	push   %eax
  100224:	e8 30 03 00 00       	call   100559 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100229:	e8 6e fe ff ff       	call   10009c <schedule>
  10022e:	eb fe                	jmp    10022e <interrupt+0x77>

00100230 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100230:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100231:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100236:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100237:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100239:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10023a:	bb 7c 73 10 00       	mov    $0x10737c,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10023f:	e8 f4 00 00 00       	call   100338 <segments_init>
	interrupt_controller_init(0);
  100244:	83 ec 0c             	sub    $0xc,%esp
  100247:	6a 00                	push   $0x0
  100249:	e8 e5 01 00 00       	call   100433 <interrupt_controller_init>
	console_clear();
  10024e:	e8 69 02 00 00       	call   1004bc <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100253:	83 c4 0c             	add    $0xc,%esp
  100256:	68 cc 01 00 00       	push   $0x1cc
  10025b:	6a 00                	push   $0x0
  10025d:	68 20 73 10 00       	push   $0x107320
  100262:	e8 35 04 00 00       	call   10069c <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100267:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10026a:	c7 05 20 73 10 00 00 	movl   $0x0,0x107320
  100271:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100274:	c7 05 74 73 10 00 00 	movl   $0x0,0x107374
  10027b:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10027e:	c7 05 7c 73 10 00 01 	movl   $0x1,0x10737c
  100285:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100288:	c7 05 d0 73 10 00 00 	movl   $0x0,0x1073d0
  10028f:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100292:	c7 05 d8 73 10 00 02 	movl   $0x2,0x1073d8
  100299:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10029c:	c7 05 2c 74 10 00 00 	movl   $0x0,0x10742c
  1002a3:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002a6:	c7 05 34 74 10 00 03 	movl   $0x3,0x107434
  1002ad:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002b0:	c7 05 88 74 10 00 00 	movl   $0x0,0x107488
  1002b7:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ba:	c7 05 90 74 10 00 04 	movl   $0x4,0x107490
  1002c1:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002c4:	c7 05 e4 74 10 00 00 	movl   $0x0,0x1074e4
  1002cb:	00 00 00 
		
		proc->p_priority = 0;
		proc->p_share = 1;
		proc->p_num = 0;
		// Initialize the process descriptor
		special_registers_init(proc);
  1002ce:	83 ec 0c             	sub    $0xc,%esp
  1002d1:	53                   	push   %ebx
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;
		
		proc->p_priority = 0;
  1002d2:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
		proc->p_share = 1;
  1002d9:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
		proc->p_num = 0;
  1002e0:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
		// Initialize the process descriptor
		special_registers_init(proc);
  1002e7:	e8 84 02 00 00       	call   100570 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002ec:	58                   	pop    %eax
  1002ed:	5a                   	pop    %edx
  1002ee:	8d 43 40             	lea    0x40(%ebx),%eax
		proc->p_num = 0;
		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1002f1:	89 7b 4c             	mov    %edi,0x4c(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002f4:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002fa:	50                   	push   %eax
  1002fb:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002fc:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002fd:	e8 aa 02 00 00       	call   1005ac <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100302:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100305:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  10030c:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10030f:	83 fe 04             	cmp    $0x4,%esi
  100312:	75 ba                	jne    1002ce <start+0x9e>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 3;

	// Switch to the first process.
	run(&proc_array[1]);
  100314:	83 ec 0c             	sub    $0xc,%esp
  100317:	68 7c 73 10 00       	push   $0x10737c
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10031c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100323:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 3;
  100326:	c7 05 58 7d 10 00 03 	movl   $0x3,0x107d58
  10032d:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100330:	e8 24 02 00 00       	call   100559 <run>
  100335:	90                   	nop
  100336:	90                   	nop
  100337:	90                   	nop

00100338 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100338:	b8 ec 74 10 00       	mov    $0x1074ec,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10033d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100342:	89 c2                	mov    %eax,%edx
  100344:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100347:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100348:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  10034d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100350:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100356:	c1 e8 18             	shr    $0x18,%eax
  100359:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10035f:	ba 54 75 10 00       	mov    $0x107554,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100364:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100369:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10036b:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  100372:	68 00 
  100374:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10037b:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100382:	c7 05 f0 74 10 00 00 	movl   $0x180000,0x1074f0
  100389:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10038c:	66 c7 05 f4 74 10 00 	movw   $0x10,0x1074f4
  100393:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100395:	66 89 0c c5 54 75 10 	mov    %cx,0x107554(,%eax,8)
  10039c:	00 
  10039d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003a4:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003a9:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003ae:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003b3:	40                   	inc    %eax
  1003b4:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003b9:	75 da                	jne    100395 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003bb:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003c0:	ba 54 75 10 00       	mov    $0x107554,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003c5:	66 a3 54 76 10 00    	mov    %ax,0x107654
  1003cb:	c1 e8 10             	shr    $0x10,%eax
  1003ce:	66 a3 5a 76 10 00    	mov    %ax,0x10765a
  1003d4:	b8 30 00 00 00       	mov    $0x30,%eax
  1003d9:	66 c7 05 56 76 10 00 	movw   $0x8,0x107656
  1003e0:	08 00 
  1003e2:	c6 05 58 76 10 00 00 	movb   $0x0,0x107658
  1003e9:	c6 05 59 76 10 00 8e 	movb   $0x8e,0x107659

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003f0:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1003f7:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003fe:	66 89 0c c5 54 75 10 	mov    %cx,0x107554(,%eax,8)
  100405:	00 
  100406:	c1 e9 10             	shr    $0x10,%ecx
  100409:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10040e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100413:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100418:	40                   	inc    %eax
  100419:	83 f8 3a             	cmp    $0x3a,%eax
  10041c:	75 d2                	jne    1003f0 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10041e:	b0 28                	mov    $0x28,%al
  100420:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100427:	0f 00 d8             	ltr    %ax
  10042a:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100431:	5b                   	pop    %ebx
  100432:	c3                   	ret    

00100433 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100433:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100434:	b0 ff                	mov    $0xff,%al
  100436:	57                   	push   %edi
  100437:	56                   	push   %esi
  100438:	53                   	push   %ebx
  100439:	bb 21 00 00 00       	mov    $0x21,%ebx
  10043e:	89 da                	mov    %ebx,%edx
  100440:	ee                   	out    %al,(%dx)
  100441:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100446:	89 ca                	mov    %ecx,%edx
  100448:	ee                   	out    %al,(%dx)
  100449:	be 11 00 00 00       	mov    $0x11,%esi
  10044e:	bf 20 00 00 00       	mov    $0x20,%edi
  100453:	89 f0                	mov    %esi,%eax
  100455:	89 fa                	mov    %edi,%edx
  100457:	ee                   	out    %al,(%dx)
  100458:	b0 20                	mov    $0x20,%al
  10045a:	89 da                	mov    %ebx,%edx
  10045c:	ee                   	out    %al,(%dx)
  10045d:	b0 04                	mov    $0x4,%al
  10045f:	ee                   	out    %al,(%dx)
  100460:	b0 03                	mov    $0x3,%al
  100462:	ee                   	out    %al,(%dx)
  100463:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100468:	89 f0                	mov    %esi,%eax
  10046a:	89 ea                	mov    %ebp,%edx
  10046c:	ee                   	out    %al,(%dx)
  10046d:	b0 28                	mov    $0x28,%al
  10046f:	89 ca                	mov    %ecx,%edx
  100471:	ee                   	out    %al,(%dx)
  100472:	b0 02                	mov    $0x2,%al
  100474:	ee                   	out    %al,(%dx)
  100475:	b0 01                	mov    $0x1,%al
  100477:	ee                   	out    %al,(%dx)
  100478:	b0 68                	mov    $0x68,%al
  10047a:	89 fa                	mov    %edi,%edx
  10047c:	ee                   	out    %al,(%dx)
  10047d:	be 0a 00 00 00       	mov    $0xa,%esi
  100482:	89 f0                	mov    %esi,%eax
  100484:	ee                   	out    %al,(%dx)
  100485:	b0 68                	mov    $0x68,%al
  100487:	89 ea                	mov    %ebp,%edx
  100489:	ee                   	out    %al,(%dx)
  10048a:	89 f0                	mov    %esi,%eax
  10048c:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  10048d:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100492:	89 da                	mov    %ebx,%edx
  100494:	19 c0                	sbb    %eax,%eax
  100496:	f7 d0                	not    %eax
  100498:	05 ff 00 00 00       	add    $0xff,%eax
  10049d:	ee                   	out    %al,(%dx)
  10049e:	b0 ff                	mov    $0xff,%al
  1004a0:	89 ca                	mov    %ecx,%edx
  1004a2:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004a3:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004a8:	74 0d                	je     1004b7 <interrupt_controller_init+0x84>
  1004aa:	b2 43                	mov    $0x43,%dl
  1004ac:	b0 34                	mov    $0x34,%al
  1004ae:	ee                   	out    %al,(%dx)
  1004af:	b0 9c                	mov    $0x9c,%al
  1004b1:	b2 40                	mov    $0x40,%dl
  1004b3:	ee                   	out    %al,(%dx)
  1004b4:	b0 2e                	mov    $0x2e,%al
  1004b6:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004b7:	5b                   	pop    %ebx
  1004b8:	5e                   	pop    %esi
  1004b9:	5f                   	pop    %edi
  1004ba:	5d                   	pop    %ebp
  1004bb:	c3                   	ret    

001004bc <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004bc:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004bd:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004bf:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004c0:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004c7:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1004ca:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1004d0:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1004d6:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1004d9:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1004de:	75 ea                	jne    1004ca <console_clear+0xe>
  1004e0:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004e5:	b0 0e                	mov    $0xe,%al
  1004e7:	89 f2                	mov    %esi,%edx
  1004e9:	ee                   	out    %al,(%dx)
  1004ea:	31 c9                	xor    %ecx,%ecx
  1004ec:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004f1:	88 c8                	mov    %cl,%al
  1004f3:	89 da                	mov    %ebx,%edx
  1004f5:	ee                   	out    %al,(%dx)
  1004f6:	b0 0f                	mov    $0xf,%al
  1004f8:	89 f2                	mov    %esi,%edx
  1004fa:	ee                   	out    %al,(%dx)
  1004fb:	88 c8                	mov    %cl,%al
  1004fd:	89 da                	mov    %ebx,%edx
  1004ff:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100500:	5b                   	pop    %ebx
  100501:	5e                   	pop    %esi
  100502:	c3                   	ret    

00100503 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100503:	ba 64 00 00 00       	mov    $0x64,%edx
  100508:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100509:	a8 01                	test   $0x1,%al
  10050b:	74 45                	je     100552 <console_read_digit+0x4f>
  10050d:	b2 60                	mov    $0x60,%dl
  10050f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100510:	8d 50 fe             	lea    -0x2(%eax),%edx
  100513:	80 fa 08             	cmp    $0x8,%dl
  100516:	77 05                	ja     10051d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100518:	0f b6 c0             	movzbl %al,%eax
  10051b:	48                   	dec    %eax
  10051c:	c3                   	ret    
	else if (data == 0x0B)
  10051d:	3c 0b                	cmp    $0xb,%al
  10051f:	74 35                	je     100556 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100521:	8d 50 b9             	lea    -0x47(%eax),%edx
  100524:	80 fa 02             	cmp    $0x2,%dl
  100527:	77 07                	ja     100530 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100529:	0f b6 c0             	movzbl %al,%eax
  10052c:	83 e8 40             	sub    $0x40,%eax
  10052f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100530:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100533:	80 fa 02             	cmp    $0x2,%dl
  100536:	77 07                	ja     10053f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100538:	0f b6 c0             	movzbl %al,%eax
  10053b:	83 e8 47             	sub    $0x47,%eax
  10053e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10053f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100542:	80 fa 02             	cmp    $0x2,%dl
  100545:	77 07                	ja     10054e <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100547:	0f b6 c0             	movzbl %al,%eax
  10054a:	83 e8 4e             	sub    $0x4e,%eax
  10054d:	c3                   	ret    
	else if (data == 0x53)
  10054e:	3c 53                	cmp    $0x53,%al
  100550:	74 04                	je     100556 <console_read_digit+0x53>
  100552:	83 c8 ff             	or     $0xffffffff,%eax
  100555:	c3                   	ret    
  100556:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100558:	c3                   	ret    

00100559 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100559:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  10055d:	a3 54 7d 10 00       	mov    %eax,0x107d54

	asm volatile("movl %0,%%esp\n\t"
  100562:	83 c0 10             	add    $0x10,%eax
  100565:	89 c4                	mov    %eax,%esp
  100567:	61                   	popa   
  100568:	07                   	pop    %es
  100569:	1f                   	pop    %ds
  10056a:	83 c4 08             	add    $0x8,%esp
  10056d:	cf                   	iret   
  10056e:	eb fe                	jmp    10056e <run+0x15>

00100570 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100570:	53                   	push   %ebx
  100571:	83 ec 0c             	sub    $0xc,%esp
  100574:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100578:	6a 44                	push   $0x44
  10057a:	6a 00                	push   $0x0
  10057c:	8d 43 10             	lea    0x10(%ebx),%eax
  10057f:	50                   	push   %eax
  100580:	e8 17 01 00 00       	call   10069c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100585:	66 c7 43 44 1b 00    	movw   $0x1b,0x44(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10058b:	66 c7 43 34 23 00    	movw   $0x23,0x34(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100591:	66 c7 43 30 23 00    	movw   $0x23,0x30(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100597:	66 c7 43 50 23 00    	movw   $0x23,0x50(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  10059d:	c7 43 48 00 02 00 00 	movl   $0x200,0x48(%ebx)
}
  1005a4:	83 c4 18             	add    $0x18,%esp
  1005a7:	5b                   	pop    %ebx
  1005a8:	c3                   	ret    
  1005a9:	90                   	nop
  1005aa:	90                   	nop
  1005ab:	90                   	nop

001005ac <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005ac:	55                   	push   %ebp
  1005ad:	57                   	push   %edi
  1005ae:	56                   	push   %esi
  1005af:	53                   	push   %ebx
  1005b0:	83 ec 1c             	sub    $0x1c,%esp
  1005b3:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005b7:	83 f8 03             	cmp    $0x3,%eax
  1005ba:	7f 04                	jg     1005c0 <program_loader+0x14>
  1005bc:	85 c0                	test   %eax,%eax
  1005be:	79 02                	jns    1005c2 <program_loader+0x16>
  1005c0:	eb fe                	jmp    1005c0 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1005c2:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1005c9:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1005cf:	74 02                	je     1005d3 <program_loader+0x27>
  1005d1:	eb fe                	jmp    1005d1 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005d3:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1005d6:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1005da:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1005dc:	c1 e5 05             	shl    $0x5,%ebp
  1005df:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1005e2:	eb 3f                	jmp    100623 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1005e4:	83 3b 01             	cmpl   $0x1,(%ebx)
  1005e7:	75 37                	jne    100620 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1005e9:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005ec:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1005ef:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1005f2:	01 c7                	add    %eax,%edi
	memsz += va;
  1005f4:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005fb:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005ff:	52                   	push   %edx
  100600:	89 fa                	mov    %edi,%edx
  100602:	29 c2                	sub    %eax,%edx
  100604:	52                   	push   %edx
  100605:	8b 53 04             	mov    0x4(%ebx),%edx
  100608:	01 f2                	add    %esi,%edx
  10060a:	52                   	push   %edx
  10060b:	50                   	push   %eax
  10060c:	e8 27 00 00 00       	call   100638 <memcpy>
  100611:	83 c4 10             	add    $0x10,%esp
  100614:	eb 04                	jmp    10061a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100616:	c6 07 00             	movb   $0x0,(%edi)
  100619:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10061a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10061e:	72 f6                	jb     100616 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100620:	83 c3 20             	add    $0x20,%ebx
  100623:	39 eb                	cmp    %ebp,%ebx
  100625:	72 bd                	jb     1005e4 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100627:	8b 56 18             	mov    0x18(%esi),%edx
  10062a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10062e:	89 10                	mov    %edx,(%eax)
}
  100630:	83 c4 1c             	add    $0x1c,%esp
  100633:	5b                   	pop    %ebx
  100634:	5e                   	pop    %esi
  100635:	5f                   	pop    %edi
  100636:	5d                   	pop    %ebp
  100637:	c3                   	ret    

00100638 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100638:	56                   	push   %esi
  100639:	31 d2                	xor    %edx,%edx
  10063b:	53                   	push   %ebx
  10063c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100640:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100644:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100648:	eb 08                	jmp    100652 <memcpy+0x1a>
		*d++ = *s++;
  10064a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10064d:	4e                   	dec    %esi
  10064e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100651:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100652:	85 f6                	test   %esi,%esi
  100654:	75 f4                	jne    10064a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100656:	5b                   	pop    %ebx
  100657:	5e                   	pop    %esi
  100658:	c3                   	ret    

00100659 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100659:	57                   	push   %edi
  10065a:	56                   	push   %esi
  10065b:	53                   	push   %ebx
  10065c:	8b 44 24 10          	mov    0x10(%esp),%eax
  100660:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100664:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100668:	39 c7                	cmp    %eax,%edi
  10066a:	73 26                	jae    100692 <memmove+0x39>
  10066c:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10066f:	39 c6                	cmp    %eax,%esi
  100671:	76 1f                	jbe    100692 <memmove+0x39>
		s += n, d += n;
  100673:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100676:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100678:	eb 07                	jmp    100681 <memmove+0x28>
			*--d = *--s;
  10067a:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  10067d:	4a                   	dec    %edx
  10067e:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100681:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100682:	85 d2                	test   %edx,%edx
  100684:	75 f4                	jne    10067a <memmove+0x21>
  100686:	eb 10                	jmp    100698 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100688:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10068b:	4a                   	dec    %edx
  10068c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10068f:	41                   	inc    %ecx
  100690:	eb 02                	jmp    100694 <memmove+0x3b>
  100692:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100694:	85 d2                	test   %edx,%edx
  100696:	75 f0                	jne    100688 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100698:	5b                   	pop    %ebx
  100699:	5e                   	pop    %esi
  10069a:	5f                   	pop    %edi
  10069b:	c3                   	ret    

0010069c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10069c:	53                   	push   %ebx
  10069d:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006a1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006a5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006a9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006ab:	eb 04                	jmp    1006b1 <memset+0x15>
		*p++ = c;
  1006ad:	88 1a                	mov    %bl,(%edx)
  1006af:	49                   	dec    %ecx
  1006b0:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006b1:	85 c9                	test   %ecx,%ecx
  1006b3:	75 f8                	jne    1006ad <memset+0x11>
		*p++ = c;
	return v;
}
  1006b5:	5b                   	pop    %ebx
  1006b6:	c3                   	ret    

001006b7 <strlen>:

size_t
strlen(const char *s)
{
  1006b7:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006bb:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006bd:	eb 01                	jmp    1006c0 <strlen+0x9>
		++n;
  1006bf:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006c0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1006c4:	75 f9                	jne    1006bf <strlen+0x8>
		++n;
	return n;
}
  1006c6:	c3                   	ret    

001006c7 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1006c7:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1006cb:	31 c0                	xor    %eax,%eax
  1006cd:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006d1:	eb 01                	jmp    1006d4 <strnlen+0xd>
		++n;
  1006d3:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1006d4:	39 d0                	cmp    %edx,%eax
  1006d6:	74 06                	je     1006de <strnlen+0x17>
  1006d8:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1006dc:	75 f5                	jne    1006d3 <strnlen+0xc>
		++n;
	return n;
}
  1006de:	c3                   	ret    

001006df <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006df:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1006e0:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1006e5:	53                   	push   %ebx
  1006e6:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1006e8:	76 05                	jbe    1006ef <console_putc+0x10>
  1006ea:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1006ef:	80 fa 0a             	cmp    $0xa,%dl
  1006f2:	75 2c                	jne    100720 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006f4:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006fa:	be 50 00 00 00       	mov    $0x50,%esi
  1006ff:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100701:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100704:	99                   	cltd   
  100705:	f7 fe                	idiv   %esi
  100707:	89 de                	mov    %ebx,%esi
  100709:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10070b:	eb 07                	jmp    100714 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10070d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100710:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100711:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100714:	83 f8 50             	cmp    $0x50,%eax
  100717:	75 f4                	jne    10070d <console_putc+0x2e>
  100719:	29 d0                	sub    %edx,%eax
  10071b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10071e:	eb 0b                	jmp    10072b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100720:	0f b6 d2             	movzbl %dl,%edx
  100723:	09 ca                	or     %ecx,%edx
  100725:	66 89 13             	mov    %dx,(%ebx)
  100728:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10072b:	5b                   	pop    %ebx
  10072c:	5e                   	pop    %esi
  10072d:	c3                   	ret    

0010072e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10072e:	56                   	push   %esi
  10072f:	53                   	push   %ebx
  100730:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100734:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100737:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10073b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100740:	75 04                	jne    100746 <fill_numbuf+0x18>
  100742:	85 d2                	test   %edx,%edx
  100744:	74 10                	je     100756 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100746:	89 d0                	mov    %edx,%eax
  100748:	31 d2                	xor    %edx,%edx
  10074a:	f7 f1                	div    %ecx
  10074c:	4b                   	dec    %ebx
  10074d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100750:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100752:	89 c2                	mov    %eax,%edx
  100754:	eb ec                	jmp    100742 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100756:	89 d8                	mov    %ebx,%eax
  100758:	5b                   	pop    %ebx
  100759:	5e                   	pop    %esi
  10075a:	c3                   	ret    

0010075b <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10075b:	55                   	push   %ebp
  10075c:	57                   	push   %edi
  10075d:	56                   	push   %esi
  10075e:	53                   	push   %ebx
  10075f:	83 ec 38             	sub    $0x38,%esp
  100762:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100766:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10076a:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10076e:	e9 60 03 00 00       	jmp    100ad3 <console_vprintf+0x378>
		if (*format != '%') {
  100773:	80 fa 25             	cmp    $0x25,%dl
  100776:	74 13                	je     10078b <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100778:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10077c:	0f b6 d2             	movzbl %dl,%edx
  10077f:	89 f0                	mov    %esi,%eax
  100781:	e8 59 ff ff ff       	call   1006df <console_putc>
  100786:	e9 45 03 00 00       	jmp    100ad0 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10078b:	47                   	inc    %edi
  10078c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100793:	00 
  100794:	eb 12                	jmp    1007a8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100796:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100797:	8a 11                	mov    (%ecx),%dl
  100799:	84 d2                	test   %dl,%dl
  10079b:	74 1a                	je     1007b7 <console_vprintf+0x5c>
  10079d:	89 e8                	mov    %ebp,%eax
  10079f:	38 c2                	cmp    %al,%dl
  1007a1:	75 f3                	jne    100796 <console_vprintf+0x3b>
  1007a3:	e9 3f 03 00 00       	jmp    100ae7 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007a8:	8a 17                	mov    (%edi),%dl
  1007aa:	84 d2                	test   %dl,%dl
  1007ac:	74 0b                	je     1007b9 <console_vprintf+0x5e>
  1007ae:	b9 3c 0b 10 00       	mov    $0x100b3c,%ecx
  1007b3:	89 d5                	mov    %edx,%ebp
  1007b5:	eb e0                	jmp    100797 <console_vprintf+0x3c>
  1007b7:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007b9:	8d 42 cf             	lea    -0x31(%edx),%eax
  1007bc:	3c 08                	cmp    $0x8,%al
  1007be:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1007c5:	00 
  1007c6:	76 13                	jbe    1007db <console_vprintf+0x80>
  1007c8:	eb 1d                	jmp    1007e7 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1007ca:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1007cf:	0f be c0             	movsbl %al,%eax
  1007d2:	47                   	inc    %edi
  1007d3:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1007d7:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1007db:	8a 07                	mov    (%edi),%al
  1007dd:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007e0:	80 fa 09             	cmp    $0x9,%dl
  1007e3:	76 e5                	jbe    1007ca <console_vprintf+0x6f>
  1007e5:	eb 18                	jmp    1007ff <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1007e7:	80 fa 2a             	cmp    $0x2a,%dl
  1007ea:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1007f1:	ff 
  1007f2:	75 0b                	jne    1007ff <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007f4:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007f7:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007f8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007fb:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007ff:	83 cd ff             	or     $0xffffffff,%ebp
  100802:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100805:	75 37                	jne    10083e <console_vprintf+0xe3>
			++format;
  100807:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100808:	31 ed                	xor    %ebp,%ebp
  10080a:	8a 07                	mov    (%edi),%al
  10080c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10080f:	80 fa 09             	cmp    $0x9,%dl
  100812:	76 0d                	jbe    100821 <console_vprintf+0xc6>
  100814:	eb 17                	jmp    10082d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100816:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100819:	0f be c0             	movsbl %al,%eax
  10081c:	47                   	inc    %edi
  10081d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100821:	8a 07                	mov    (%edi),%al
  100823:	8d 50 d0             	lea    -0x30(%eax),%edx
  100826:	80 fa 09             	cmp    $0x9,%dl
  100829:	76 eb                	jbe    100816 <console_vprintf+0xbb>
  10082b:	eb 11                	jmp    10083e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10082d:	3c 2a                	cmp    $0x2a,%al
  10082f:	75 0b                	jne    10083c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100831:	83 c3 04             	add    $0x4,%ebx
				++format;
  100834:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100835:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100838:	85 ed                	test   %ebp,%ebp
  10083a:	79 02                	jns    10083e <console_vprintf+0xe3>
  10083c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10083e:	8a 07                	mov    (%edi),%al
  100840:	3c 64                	cmp    $0x64,%al
  100842:	74 34                	je     100878 <console_vprintf+0x11d>
  100844:	7f 1d                	jg     100863 <console_vprintf+0x108>
  100846:	3c 58                	cmp    $0x58,%al
  100848:	0f 84 a2 00 00 00    	je     1008f0 <console_vprintf+0x195>
  10084e:	3c 63                	cmp    $0x63,%al
  100850:	0f 84 bf 00 00 00    	je     100915 <console_vprintf+0x1ba>
  100856:	3c 43                	cmp    $0x43,%al
  100858:	0f 85 d0 00 00 00    	jne    10092e <console_vprintf+0x1d3>
  10085e:	e9 a3 00 00 00       	jmp    100906 <console_vprintf+0x1ab>
  100863:	3c 75                	cmp    $0x75,%al
  100865:	74 4d                	je     1008b4 <console_vprintf+0x159>
  100867:	3c 78                	cmp    $0x78,%al
  100869:	74 5c                	je     1008c7 <console_vprintf+0x16c>
  10086b:	3c 73                	cmp    $0x73,%al
  10086d:	0f 85 bb 00 00 00    	jne    10092e <console_vprintf+0x1d3>
  100873:	e9 86 00 00 00       	jmp    1008fe <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100878:	83 c3 04             	add    $0x4,%ebx
  10087b:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10087e:	89 d1                	mov    %edx,%ecx
  100880:	c1 f9 1f             	sar    $0x1f,%ecx
  100883:	89 0c 24             	mov    %ecx,(%esp)
  100886:	31 ca                	xor    %ecx,%edx
  100888:	55                   	push   %ebp
  100889:	29 ca                	sub    %ecx,%edx
  10088b:	68 44 0b 10 00       	push   $0x100b44
  100890:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100895:	8d 44 24 40          	lea    0x40(%esp),%eax
  100899:	e8 90 fe ff ff       	call   10072e <fill_numbuf>
  10089e:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008a2:	58                   	pop    %eax
  1008a3:	5a                   	pop    %edx
  1008a4:	ba 01 00 00 00       	mov    $0x1,%edx
  1008a9:	8b 04 24             	mov    (%esp),%eax
  1008ac:	83 e0 01             	and    $0x1,%eax
  1008af:	e9 a5 00 00 00       	jmp    100959 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008b4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008b7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008bc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008bf:	55                   	push   %ebp
  1008c0:	68 44 0b 10 00       	push   $0x100b44
  1008c5:	eb 11                	jmp    1008d8 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1008c7:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1008ca:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008cd:	55                   	push   %ebp
  1008ce:	68 58 0b 10 00       	push   $0x100b58
  1008d3:	b9 10 00 00 00       	mov    $0x10,%ecx
  1008d8:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008dc:	e8 4d fe ff ff       	call   10072e <fill_numbuf>
  1008e1:	ba 01 00 00 00       	mov    $0x1,%edx
  1008e6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1008ea:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1008ec:	59                   	pop    %ecx
  1008ed:	59                   	pop    %ecx
  1008ee:	eb 69                	jmp    100959 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1008f0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1008f3:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008f6:	55                   	push   %ebp
  1008f7:	68 44 0b 10 00       	push   $0x100b44
  1008fc:	eb d5                	jmp    1008d3 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008fe:	83 c3 04             	add    $0x4,%ebx
  100901:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100904:	eb 40                	jmp    100946 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100906:	83 c3 04             	add    $0x4,%ebx
  100909:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10090c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100910:	e9 bd 01 00 00       	jmp    100ad2 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100915:	83 c3 04             	add    $0x4,%ebx
  100918:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10091b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10091f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100924:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100928:	88 44 24 24          	mov    %al,0x24(%esp)
  10092c:	eb 27                	jmp    100955 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10092e:	84 c0                	test   %al,%al
  100930:	75 02                	jne    100934 <console_vprintf+0x1d9>
  100932:	b0 25                	mov    $0x25,%al
  100934:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100938:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10093d:	80 3f 00             	cmpb   $0x0,(%edi)
  100940:	74 0a                	je     10094c <console_vprintf+0x1f1>
  100942:	8d 44 24 24          	lea    0x24(%esp),%eax
  100946:	89 44 24 04          	mov    %eax,0x4(%esp)
  10094a:	eb 09                	jmp    100955 <console_vprintf+0x1fa>
				format--;
  10094c:	8d 54 24 24          	lea    0x24(%esp),%edx
  100950:	4f                   	dec    %edi
  100951:	89 54 24 04          	mov    %edx,0x4(%esp)
  100955:	31 d2                	xor    %edx,%edx
  100957:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100959:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10095b:	83 fd ff             	cmp    $0xffffffff,%ebp
  10095e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100965:	74 1f                	je     100986 <console_vprintf+0x22b>
  100967:	89 04 24             	mov    %eax,(%esp)
  10096a:	eb 01                	jmp    10096d <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  10096c:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10096d:	39 e9                	cmp    %ebp,%ecx
  10096f:	74 0a                	je     10097b <console_vprintf+0x220>
  100971:	8b 44 24 04          	mov    0x4(%esp),%eax
  100975:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100979:	75 f1                	jne    10096c <console_vprintf+0x211>
  10097b:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10097e:	89 0c 24             	mov    %ecx,(%esp)
  100981:	eb 1f                	jmp    1009a2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100983:	42                   	inc    %edx
  100984:	eb 09                	jmp    10098f <console_vprintf+0x234>
  100986:	89 d1                	mov    %edx,%ecx
  100988:	8b 14 24             	mov    (%esp),%edx
  10098b:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10098f:	8b 44 24 04          	mov    0x4(%esp),%eax
  100993:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100997:	75 ea                	jne    100983 <console_vprintf+0x228>
  100999:	8b 44 24 08          	mov    0x8(%esp),%eax
  10099d:	89 14 24             	mov    %edx,(%esp)
  1009a0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009a2:	85 c0                	test   %eax,%eax
  1009a4:	74 0c                	je     1009b2 <console_vprintf+0x257>
  1009a6:	84 d2                	test   %dl,%dl
  1009a8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009af:	00 
  1009b0:	75 24                	jne    1009d6 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009b2:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009b7:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1009be:	00 
  1009bf:	75 15                	jne    1009d6 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1009c1:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009c5:	83 e0 08             	and    $0x8,%eax
  1009c8:	83 f8 01             	cmp    $0x1,%eax
  1009cb:	19 c9                	sbb    %ecx,%ecx
  1009cd:	f7 d1                	not    %ecx
  1009cf:	83 e1 20             	and    $0x20,%ecx
  1009d2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1009d6:	3b 2c 24             	cmp    (%esp),%ebp
  1009d9:	7e 0d                	jle    1009e8 <console_vprintf+0x28d>
  1009db:	84 d2                	test   %dl,%dl
  1009dd:	74 40                	je     100a1f <console_vprintf+0x2c4>
			zeros = precision - len;
  1009df:	2b 2c 24             	sub    (%esp),%ebp
  1009e2:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  1009e6:	eb 3f                	jmp    100a27 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009e8:	84 d2                	test   %dl,%dl
  1009ea:	74 33                	je     100a1f <console_vprintf+0x2c4>
  1009ec:	8b 44 24 14          	mov    0x14(%esp),%eax
  1009f0:	83 e0 06             	and    $0x6,%eax
  1009f3:	83 f8 02             	cmp    $0x2,%eax
  1009f6:	75 27                	jne    100a1f <console_vprintf+0x2c4>
  1009f8:	45                   	inc    %ebp
  1009f9:	75 24                	jne    100a1f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009fb:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009fd:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a00:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a05:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a08:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a0b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a0f:	7d 0e                	jge    100a1f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a11:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a15:	29 ca                	sub    %ecx,%edx
  100a17:	29 c2                	sub    %eax,%edx
  100a19:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a1d:	eb 08                	jmp    100a27 <console_vprintf+0x2cc>
  100a1f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a26:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a27:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a2b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a2d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a31:	2b 2c 24             	sub    (%esp),%ebp
  100a34:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a39:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a3c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a3f:	29 c5                	sub    %eax,%ebp
  100a41:	89 f0                	mov    %esi,%eax
  100a43:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a47:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a4b:	eb 0f                	jmp    100a5c <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a4d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a51:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a56:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a57:	e8 83 fc ff ff       	call   1006df <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a5c:	85 ed                	test   %ebp,%ebp
  100a5e:	7e 07                	jle    100a67 <console_vprintf+0x30c>
  100a60:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a65:	74 e6                	je     100a4d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a67:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a6c:	89 c6                	mov    %eax,%esi
  100a6e:	74 23                	je     100a93 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a70:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a75:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a79:	e8 61 fc ff ff       	call   1006df <console_putc>
  100a7e:	89 c6                	mov    %eax,%esi
  100a80:	eb 11                	jmp    100a93 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a82:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a86:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a8b:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a8c:	e8 4e fc ff ff       	call   1006df <console_putc>
  100a91:	eb 06                	jmp    100a99 <console_vprintf+0x33e>
  100a93:	89 f0                	mov    %esi,%eax
  100a95:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a99:	85 f6                	test   %esi,%esi
  100a9b:	7f e5                	jg     100a82 <console_vprintf+0x327>
  100a9d:	8b 34 24             	mov    (%esp),%esi
  100aa0:	eb 15                	jmp    100ab7 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100aa2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100aa6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100aa7:	0f b6 11             	movzbl (%ecx),%edx
  100aaa:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aae:	e8 2c fc ff ff       	call   1006df <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ab3:	ff 44 24 04          	incl   0x4(%esp)
  100ab7:	85 f6                	test   %esi,%esi
  100ab9:	7f e7                	jg     100aa2 <console_vprintf+0x347>
  100abb:	eb 0f                	jmp    100acc <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100abd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ac1:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100ac6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100ac7:	e8 13 fc ff ff       	call   1006df <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100acc:	85 ed                	test   %ebp,%ebp
  100ace:	7f ed                	jg     100abd <console_vprintf+0x362>
  100ad0:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100ad2:	47                   	inc    %edi
  100ad3:	8a 17                	mov    (%edi),%dl
  100ad5:	84 d2                	test   %dl,%dl
  100ad7:	0f 85 96 fc ff ff    	jne    100773 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100add:	83 c4 38             	add    $0x38,%esp
  100ae0:	89 f0                	mov    %esi,%eax
  100ae2:	5b                   	pop    %ebx
  100ae3:	5e                   	pop    %esi
  100ae4:	5f                   	pop    %edi
  100ae5:	5d                   	pop    %ebp
  100ae6:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ae7:	81 e9 3c 0b 10 00    	sub    $0x100b3c,%ecx
  100aed:	b8 01 00 00 00       	mov    $0x1,%eax
  100af2:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100af4:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100af5:	09 44 24 14          	or     %eax,0x14(%esp)
  100af9:	e9 aa fc ff ff       	jmp    1007a8 <console_vprintf+0x4d>

00100afe <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100afe:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b02:	50                   	push   %eax
  100b03:	ff 74 24 10          	pushl  0x10(%esp)
  100b07:	ff 74 24 10          	pushl  0x10(%esp)
  100b0b:	ff 74 24 10          	pushl  0x10(%esp)
  100b0f:	e8 47 fc ff ff       	call   10075b <console_vprintf>
  100b14:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b17:	c3                   	ret    
