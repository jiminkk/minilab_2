
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
set_priority(unsigned int priority)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_PRIORITY.
	asm volatile("int %0\n"
  200000:	b8 06 00 00 00       	mov    $0x6,%eax
  200005:	cd 32                	int    $0x32
set_share(unsigned int share)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_SHARE.
	asm volatile("int %0\n"
  200007:	b0 0a                	mov    $0xa,%al
  200009:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  20000b:	cd 30                	int    $0x30
  20000d:	30 c0                	xor    %al,%al
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  20000f:	ba 01 00 00 00       	mov    $0x1,%edx
  200014:	87 15 04 80 19 00    	xchg   %edx,0x198004
		// Write characters to the console, yielding after each one.
		//*cursorpos++ = PRINTCHAR;
		#ifdef __EXERCISE_8__
			// extra credit exercise 8
			// attempt to get lock
			while(atomic_swap(&lock, 1) != 0)
  20001a:	85 d2                	test   %edx,%edx
  20001c:	75 f1                	jne    20000f <start+0xf>
				continue;
			*cursorpos++ = PRINTCHAR;
  20001e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  200024:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  200029:	83 c2 02             	add    $0x2,%edx
  20002c:	89 15 00 80 19 00    	mov    %edx,0x198000
  200032:	31 d2                	xor    %edx,%edx
  200034:	87 15 04 80 19 00    	xchg   %edx,0x198004
  20003a:	cd 30                	int    $0x30
	
	set_priority(PRIORITY);	// set priority number here
	set_share(SHARE);	// set share number
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
  20003c:	40                   	inc    %eax
  20003d:	3d 40 01 00 00       	cmp    $0x140,%eax
  200042:	75 cb                	jne    20000f <start+0xf>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200044:	66 31 c0             	xor    %ax,%ax
  200047:	cd 31                	int    $0x31
  200049:	eb fe                	jmp    200049 <start+0x49>
