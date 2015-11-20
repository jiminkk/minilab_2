
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
set_priority(unsigned int priority)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_PRIORITY.
	asm volatile("int %0\n"
  300000:	b8 03 00 00 00       	mov    $0x3,%eax
  300005:	cd 32                	int    $0x32
set_share(unsigned int share)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_SHARE.
	asm volatile("int %0\n"
  300007:	b0 01                	mov    $0x1,%al
  300009:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  30000b:	cd 30                	int    $0x30
  30000d:	30 c0                	xor    %al,%al
	set_share(SHARE);	// set share number
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  30000f:	8b 15 00 80 19 00    	mov    0x198000,%edx
  300015:	66 c7 02 32 0a       	movw   $0xa32,(%edx)
  30001a:	83 c2 02             	add    $0x2,%edx
  30001d:	89 15 00 80 19 00    	mov    %edx,0x198000
  300023:	cd 30                	int    $0x30
	
	set_priority(PRIORITY);	// set priority number here
	set_share(SHARE);	// set share number
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
  300025:	40                   	inc    %eax
  300026:	3d 40 01 00 00       	cmp    $0x140,%eax
  30002b:	75 e2                	jne    30000f <start+0xf>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  30002d:	66 31 c0             	xor    %ax,%ax
  300030:	cd 31                	int    $0x31
  300032:	eb fe                	jmp    300032 <start+0x32>
