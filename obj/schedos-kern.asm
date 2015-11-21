
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
  100014:	e8 ec 02 00 00       	call   100305 <start>
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
  10006d:	e8 01 02 00 00       	call   100273 <interrupt>

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

0010009c <add_ticket>:
pid_t lotteryarray[MAX_TICKETS];
int ticket;

void add_ticket(pid_t pid)
{
	if(ticket < MAX_TICKETS){
  10009c:	a1 f4 8e 10 00       	mov    0x108ef4,%eax
  1000a1:	3d f3 01 00 00       	cmp    $0x1f3,%eax
  1000a6:	7f 11                	jg     1000b9 <add_ticket+0x1d>
		lotteryarray[ticket] = pid;
  1000a8:	8b 54 24 04          	mov    0x4(%esp),%edx
  1000ac:	89 14 85 1c 87 10 00 	mov    %edx,0x10871c(,%eax,4)
		ticket++;
  1000b3:	40                   	inc    %eax
  1000b4:	a3 f4 8e 10 00       	mov    %eax,0x108ef4
  1000b9:	c3                   	ret    

001000ba <random>:
*/
unsigned short lfsr = 0xACE1u;
unsigned bit;
unsigned random()
{
	bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1;
  1000ba:	66 8b 15 b8 1c 10 00 	mov    0x101cb8,%dx
  1000c1:	89 d0                	mov    %edx,%eax
  1000c3:	89 d1                	mov    %edx,%ecx
  1000c5:	66 c1 e9 03          	shr    $0x3,%cx
  1000c9:	66 c1 e8 02          	shr    $0x2,%ax
  1000cd:	31 c8                	xor    %ecx,%eax
  1000cf:	89 d1                	mov    %edx,%ecx
  1000d1:	31 d0                	xor    %edx,%eax
  1000d3:	66 c1 e9 05          	shr    $0x5,%cx
  1000d7:	31 c8                	xor    %ecx,%eax
  1000d9:	83 e0 01             	and    $0x1,%eax
  1000dc:	a3 18 87 10 00       	mov    %eax,0x108718
	return lfsr = (lfsr >> 1) | (bit << 15);
  1000e1:	66 d1 ea             	shr    %dx
  1000e4:	c1 e0 0f             	shl    $0xf,%eax
  1000e7:	09 d0                	or     %edx,%eax
  1000e9:	66 a3 b8 1c 10 00    	mov    %ax,0x101cb8
  1000ef:	0f b7 c0             	movzwl %ax,%eax
}
  1000f2:	c3                   	ret    

001000f3 <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  1000f3:	56                   	push   %esi
  1000f4:	53                   	push   %ebx
  1000f5:	83 ec 04             	sub    $0x4,%esp
	pid_t pid = current->p_pid;
  1000f8:	a1 ec 8e 10 00       	mov    0x108eec,%eax
  1000fd:	8b 10                	mov    (%eax),%edx
	unsigned int lowest_val;
	lowest_val = 0xffffffff; // INTMAX

	if (scheduling_algorithm == __EXERCISE_1__)
  1000ff:	a1 f0 8e 10 00       	mov    0x108ef0,%eax
  100104:	85 c0                	test   %eax,%eax
  100106:	75 1c                	jne    100124 <schedule+0x31>
		while (1) {
			pid = (pid + 1) % NPROCS;
  100108:	b9 05 00 00 00       	mov    $0x5,%ecx
  10010d:	8d 42 01             	lea    0x1(%edx),%eax
  100110:	99                   	cltd   
  100111:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  100113:	6b c2 5c             	imul   $0x5c,%edx,%eax
  100116:	83 b8 38 7d 10 00 01 	cmpl   $0x1,0x107d38(%eax)
  10011d:	75 ee                	jne    10010d <schedule+0x1a>
  10011f:	e9 26 01 00 00       	jmp    10024a <schedule+0x157>
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == __EXERCISE_2__)
  100124:	83 f8 02             	cmp    $0x2,%eax
  100127:	75 35                	jne    10015e <schedule+0x6b>
  100129:	b0 01                	mov    $0x1,%al
  10012b:	ba 01 00 00 00       	mov    $0x1,%edx
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
				if(proc_array[pid].p_state == P_RUNNABLE)
  100130:	6b ca 5c             	imul   $0x5c,%edx,%ecx
  100133:	83 b9 38 7d 10 00 01 	cmpl   $0x1,0x107d38(%ecx)
  10013a:	75 11                	jne    10014d <schedule+0x5a>
					run(&proc_array[pid]);
  10013c:	6b c0 5c             	imul   $0x5c,%eax,%eax
  10013f:	83 ec 0c             	sub    $0xc,%esp
  100142:	05 e4 7c 10 00       	add    $0x107ce4,%eax
  100147:	50                   	push   %eax
  100148:	e8 58 05 00 00       	call   1006a5 <run>
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == __EXERCISE_2__)
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
  10014d:	8d 42 01             	lea    0x1(%edx),%eax
  100150:	83 f8 05             	cmp    $0x5,%eax
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == __EXERCISE_2__)
  100153:	89 c2                	mov    %eax,%edx
	{
		while(1) {
			for(pid=1; pid<=NPROCS; ++pid){
  100155:	7e d9                	jle    100130 <schedule+0x3d>
  100157:	b8 01 00 00 00       	mov    $0x1,%eax
  10015c:	eb cd                	jmp    10012b <schedule+0x38>
				if(proc_array[pid].p_state == P_RUNNABLE)
					run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == __EXERCISE_4A__)
  10015e:	83 f8 29             	cmp    $0x29,%eax
  100161:	75 48                	jne    1001ab <schedule+0xb8>
  100163:	83 c9 ff             	or     $0xffffffff,%ecx
					&& proc_array[i].p_priority < lowest_val){
					lowest_val = proc_array[i].p_priority;
				}
			}
			//alternate if same priority value
			pid = (pid+1) % NPROCS;
  100166:	bb 05 00 00 00       	mov    $0x5,%ebx
				if(proc_array[pid].p_state == P_RUNNABLE)
					run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == __EXERCISE_4A__)
  10016b:	31 c0                	xor    %eax,%eax
	{
		while(1) {
			pid_t i;
			//find process with highest priority = lowest value
			for(i=1; i<=NPROCS; ++i){
				if(proc_array[i].p_state == P_RUNNABLE
  10016d:	83 b8 94 7d 10 00 01 	cmpl   $0x1,0x107d94(%eax)
  100174:	75 0c                	jne    100182 <schedule+0x8f>
  100176:	8b b0 44 7d 10 00    	mov    0x107d44(%eax),%esi
  10017c:	39 f1                	cmp    %esi,%ecx
  10017e:	76 02                	jbe    100182 <schedule+0x8f>
  100180:	89 f1                	mov    %esi,%ecx
  100182:	83 c0 5c             	add    $0x5c,%eax
	else if (scheduling_algorithm == __EXERCISE_4A__)
	{
		while(1) {
			pid_t i;
			//find process with highest priority = lowest value
			for(i=1; i<=NPROCS; ++i){
  100185:	3d cc 01 00 00       	cmp    $0x1cc,%eax
  10018a:	75 e1                	jne    10016d <schedule+0x7a>
					&& proc_array[i].p_priority < lowest_val){
					lowest_val = proc_array[i].p_priority;
				}
			}
			//alternate if same priority value
			pid = (pid+1) % NPROCS;
  10018c:	8d 42 01             	lea    0x1(%edx),%eax
  10018f:	99                   	cltd   
  100190:	f7 fb                	idiv   %ebx
			//run highest priority process
			if(proc_array[pid].p_state == P_RUNNABLE
  100192:	6b c2 5c             	imul   $0x5c,%edx,%eax
  100195:	83 b8 38 7d 10 00 01 	cmpl   $0x1,0x107d38(%eax)
  10019c:	75 cd                	jne    10016b <schedule+0x78>
  10019e:	39 88 e8 7c 10 00    	cmp    %ecx,0x107ce8(%eax)
  1001a4:	77 c5                	ja     10016b <schedule+0x78>
  1001a6:	e9 9f 00 00 00       	jmp    10024a <schedule+0x157>
				&& proc_array[pid].p_priority <= lowest_val){
				run(&proc_array[pid]);
			}
		}
	}
	else if (scheduling_algorithm == __EXERCISE_4B__)
  1001ab:	83 f8 2a             	cmp    $0x2a,%eax
  1001ae:	75 3c                	jne    1001ec <schedule+0xf9>
				else{
					proc_array[pid].p_num++;		
					run(&proc_array[pid]);
				}
			}
			pid = (pid+1) % NPROCS;
  1001b0:	b9 05 00 00 00       	mov    $0x5,%ecx
				}
			}
			pid = (pid+1) % NPROCS;
		}*/
		while(1){
			if(proc_array[pid].p_state == P_RUNNABLE){
  1001b5:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1001b8:	83 b8 38 7d 10 00 01 	cmpl   $0x1,0x107d38(%eax)
  1001bf:	75 23                	jne    1001e4 <schedule+0xf1>
				if(proc_array[pid].p_num >= proc_array[pid].p_share){
  1001c1:	8b 98 f0 7c 10 00    	mov    0x107cf0(%eax),%ebx
  1001c7:	3b 98 ec 7c 10 00    	cmp    0x107cec(%eax),%ebx
  1001cd:	72 0c                	jb     1001db <schedule+0xe8>
					proc_array[pid].p_num = 0;
  1001cf:	c7 80 f0 7c 10 00 00 	movl   $0x0,0x107cf0(%eax)
  1001d6:	00 00 00 
  1001d9:	eb 09                	jmp    1001e4 <schedule+0xf1>
				}
				else{
					proc_array[pid].p_num++;		
  1001db:	43                   	inc    %ebx
  1001dc:	89 98 f0 7c 10 00    	mov    %ebx,0x107cf0(%eax)
  1001e2:	eb 66                	jmp    10024a <schedule+0x157>
					run(&proc_array[pid]);
				}
			}
			pid = (pid+1) % NPROCS;
  1001e4:	8d 42 01             	lea    0x1(%edx),%eax
  1001e7:	99                   	cltd   
  1001e8:	f7 f9                	idiv   %ecx
		}
  1001ea:	eb c9                	jmp    1001b5 <schedule+0xc2>
	}
	else if(scheduling_algorithm == __EXERCISE_7__)
  1001ec:	83 f8 07             	cmp    $0x7,%eax
  1001ef:	75 61                	jne    100252 <schedule+0x15f>
	{
		while(1){
			unsigned index;
			index = random() % ticket;
  1001f1:	8b 35 f4 8e 10 00    	mov    0x108ef4,%esi
  1001f7:	66 8b 0d b8 1c 10 00 	mov    0x101cb8,%cx
*/
unsigned short lfsr = 0xACE1u;
unsigned bit;
unsigned random()
{
	bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1;
  1001fe:	89 cb                	mov    %ecx,%ebx
  100200:	89 c8                	mov    %ecx,%eax
  100202:	66 c1 e8 03          	shr    $0x3,%ax
	else if(scheduling_algorithm == __EXERCISE_7__)
	{
		while(1){
			unsigned index;
			index = random() % ticket;
			if(proc_array[lotteryarray[index]].p_state == P_RUNNABLE){
  100206:	31 d2                	xor    %edx,%edx
*/
unsigned short lfsr = 0xACE1u;
unsigned bit;
unsigned random()
{
	bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1;
  100208:	66 c1 eb 02          	shr    $0x2,%bx
  10020c:	31 c3                	xor    %eax,%ebx
  10020e:	89 c8                	mov    %ecx,%eax
  100210:	31 cb                	xor    %ecx,%ebx
  100212:	66 c1 e8 05          	shr    $0x5,%ax
  100216:	31 c3                	xor    %eax,%ebx
	return lfsr = (lfsr >> 1) | (bit << 15);
  100218:	89 c8                	mov    %ecx,%eax
*/
unsigned short lfsr = 0xACE1u;
unsigned bit;
unsigned random()
{
	bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1;
  10021a:	83 e3 01             	and    $0x1,%ebx
	return lfsr = (lfsr >> 1) | (bit << 15);
  10021d:	89 d9                	mov    %ebx,%ecx
  10021f:	66 d1 e8             	shr    %ax
  100222:	c1 e1 0f             	shl    $0xf,%ecx
  100225:	09 c1                	or     %eax,%ecx
	else if(scheduling_algorithm == __EXERCISE_7__)
	{
		while(1){
			unsigned index;
			index = random() % ticket;
			if(proc_array[lotteryarray[index]].p_state == P_RUNNABLE){
  100227:	0f b7 c1             	movzwl %cx,%eax
  10022a:	f7 f6                	div    %esi
  10022c:	6b 04 95 1c 87 10 00 	imul   $0x5c,0x10871c(,%edx,4),%eax
  100233:	5c 
  100234:	83 b8 38 7d 10 00 01 	cmpl   $0x1,0x107d38(%eax)
  10023b:	75 c1                	jne    1001fe <schedule+0x10b>
  10023d:	66 89 0d b8 1c 10 00 	mov    %cx,0x101cb8
  100244:	89 1d 18 87 10 00    	mov    %ebx,0x108718
				run(&proc_array[lotteryarray[index]]);
  10024a:	83 ec 0c             	sub    $0xc,%esp
  10024d:	e9 f0 fe ff ff       	jmp    100142 <schedule+0x4f>
			}
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100252:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100258:	50                   	push   %eax
  100259:	68 64 0c 10 00       	push   $0x100c64
  10025e:	68 00 01 00 00       	push   $0x100
  100263:	52                   	push   %edx
  100264:	e8 e1 09 00 00       	call   100c4a <console_printf>
  100269:	83 c4 10             	add    $0x10,%esp
  10026c:	a3 00 80 19 00       	mov    %eax,0x198000
  100271:	eb fe                	jmp    100271 <schedule+0x17e>

00100273 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100273:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100274:	a1 ec 8e 10 00       	mov    0x108eec,%eax
  100279:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10027e:	56                   	push   %esi
  10027f:	53                   	push   %ebx
  100280:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100284:	8d 78 10             	lea    0x10(%eax),%edi
  100287:	89 de                	mov    %ebx,%esi
  100289:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10028b:	8b 53 28             	mov    0x28(%ebx),%edx
  10028e:	83 fa 32             	cmp    $0x32,%edx
  100291:	74 1c                	je     1002af <interrupt+0x3c>
  100293:	77 0e                	ja     1002a3 <interrupt+0x30>
  100295:	83 fa 30             	cmp    $0x30,%edx
  100298:	74 1d                	je     1002b7 <interrupt+0x44>
  10029a:	77 20                	ja     1002bc <interrupt+0x49>
  10029c:	83 fa 20             	cmp    $0x20,%edx
  10029f:	74 5d                	je     1002fe <interrupt+0x8b>
  1002a1:	eb 60                	jmp    100303 <interrupt+0x90>
  1002a3:	83 fa 33             	cmp    $0x33,%edx
  1002a6:	74 2b                	je     1002d3 <interrupt+0x60>
  1002a8:	83 fa 34             	cmp    $0x34,%edx
  1002ab:	74 3a                	je     1002e7 <interrupt+0x74>
  1002ad:	eb 54                	jmp    100303 <interrupt+0x90>
	
	case INT_SYS_SET_PRIORITY:
		current->p_priority = reg->reg_eax;
  1002af:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002b2:	89 50 04             	mov    %edx,0x4(%eax)
  1002b5:	eb 27                	jmp    1002de <interrupt+0x6b>
		run(current);

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1002b7:	e8 37 fe ff ff       	call   1000f3 <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002bc:	a1 ec 8e 10 00       	mov    0x108eec,%eax
		current->p_exit_status = reg->reg_eax;
  1002c1:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002c4:	c7 40 54 03 00 00 00 	movl   $0x3,0x54(%eax)
		current->p_exit_status = reg->reg_eax;
  1002cb:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  1002ce:	e8 20 fe ff ff       	call   1000f3 <schedule>

	case INT_SYS_SET_SHARE:
		/* Set register for p_share */
		current->p_share = reg->reg_eax;
  1002d3:	a1 ec 8e 10 00       	mov    0x108eec,%eax
  1002d8:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002db:	89 50 08             	mov    %edx,0x8(%eax)
		run(current);
  1002de:	83 ec 0c             	sub    $0xc,%esp
  1002e1:	50                   	push   %eax
  1002e2:	e8 be 03 00 00       	call   1006a5 <run>

	case INT_SYS_PRINT:
		*cursorpos++ = reg->reg_eax;
  1002e7:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1002ed:	8b 4b 1c             	mov    0x1c(%ebx),%ecx
  1002f0:	66 89 0a             	mov    %cx,(%edx)
  1002f3:	83 c2 02             	add    $0x2,%edx
  1002f6:	89 15 00 80 19 00    	mov    %edx,0x198000
  1002fc:	eb e0                	jmp    1002de <interrupt+0x6b>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1002fe:	e8 f0 fd ff ff       	call   1000f3 <schedule>
  100303:	eb fe                	jmp    100303 <interrupt+0x90>

00100305 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100305:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100306:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  10030b:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10030c:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10030e:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10030f:	bb 40 7d 10 00       	mov    $0x107d40,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100314:	e8 6b 01 00 00       	call   100484 <segments_init>
	interrupt_controller_init(1);
  100319:	83 ec 0c             	sub    $0xc,%esp
  10031c:	6a 01                	push   $0x1
  10031e:	e8 5c 02 00 00       	call   10057f <interrupt_controller_init>
	console_clear();
  100323:	e8 e0 02 00 00       	call   100608 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100328:	83 c4 0c             	add    $0xc,%esp
  10032b:	68 cc 01 00 00       	push   $0x1cc
  100330:	6a 00                	push   $0x0
  100332:	68 e4 7c 10 00       	push   $0x107ce4
  100337:	e8 ac 04 00 00       	call   1007e8 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10033c:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10033f:	c7 05 e4 7c 10 00 00 	movl   $0x0,0x107ce4
  100346:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100349:	c7 05 38 7d 10 00 00 	movl   $0x0,0x107d38
  100350:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100353:	c7 05 40 7d 10 00 01 	movl   $0x1,0x107d40
  10035a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10035d:	c7 05 94 7d 10 00 00 	movl   $0x0,0x107d94
  100364:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100367:	c7 05 9c 7d 10 00 02 	movl   $0x2,0x107d9c
  10036e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100371:	c7 05 f0 7d 10 00 00 	movl   $0x0,0x107df0
  100378:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10037b:	c7 05 f8 7d 10 00 03 	movl   $0x3,0x107df8
  100382:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100385:	c7 05 4c 7e 10 00 00 	movl   $0x0,0x107e4c
  10038c:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10038f:	c7 05 54 7e 10 00 04 	movl   $0x4,0x107e54
  100396:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100399:	c7 05 a8 7e 10 00 00 	movl   $0x0,0x107ea8
  1003a0:	00 00 00 
pid_t lotteryarray[MAX_TICKETS];
int ticket;

void add_ticket(pid_t pid)
{
	if(ticket < MAX_TICKETS){
  1003a3:	a1 f4 8e 10 00       	mov    0x108ef4,%eax
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;
		
		proc->p_priority = 0;
  1003a8:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
		proc->p_share = 1;
  1003af:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
		proc->p_num = 0;
  1003b6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
pid_t lotteryarray[MAX_TICKETS];
int ticket;

void add_ticket(pid_t pid)
{
	if(ticket < MAX_TICKETS){
  1003bd:	3d f3 01 00 00       	cmp    $0x1f3,%eax
  1003c2:	7f 11                	jg     1003d5 <start+0xd0>
		lotteryarray[ticket] = pid;
  1003c4:	c7 04 85 1c 87 10 00 	movl   $0x1,0x10871c(,%eax,4)
  1003cb:	01 00 00 00 
		ticket++;
  1003cf:	40                   	inc    %eax
  1003d0:	a3 f4 8e 10 00       	mov    %eax,0x108ef4
pid_t lotteryarray[MAX_TICKETS];
int ticket;

void add_ticket(pid_t pid)
{
	if(ticket < MAX_TICKETS){
  1003d5:	a1 f4 8e 10 00       	mov    0x108ef4,%eax
  1003da:	3d f3 01 00 00       	cmp    $0x1f3,%eax
  1003df:	7f 11                	jg     1003f2 <start+0xed>
		lotteryarray[ticket] = pid;
  1003e1:	c7 04 85 1c 87 10 00 	movl   $0x2,0x10871c(,%eax,4)
  1003e8:	02 00 00 00 
		ticket++;
  1003ec:	40                   	inc    %eax
  1003ed:	a3 f4 8e 10 00       	mov    %eax,0x108ef4
pid_t lotteryarray[MAX_TICKETS];
int ticket;

void add_ticket(pid_t pid)
{
	if(ticket < MAX_TICKETS){
  1003f2:	a1 f4 8e 10 00       	mov    0x108ef4,%eax
  1003f7:	3d f3 01 00 00       	cmp    $0x1f3,%eax
  1003fc:	7f 11                	jg     10040f <start+0x10a>
		lotteryarray[ticket] = pid;
  1003fe:	c7 04 85 1c 87 10 00 	movl   $0x2,0x10871c(,%eax,4)
  100405:	02 00 00 00 
		ticket++;
  100409:	40                   	inc    %eax
  10040a:	a3 f4 8e 10 00       	mov    %eax,0x108ef4
pid_t lotteryarray[MAX_TICKETS];
int ticket;

void add_ticket(pid_t pid)
{
	if(ticket < MAX_TICKETS){
  10040f:	a1 f4 8e 10 00       	mov    0x108ef4,%eax
  100414:	3d f3 01 00 00       	cmp    $0x1f3,%eax
  100419:	7f 11                	jg     10042c <start+0x127>
		lotteryarray[ticket] = pid;
  10041b:	c7 04 85 1c 87 10 00 	movl   $0x2,0x10871c(,%eax,4)
  100422:	02 00 00 00 
		ticket++;
  100426:	40                   	inc    %eax
  100427:	a3 f4 8e 10 00       	mov    %eax,0x108ef4
		add_ticket(2);
		add_ticket(2);
		
	
		// Initialize the process descriptor
		special_registers_init(proc);
  10042c:	83 ec 0c             	sub    $0xc,%esp
  10042f:	53                   	push   %ebx
  100430:	e8 87 02 00 00       	call   1006bc <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100435:	58                   	pop    %eax
  100436:	5a                   	pop    %edx
  100437:	8d 43 40             	lea    0x40(%ebx),%eax
	
		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10043a:	89 7b 4c             	mov    %edi,0x4c(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10043d:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100443:	50                   	push   %eax
  100444:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100445:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100446:	e8 ad 02 00 00       	call   1006f8 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10044b:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10044e:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  100455:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100458:	83 fe 04             	cmp    $0x4,%esi
  10045b:	0f 85 42 ff ff ff    	jne    1003a3 <start+0x9e>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 7;

	// Switch to the first process.
	run(&proc_array[1]);
  100461:	83 ec 0c             	sub    $0xc,%esp
  100464:	68 40 7d 10 00       	push   $0x107d40
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100469:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100470:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 7;
  100473:	c7 05 f0 8e 10 00 07 	movl   $0x7,0x108ef0
  10047a:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10047d:	e8 23 02 00 00       	call   1006a5 <run>
  100482:	90                   	nop
  100483:	90                   	nop

00100484 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100484:	b8 b0 7e 10 00       	mov    $0x107eb0,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100489:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10048e:	89 c2                	mov    %eax,%edx
  100490:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100493:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100494:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100499:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10049c:	66 a3 f6 1c 10 00    	mov    %ax,0x101cf6
  1004a2:	c1 e8 18             	shr    $0x18,%eax
  1004a5:	88 15 f8 1c 10 00    	mov    %dl,0x101cf8
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004ab:	ba 18 7f 10 00       	mov    $0x107f18,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004b0:	a2 fb 1c 10 00       	mov    %al,0x101cfb
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004b5:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004b7:	66 c7 05 f4 1c 10 00 	movw   $0x68,0x101cf4
  1004be:	68 00 
  1004c0:	c6 05 fa 1c 10 00 40 	movb   $0x40,0x101cfa
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1004c7:	c6 05 f9 1c 10 00 89 	movb   $0x89,0x101cf9

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1004ce:	c7 05 b4 7e 10 00 00 	movl   $0x180000,0x107eb4
  1004d5:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1004d8:	66 c7 05 b8 7e 10 00 	movw   $0x10,0x107eb8
  1004df:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004e1:	66 89 0c c5 18 7f 10 	mov    %cx,0x107f18(,%eax,8)
  1004e8:	00 
  1004e9:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004f0:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004f5:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1004fa:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1004ff:	40                   	inc    %eax
  100500:	3d 00 01 00 00       	cmp    $0x100,%eax
  100505:	75 da                	jne    1004e1 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100507:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10050c:	ba 18 7f 10 00       	mov    $0x107f18,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100511:	66 a3 18 80 10 00    	mov    %ax,0x108018
  100517:	c1 e8 10             	shr    $0x10,%eax
  10051a:	66 a3 1e 80 10 00    	mov    %ax,0x10801e
  100520:	b8 30 00 00 00       	mov    $0x30,%eax
  100525:	66 c7 05 1a 80 10 00 	movw   $0x8,0x10801a
  10052c:	08 00 
  10052e:	c6 05 1c 80 10 00 00 	movb   $0x0,0x10801c
  100535:	c6 05 1d 80 10 00 8e 	movb   $0x8e,0x10801d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10053c:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100543:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10054a:	66 89 0c c5 18 7f 10 	mov    %cx,0x107f18(,%eax,8)
  100551:	00 
  100552:	c1 e9 10             	shr    $0x10,%ecx
  100555:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10055a:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10055f:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100564:	40                   	inc    %eax
  100565:	83 f8 3a             	cmp    $0x3a,%eax
  100568:	75 d2                	jne    10053c <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10056a:	b0 28                	mov    $0x28,%al
  10056c:	0f 01 15 bc 1c 10 00 	lgdtl  0x101cbc
  100573:	0f 00 d8             	ltr    %ax
  100576:	0f 01 1d c4 1c 10 00 	lidtl  0x101cc4
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  10057d:	5b                   	pop    %ebx
  10057e:	c3                   	ret    

0010057f <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10057f:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100580:	b0 ff                	mov    $0xff,%al
  100582:	57                   	push   %edi
  100583:	56                   	push   %esi
  100584:	53                   	push   %ebx
  100585:	bb 21 00 00 00       	mov    $0x21,%ebx
  10058a:	89 da                	mov    %ebx,%edx
  10058c:	ee                   	out    %al,(%dx)
  10058d:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100592:	89 ca                	mov    %ecx,%edx
  100594:	ee                   	out    %al,(%dx)
  100595:	be 11 00 00 00       	mov    $0x11,%esi
  10059a:	bf 20 00 00 00       	mov    $0x20,%edi
  10059f:	89 f0                	mov    %esi,%eax
  1005a1:	89 fa                	mov    %edi,%edx
  1005a3:	ee                   	out    %al,(%dx)
  1005a4:	b0 20                	mov    $0x20,%al
  1005a6:	89 da                	mov    %ebx,%edx
  1005a8:	ee                   	out    %al,(%dx)
  1005a9:	b0 04                	mov    $0x4,%al
  1005ab:	ee                   	out    %al,(%dx)
  1005ac:	b0 03                	mov    $0x3,%al
  1005ae:	ee                   	out    %al,(%dx)
  1005af:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1005b4:	89 f0                	mov    %esi,%eax
  1005b6:	89 ea                	mov    %ebp,%edx
  1005b8:	ee                   	out    %al,(%dx)
  1005b9:	b0 28                	mov    $0x28,%al
  1005bb:	89 ca                	mov    %ecx,%edx
  1005bd:	ee                   	out    %al,(%dx)
  1005be:	b0 02                	mov    $0x2,%al
  1005c0:	ee                   	out    %al,(%dx)
  1005c1:	b0 01                	mov    $0x1,%al
  1005c3:	ee                   	out    %al,(%dx)
  1005c4:	b0 68                	mov    $0x68,%al
  1005c6:	89 fa                	mov    %edi,%edx
  1005c8:	ee                   	out    %al,(%dx)
  1005c9:	be 0a 00 00 00       	mov    $0xa,%esi
  1005ce:	89 f0                	mov    %esi,%eax
  1005d0:	ee                   	out    %al,(%dx)
  1005d1:	b0 68                	mov    $0x68,%al
  1005d3:	89 ea                	mov    %ebp,%edx
  1005d5:	ee                   	out    %al,(%dx)
  1005d6:	89 f0                	mov    %esi,%eax
  1005d8:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1005d9:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1005de:	89 da                	mov    %ebx,%edx
  1005e0:	19 c0                	sbb    %eax,%eax
  1005e2:	f7 d0                	not    %eax
  1005e4:	05 ff 00 00 00       	add    $0xff,%eax
  1005e9:	ee                   	out    %al,(%dx)
  1005ea:	b0 ff                	mov    $0xff,%al
  1005ec:	89 ca                	mov    %ecx,%edx
  1005ee:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1005ef:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1005f4:	74 0d                	je     100603 <interrupt_controller_init+0x84>
  1005f6:	b2 43                	mov    $0x43,%dl
  1005f8:	b0 34                	mov    $0x34,%al
  1005fa:	ee                   	out    %al,(%dx)
  1005fb:	b0 8e                	mov    $0x8e,%al
  1005fd:	b2 40                	mov    $0x40,%dl
  1005ff:	ee                   	out    %al,(%dx)
  100600:	b0 01                	mov    $0x1,%al
  100602:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100603:	5b                   	pop    %ebx
  100604:	5e                   	pop    %esi
  100605:	5f                   	pop    %edi
  100606:	5d                   	pop    %ebp
  100607:	c3                   	ret    

00100608 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100608:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100609:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10060b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10060c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100613:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100616:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10061c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100622:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100625:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10062a:	75 ea                	jne    100616 <console_clear+0xe>
  10062c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100631:	b0 0e                	mov    $0xe,%al
  100633:	89 f2                	mov    %esi,%edx
  100635:	ee                   	out    %al,(%dx)
  100636:	31 c9                	xor    %ecx,%ecx
  100638:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10063d:	88 c8                	mov    %cl,%al
  10063f:	89 da                	mov    %ebx,%edx
  100641:	ee                   	out    %al,(%dx)
  100642:	b0 0f                	mov    $0xf,%al
  100644:	89 f2                	mov    %esi,%edx
  100646:	ee                   	out    %al,(%dx)
  100647:	88 c8                	mov    %cl,%al
  100649:	89 da                	mov    %ebx,%edx
  10064b:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  10064c:	5b                   	pop    %ebx
  10064d:	5e                   	pop    %esi
  10064e:	c3                   	ret    

0010064f <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10064f:	ba 64 00 00 00       	mov    $0x64,%edx
  100654:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100655:	a8 01                	test   $0x1,%al
  100657:	74 45                	je     10069e <console_read_digit+0x4f>
  100659:	b2 60                	mov    $0x60,%dl
  10065b:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  10065c:	8d 50 fe             	lea    -0x2(%eax),%edx
  10065f:	80 fa 08             	cmp    $0x8,%dl
  100662:	77 05                	ja     100669 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100664:	0f b6 c0             	movzbl %al,%eax
  100667:	48                   	dec    %eax
  100668:	c3                   	ret    
	else if (data == 0x0B)
  100669:	3c 0b                	cmp    $0xb,%al
  10066b:	74 35                	je     1006a2 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  10066d:	8d 50 b9             	lea    -0x47(%eax),%edx
  100670:	80 fa 02             	cmp    $0x2,%dl
  100673:	77 07                	ja     10067c <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100675:	0f b6 c0             	movzbl %al,%eax
  100678:	83 e8 40             	sub    $0x40,%eax
  10067b:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  10067c:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10067f:	80 fa 02             	cmp    $0x2,%dl
  100682:	77 07                	ja     10068b <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100684:	0f b6 c0             	movzbl %al,%eax
  100687:	83 e8 47             	sub    $0x47,%eax
  10068a:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10068b:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10068e:	80 fa 02             	cmp    $0x2,%dl
  100691:	77 07                	ja     10069a <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100693:	0f b6 c0             	movzbl %al,%eax
  100696:	83 e8 4e             	sub    $0x4e,%eax
  100699:	c3                   	ret    
	else if (data == 0x53)
  10069a:	3c 53                	cmp    $0x53,%al
  10069c:	74 04                	je     1006a2 <console_read_digit+0x53>
  10069e:	83 c8 ff             	or     $0xffffffff,%eax
  1006a1:	c3                   	ret    
  1006a2:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1006a4:	c3                   	ret    

001006a5 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1006a5:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1006a9:	a3 ec 8e 10 00       	mov    %eax,0x108eec

	asm volatile("movl %0,%%esp\n\t"
  1006ae:	83 c0 10             	add    $0x10,%eax
  1006b1:	89 c4                	mov    %eax,%esp
  1006b3:	61                   	popa   
  1006b4:	07                   	pop    %es
  1006b5:	1f                   	pop    %ds
  1006b6:	83 c4 08             	add    $0x8,%esp
  1006b9:	cf                   	iret   
  1006ba:	eb fe                	jmp    1006ba <run+0x15>

001006bc <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1006bc:	53                   	push   %ebx
  1006bd:	83 ec 0c             	sub    $0xc,%esp
  1006c0:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1006c4:	6a 44                	push   $0x44
  1006c6:	6a 00                	push   $0x0
  1006c8:	8d 43 10             	lea    0x10(%ebx),%eax
  1006cb:	50                   	push   %eax
  1006cc:	e8 17 01 00 00       	call   1007e8 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1006d1:	66 c7 43 44 1b 00    	movw   $0x1b,0x44(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1006d7:	66 c7 43 34 23 00    	movw   $0x23,0x34(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1006dd:	66 c7 43 30 23 00    	movw   $0x23,0x30(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1006e3:	66 c7 43 50 23 00    	movw   $0x23,0x50(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1006e9:	c7 43 48 00 02 00 00 	movl   $0x200,0x48(%ebx)
}
  1006f0:	83 c4 18             	add    $0x18,%esp
  1006f3:	5b                   	pop    %ebx
  1006f4:	c3                   	ret    
  1006f5:	90                   	nop
  1006f6:	90                   	nop
  1006f7:	90                   	nop

001006f8 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1006f8:	55                   	push   %ebp
  1006f9:	57                   	push   %edi
  1006fa:	56                   	push   %esi
  1006fb:	53                   	push   %ebx
  1006fc:	83 ec 1c             	sub    $0x1c,%esp
  1006ff:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100703:	83 f8 03             	cmp    $0x3,%eax
  100706:	7f 04                	jg     10070c <program_loader+0x14>
  100708:	85 c0                	test   %eax,%eax
  10070a:	79 02                	jns    10070e <program_loader+0x16>
  10070c:	eb fe                	jmp    10070c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10070e:	8b 34 c5 fc 1c 10 00 	mov    0x101cfc(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100715:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10071b:	74 02                	je     10071f <program_loader+0x27>
  10071d:	eb fe                	jmp    10071d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10071f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100722:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100726:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100728:	c1 e5 05             	shl    $0x5,%ebp
  10072b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10072e:	eb 3f                	jmp    10076f <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100730:	83 3b 01             	cmpl   $0x1,(%ebx)
  100733:	75 37                	jne    10076c <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100735:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100738:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10073b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10073e:	01 c7                	add    %eax,%edi
	memsz += va;
  100740:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100742:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100747:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10074b:	52                   	push   %edx
  10074c:	89 fa                	mov    %edi,%edx
  10074e:	29 c2                	sub    %eax,%edx
  100750:	52                   	push   %edx
  100751:	8b 53 04             	mov    0x4(%ebx),%edx
  100754:	01 f2                	add    %esi,%edx
  100756:	52                   	push   %edx
  100757:	50                   	push   %eax
  100758:	e8 27 00 00 00       	call   100784 <memcpy>
  10075d:	83 c4 10             	add    $0x10,%esp
  100760:	eb 04                	jmp    100766 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100762:	c6 07 00             	movb   $0x0,(%edi)
  100765:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100766:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10076a:	72 f6                	jb     100762 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  10076c:	83 c3 20             	add    $0x20,%ebx
  10076f:	39 eb                	cmp    %ebp,%ebx
  100771:	72 bd                	jb     100730 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100773:	8b 56 18             	mov    0x18(%esi),%edx
  100776:	8b 44 24 34          	mov    0x34(%esp),%eax
  10077a:	89 10                	mov    %edx,(%eax)
}
  10077c:	83 c4 1c             	add    $0x1c,%esp
  10077f:	5b                   	pop    %ebx
  100780:	5e                   	pop    %esi
  100781:	5f                   	pop    %edi
  100782:	5d                   	pop    %ebp
  100783:	c3                   	ret    

00100784 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100784:	56                   	push   %esi
  100785:	31 d2                	xor    %edx,%edx
  100787:	53                   	push   %ebx
  100788:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10078c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100790:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100794:	eb 08                	jmp    10079e <memcpy+0x1a>
		*d++ = *s++;
  100796:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100799:	4e                   	dec    %esi
  10079a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10079d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10079e:	85 f6                	test   %esi,%esi
  1007a0:	75 f4                	jne    100796 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1007a2:	5b                   	pop    %ebx
  1007a3:	5e                   	pop    %esi
  1007a4:	c3                   	ret    

001007a5 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1007a5:	57                   	push   %edi
  1007a6:	56                   	push   %esi
  1007a7:	53                   	push   %ebx
  1007a8:	8b 44 24 10          	mov    0x10(%esp),%eax
  1007ac:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1007b0:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1007b4:	39 c7                	cmp    %eax,%edi
  1007b6:	73 26                	jae    1007de <memmove+0x39>
  1007b8:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1007bb:	39 c6                	cmp    %eax,%esi
  1007bd:	76 1f                	jbe    1007de <memmove+0x39>
		s += n, d += n;
  1007bf:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1007c2:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1007c4:	eb 07                	jmp    1007cd <memmove+0x28>
			*--d = *--s;
  1007c6:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1007c9:	4a                   	dec    %edx
  1007ca:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1007cd:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1007ce:	85 d2                	test   %edx,%edx
  1007d0:	75 f4                	jne    1007c6 <memmove+0x21>
  1007d2:	eb 10                	jmp    1007e4 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1007d4:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1007d7:	4a                   	dec    %edx
  1007d8:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1007db:	41                   	inc    %ecx
  1007dc:	eb 02                	jmp    1007e0 <memmove+0x3b>
  1007de:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1007e0:	85 d2                	test   %edx,%edx
  1007e2:	75 f0                	jne    1007d4 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1007e4:	5b                   	pop    %ebx
  1007e5:	5e                   	pop    %esi
  1007e6:	5f                   	pop    %edi
  1007e7:	c3                   	ret    

001007e8 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1007e8:	53                   	push   %ebx
  1007e9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1007ed:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1007f1:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1007f5:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1007f7:	eb 04                	jmp    1007fd <memset+0x15>
		*p++ = c;
  1007f9:	88 1a                	mov    %bl,(%edx)
  1007fb:	49                   	dec    %ecx
  1007fc:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1007fd:	85 c9                	test   %ecx,%ecx
  1007ff:	75 f8                	jne    1007f9 <memset+0x11>
		*p++ = c;
	return v;
}
  100801:	5b                   	pop    %ebx
  100802:	c3                   	ret    

00100803 <strlen>:

size_t
strlen(const char *s)
{
  100803:	8b 54 24 04          	mov    0x4(%esp),%edx
  100807:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100809:	eb 01                	jmp    10080c <strlen+0x9>
		++n;
  10080b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10080c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100810:	75 f9                	jne    10080b <strlen+0x8>
		++n;
	return n;
}
  100812:	c3                   	ret    

00100813 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100813:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100817:	31 c0                	xor    %eax,%eax
  100819:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10081d:	eb 01                	jmp    100820 <strnlen+0xd>
		++n;
  10081f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100820:	39 d0                	cmp    %edx,%eax
  100822:	74 06                	je     10082a <strnlen+0x17>
  100824:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100828:	75 f5                	jne    10081f <strnlen+0xc>
		++n;
	return n;
}
  10082a:	c3                   	ret    

0010082b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10082b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10082c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100831:	53                   	push   %ebx
  100832:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100834:	76 05                	jbe    10083b <console_putc+0x10>
  100836:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10083b:	80 fa 0a             	cmp    $0xa,%dl
  10083e:	75 2c                	jne    10086c <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100840:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100846:	be 50 00 00 00       	mov    $0x50,%esi
  10084b:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  10084d:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100850:	99                   	cltd   
  100851:	f7 fe                	idiv   %esi
  100853:	89 de                	mov    %ebx,%esi
  100855:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100857:	eb 07                	jmp    100860 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100859:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10085c:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  10085d:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100860:	83 f8 50             	cmp    $0x50,%eax
  100863:	75 f4                	jne    100859 <console_putc+0x2e>
  100865:	29 d0                	sub    %edx,%eax
  100867:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10086a:	eb 0b                	jmp    100877 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  10086c:	0f b6 d2             	movzbl %dl,%edx
  10086f:	09 ca                	or     %ecx,%edx
  100871:	66 89 13             	mov    %dx,(%ebx)
  100874:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100877:	5b                   	pop    %ebx
  100878:	5e                   	pop    %esi
  100879:	c3                   	ret    

0010087a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10087a:	56                   	push   %esi
  10087b:	53                   	push   %ebx
  10087c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100880:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100883:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100887:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10088c:	75 04                	jne    100892 <fill_numbuf+0x18>
  10088e:	85 d2                	test   %edx,%edx
  100890:	74 10                	je     1008a2 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100892:	89 d0                	mov    %edx,%eax
  100894:	31 d2                	xor    %edx,%edx
  100896:	f7 f1                	div    %ecx
  100898:	4b                   	dec    %ebx
  100899:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10089c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10089e:	89 c2                	mov    %eax,%edx
  1008a0:	eb ec                	jmp    10088e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1008a2:	89 d8                	mov    %ebx,%eax
  1008a4:	5b                   	pop    %ebx
  1008a5:	5e                   	pop    %esi
  1008a6:	c3                   	ret    

001008a7 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1008a7:	55                   	push   %ebp
  1008a8:	57                   	push   %edi
  1008a9:	56                   	push   %esi
  1008aa:	53                   	push   %ebx
  1008ab:	83 ec 38             	sub    $0x38,%esp
  1008ae:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1008b2:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1008b6:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1008ba:	e9 60 03 00 00       	jmp    100c1f <console_vprintf+0x378>
		if (*format != '%') {
  1008bf:	80 fa 25             	cmp    $0x25,%dl
  1008c2:	74 13                	je     1008d7 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1008c4:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008c8:	0f b6 d2             	movzbl %dl,%edx
  1008cb:	89 f0                	mov    %esi,%eax
  1008cd:	e8 59 ff ff ff       	call   10082b <console_putc>
  1008d2:	e9 45 03 00 00       	jmp    100c1c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1008d7:	47                   	inc    %edi
  1008d8:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1008df:	00 
  1008e0:	eb 12                	jmp    1008f4 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1008e2:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1008e3:	8a 11                	mov    (%ecx),%dl
  1008e5:	84 d2                	test   %dl,%dl
  1008e7:	74 1a                	je     100903 <console_vprintf+0x5c>
  1008e9:	89 e8                	mov    %ebp,%eax
  1008eb:	38 c2                	cmp    %al,%dl
  1008ed:	75 f3                	jne    1008e2 <console_vprintf+0x3b>
  1008ef:	e9 3f 03 00 00       	jmp    100c33 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1008f4:	8a 17                	mov    (%edi),%dl
  1008f6:	84 d2                	test   %dl,%dl
  1008f8:	74 0b                	je     100905 <console_vprintf+0x5e>
  1008fa:	b9 88 0c 10 00       	mov    $0x100c88,%ecx
  1008ff:	89 d5                	mov    %edx,%ebp
  100901:	eb e0                	jmp    1008e3 <console_vprintf+0x3c>
  100903:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100905:	8d 42 cf             	lea    -0x31(%edx),%eax
  100908:	3c 08                	cmp    $0x8,%al
  10090a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100911:	00 
  100912:	76 13                	jbe    100927 <console_vprintf+0x80>
  100914:	eb 1d                	jmp    100933 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100916:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10091b:	0f be c0             	movsbl %al,%eax
  10091e:	47                   	inc    %edi
  10091f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100923:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100927:	8a 07                	mov    (%edi),%al
  100929:	8d 50 d0             	lea    -0x30(%eax),%edx
  10092c:	80 fa 09             	cmp    $0x9,%dl
  10092f:	76 e5                	jbe    100916 <console_vprintf+0x6f>
  100931:	eb 18                	jmp    10094b <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100933:	80 fa 2a             	cmp    $0x2a,%dl
  100936:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10093d:	ff 
  10093e:	75 0b                	jne    10094b <console_vprintf+0xa4>
			width = va_arg(val, int);
  100940:	83 c3 04             	add    $0x4,%ebx
			++format;
  100943:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100944:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100947:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10094b:	83 cd ff             	or     $0xffffffff,%ebp
  10094e:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100951:	75 37                	jne    10098a <console_vprintf+0xe3>
			++format;
  100953:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100954:	31 ed                	xor    %ebp,%ebp
  100956:	8a 07                	mov    (%edi),%al
  100958:	8d 50 d0             	lea    -0x30(%eax),%edx
  10095b:	80 fa 09             	cmp    $0x9,%dl
  10095e:	76 0d                	jbe    10096d <console_vprintf+0xc6>
  100960:	eb 17                	jmp    100979 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100962:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100965:	0f be c0             	movsbl %al,%eax
  100968:	47                   	inc    %edi
  100969:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  10096d:	8a 07                	mov    (%edi),%al
  10096f:	8d 50 d0             	lea    -0x30(%eax),%edx
  100972:	80 fa 09             	cmp    $0x9,%dl
  100975:	76 eb                	jbe    100962 <console_vprintf+0xbb>
  100977:	eb 11                	jmp    10098a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100979:	3c 2a                	cmp    $0x2a,%al
  10097b:	75 0b                	jne    100988 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10097d:	83 c3 04             	add    $0x4,%ebx
				++format;
  100980:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100981:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100984:	85 ed                	test   %ebp,%ebp
  100986:	79 02                	jns    10098a <console_vprintf+0xe3>
  100988:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10098a:	8a 07                	mov    (%edi),%al
  10098c:	3c 64                	cmp    $0x64,%al
  10098e:	74 34                	je     1009c4 <console_vprintf+0x11d>
  100990:	7f 1d                	jg     1009af <console_vprintf+0x108>
  100992:	3c 58                	cmp    $0x58,%al
  100994:	0f 84 a2 00 00 00    	je     100a3c <console_vprintf+0x195>
  10099a:	3c 63                	cmp    $0x63,%al
  10099c:	0f 84 bf 00 00 00    	je     100a61 <console_vprintf+0x1ba>
  1009a2:	3c 43                	cmp    $0x43,%al
  1009a4:	0f 85 d0 00 00 00    	jne    100a7a <console_vprintf+0x1d3>
  1009aa:	e9 a3 00 00 00       	jmp    100a52 <console_vprintf+0x1ab>
  1009af:	3c 75                	cmp    $0x75,%al
  1009b1:	74 4d                	je     100a00 <console_vprintf+0x159>
  1009b3:	3c 78                	cmp    $0x78,%al
  1009b5:	74 5c                	je     100a13 <console_vprintf+0x16c>
  1009b7:	3c 73                	cmp    $0x73,%al
  1009b9:	0f 85 bb 00 00 00    	jne    100a7a <console_vprintf+0x1d3>
  1009bf:	e9 86 00 00 00       	jmp    100a4a <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1009c4:	83 c3 04             	add    $0x4,%ebx
  1009c7:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1009ca:	89 d1                	mov    %edx,%ecx
  1009cc:	c1 f9 1f             	sar    $0x1f,%ecx
  1009cf:	89 0c 24             	mov    %ecx,(%esp)
  1009d2:	31 ca                	xor    %ecx,%edx
  1009d4:	55                   	push   %ebp
  1009d5:	29 ca                	sub    %ecx,%edx
  1009d7:	68 90 0c 10 00       	push   $0x100c90
  1009dc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009e1:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009e5:	e8 90 fe ff ff       	call   10087a <fill_numbuf>
  1009ea:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1009ee:	58                   	pop    %eax
  1009ef:	5a                   	pop    %edx
  1009f0:	ba 01 00 00 00       	mov    $0x1,%edx
  1009f5:	8b 04 24             	mov    (%esp),%eax
  1009f8:	83 e0 01             	and    $0x1,%eax
  1009fb:	e9 a5 00 00 00       	jmp    100aa5 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100a00:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100a03:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a08:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a0b:	55                   	push   %ebp
  100a0c:	68 90 0c 10 00       	push   $0x100c90
  100a11:	eb 11                	jmp    100a24 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100a13:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100a16:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a19:	55                   	push   %ebp
  100a1a:	68 a4 0c 10 00       	push   $0x100ca4
  100a1f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100a24:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a28:	e8 4d fe ff ff       	call   10087a <fill_numbuf>
  100a2d:	ba 01 00 00 00       	mov    $0x1,%edx
  100a32:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a36:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100a38:	59                   	pop    %ecx
  100a39:	59                   	pop    %ecx
  100a3a:	eb 69                	jmp    100aa5 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100a3c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100a3f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a42:	55                   	push   %ebp
  100a43:	68 90 0c 10 00       	push   $0x100c90
  100a48:	eb d5                	jmp    100a1f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100a4a:	83 c3 04             	add    $0x4,%ebx
  100a4d:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100a50:	eb 40                	jmp    100a92 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100a52:	83 c3 04             	add    $0x4,%ebx
  100a55:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a58:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100a5c:	e9 bd 01 00 00       	jmp    100c1e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a61:	83 c3 04             	add    $0x4,%ebx
  100a64:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a67:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a6b:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100a70:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a74:	88 44 24 24          	mov    %al,0x24(%esp)
  100a78:	eb 27                	jmp    100aa1 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100a7a:	84 c0                	test   %al,%al
  100a7c:	75 02                	jne    100a80 <console_vprintf+0x1d9>
  100a7e:	b0 25                	mov    $0x25,%al
  100a80:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a84:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a89:	80 3f 00             	cmpb   $0x0,(%edi)
  100a8c:	74 0a                	je     100a98 <console_vprintf+0x1f1>
  100a8e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a92:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a96:	eb 09                	jmp    100aa1 <console_vprintf+0x1fa>
				format--;
  100a98:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a9c:	4f                   	dec    %edi
  100a9d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100aa1:	31 d2                	xor    %edx,%edx
  100aa3:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100aa5:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100aa7:	83 fd ff             	cmp    $0xffffffff,%ebp
  100aaa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100ab1:	74 1f                	je     100ad2 <console_vprintf+0x22b>
  100ab3:	89 04 24             	mov    %eax,(%esp)
  100ab6:	eb 01                	jmp    100ab9 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100ab8:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100ab9:	39 e9                	cmp    %ebp,%ecx
  100abb:	74 0a                	je     100ac7 <console_vprintf+0x220>
  100abd:	8b 44 24 04          	mov    0x4(%esp),%eax
  100ac1:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100ac5:	75 f1                	jne    100ab8 <console_vprintf+0x211>
  100ac7:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100aca:	89 0c 24             	mov    %ecx,(%esp)
  100acd:	eb 1f                	jmp    100aee <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100acf:	42                   	inc    %edx
  100ad0:	eb 09                	jmp    100adb <console_vprintf+0x234>
  100ad2:	89 d1                	mov    %edx,%ecx
  100ad4:	8b 14 24             	mov    (%esp),%edx
  100ad7:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100adb:	8b 44 24 04          	mov    0x4(%esp),%eax
  100adf:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100ae3:	75 ea                	jne    100acf <console_vprintf+0x228>
  100ae5:	8b 44 24 08          	mov    0x8(%esp),%eax
  100ae9:	89 14 24             	mov    %edx,(%esp)
  100aec:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100aee:	85 c0                	test   %eax,%eax
  100af0:	74 0c                	je     100afe <console_vprintf+0x257>
  100af2:	84 d2                	test   %dl,%dl
  100af4:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100afb:	00 
  100afc:	75 24                	jne    100b22 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100afe:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100b03:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100b0a:	00 
  100b0b:	75 15                	jne    100b22 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100b0d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b11:	83 e0 08             	and    $0x8,%eax
  100b14:	83 f8 01             	cmp    $0x1,%eax
  100b17:	19 c9                	sbb    %ecx,%ecx
  100b19:	f7 d1                	not    %ecx
  100b1b:	83 e1 20             	and    $0x20,%ecx
  100b1e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100b22:	3b 2c 24             	cmp    (%esp),%ebp
  100b25:	7e 0d                	jle    100b34 <console_vprintf+0x28d>
  100b27:	84 d2                	test   %dl,%dl
  100b29:	74 40                	je     100b6b <console_vprintf+0x2c4>
			zeros = precision - len;
  100b2b:	2b 2c 24             	sub    (%esp),%ebp
  100b2e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100b32:	eb 3f                	jmp    100b73 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b34:	84 d2                	test   %dl,%dl
  100b36:	74 33                	je     100b6b <console_vprintf+0x2c4>
  100b38:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b3c:	83 e0 06             	and    $0x6,%eax
  100b3f:	83 f8 02             	cmp    $0x2,%eax
  100b42:	75 27                	jne    100b6b <console_vprintf+0x2c4>
  100b44:	45                   	inc    %ebp
  100b45:	75 24                	jne    100b6b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b47:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b49:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b4c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b51:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b54:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100b57:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100b5b:	7d 0e                	jge    100b6b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100b5d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100b61:	29 ca                	sub    %ecx,%edx
  100b63:	29 c2                	sub    %eax,%edx
  100b65:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b69:	eb 08                	jmp    100b73 <console_vprintf+0x2cc>
  100b6b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100b72:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b73:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100b77:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b79:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b7d:	2b 2c 24             	sub    (%esp),%ebp
  100b80:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b85:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b88:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b8b:	29 c5                	sub    %eax,%ebp
  100b8d:	89 f0                	mov    %esi,%eax
  100b8f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b93:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b97:	eb 0f                	jmp    100ba8 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b99:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b9d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ba2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100ba3:	e8 83 fc ff ff       	call   10082b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ba8:	85 ed                	test   %ebp,%ebp
  100baa:	7e 07                	jle    100bb3 <console_vprintf+0x30c>
  100bac:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100bb1:	74 e6                	je     100b99 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100bb3:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bb8:	89 c6                	mov    %eax,%esi
  100bba:	74 23                	je     100bdf <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100bbc:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100bc1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bc5:	e8 61 fc ff ff       	call   10082b <console_putc>
  100bca:	89 c6                	mov    %eax,%esi
  100bcc:	eb 11                	jmp    100bdf <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100bce:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bd2:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100bd7:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100bd8:	e8 4e fc ff ff       	call   10082b <console_putc>
  100bdd:	eb 06                	jmp    100be5 <console_vprintf+0x33e>
  100bdf:	89 f0                	mov    %esi,%eax
  100be1:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100be5:	85 f6                	test   %esi,%esi
  100be7:	7f e5                	jg     100bce <console_vprintf+0x327>
  100be9:	8b 34 24             	mov    (%esp),%esi
  100bec:	eb 15                	jmp    100c03 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100bee:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100bf2:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100bf3:	0f b6 11             	movzbl (%ecx),%edx
  100bf6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bfa:	e8 2c fc ff ff       	call   10082b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100bff:	ff 44 24 04          	incl   0x4(%esp)
  100c03:	85 f6                	test   %esi,%esi
  100c05:	7f e7                	jg     100bee <console_vprintf+0x347>
  100c07:	eb 0f                	jmp    100c18 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100c09:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c0d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c12:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c13:	e8 13 fc ff ff       	call   10082b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c18:	85 ed                	test   %ebp,%ebp
  100c1a:	7f ed                	jg     100c09 <console_vprintf+0x362>
  100c1c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100c1e:	47                   	inc    %edi
  100c1f:	8a 17                	mov    (%edi),%dl
  100c21:	84 d2                	test   %dl,%dl
  100c23:	0f 85 96 fc ff ff    	jne    1008bf <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100c29:	83 c4 38             	add    $0x38,%esp
  100c2c:	89 f0                	mov    %esi,%eax
  100c2e:	5b                   	pop    %ebx
  100c2f:	5e                   	pop    %esi
  100c30:	5f                   	pop    %edi
  100c31:	5d                   	pop    %ebp
  100c32:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c33:	81 e9 88 0c 10 00    	sub    $0x100c88,%ecx
  100c39:	b8 01 00 00 00       	mov    $0x1,%eax
  100c3e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100c40:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c41:	09 44 24 14          	or     %eax,0x14(%esp)
  100c45:	e9 aa fc ff ff       	jmp    1008f4 <console_vprintf+0x4d>

00100c4a <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100c4a:	8d 44 24 10          	lea    0x10(%esp),%eax
  100c4e:	50                   	push   %eax
  100c4f:	ff 74 24 10          	pushl  0x10(%esp)
  100c53:	ff 74 24 10          	pushl  0x10(%esp)
  100c57:	ff 74 24 10          	pushl  0x10(%esp)
  100c5b:	e8 47 fc ff ff       	call   1008a7 <console_vprintf>
  100c60:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100c63:	c3                   	ret    
