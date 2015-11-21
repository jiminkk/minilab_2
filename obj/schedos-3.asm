
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
set_priority(unsigned int priority)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_PRIORITY.
	asm volatile("int %0\n"
  400000:	b8 03 00 00 00       	mov    $0x3,%eax
  400005:	cd 32                	int    $0x32
set_share(unsigned int share)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_SHARE.
	asm volatile("int %0\n"
  400007:	b0 01                	mov    $0x1,%al
  400009:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  40000b:	cd 30                	int    $0x30
  40000d:	31 d2                	xor    %edx,%edx
sys_print(unsigned int character)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_SET_SHARE.
	asm volatile("int %0\n"
  40000f:	66 b8 33 09          	mov    $0x933,%ax
  400013:	cd 34                	int    $0x34
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400015:	cd 30                	int    $0x30
	
	set_priority(PRIORITY);	// set priority number here
	set_share(SHARE);	// set share number
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
  400017:	42                   	inc    %edx
  400018:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  40001e:	75 f3                	jne    400013 <start+0x13>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400020:	31 c0                	xor    %eax,%eax
  400022:	cd 31                	int    $0x31
  400024:	eb fe                	jmp    400024 <start+0x24>
