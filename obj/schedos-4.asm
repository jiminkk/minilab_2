
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
set_priority(unsigned int priority)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_PRIORITY.
	asm volatile("int %0\n"
  500000:	31 c0                	xor    %eax,%eax
  500002:	cd 32                	int    $0x32
set_share(unsigned int share)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_SHARE.
	asm volatile("int %0\n"
  500004:	b0 01                	mov    $0x1,%al
  500006:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  500008:	cd 30                	int    $0x30
  50000a:	30 c0                	xor    %al,%al
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  50000c:	ba 01 00 00 00       	mov    $0x1,%edx
  500011:	87 15 04 80 19 00    	xchg   %edx,0x198004
		// Write characters to the console, yielding after each one.
		//*cursorpos++ = PRINTCHAR;
		#ifdef __EXERCISE_8__
			// extra credit exercise 8
			// attempt to get lock
			while(atomic_swap(&lock, 1) != 0)
  500017:	85 d2                	test   %edx,%edx
  500019:	75 f1                	jne    50000c <start+0xc>
				continue;
			*cursorpos++ = PRINTCHAR;
  50001b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  500021:	66 c7 02 34 0e       	movw   $0xe34,(%edx)
  500026:	83 c2 02             	add    $0x2,%edx
  500029:	89 15 00 80 19 00    	mov    %edx,0x198000
  50002f:	31 d2                	xor    %edx,%edx
  500031:	87 15 04 80 19 00    	xchg   %edx,0x198004
  500037:	cd 30                	int    $0x30
	
	set_priority(PRIORITY);	// set priority number here
	set_share(SHARE);	// set share number
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
  500039:	40                   	inc    %eax
  50003a:	3d 40 01 00 00       	cmp    $0x140,%eax
  50003f:	75 cb                	jne    50000c <start+0xc>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  500041:	66 31 c0             	xor    %ax,%ax
  500044:	cd 31                	int    $0x31
  500046:	eb fe                	jmp    500046 <start+0x46>
