#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif

#ifndef PRIORITY
#define PRIORITY 6
#endif

#ifndef SHARE
#define SHARE 10
#endif

// UNCOMMENT THE NEXT LINE TO USE EXERCISE 8 CODE INSTEAD OF EXERCISE 6
// #define __EXERCISE_8__

// Use the following structure to choose between them:
// #infdef __EXERCISE_8__
// (exercise 6 code)
// #else
// (exercise 8 code)
// #endif


void
start(void)
{
	int i;
	
	set_priority(PRIORITY);	// set priority number here
	set_share(SHARE);	// set share number
	sys_yield();

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		//*cursorpos++ = PRINTCHAR;
		#ifdef __EXERCISE_8__
			// extra credit exercise 8
			// attempt to get lock
			while(atomic_swap(&lock, 1) != 0)
				continue;
			*cursorpos++ = PRINTCHAR;
		
			// release lock
			atomic_swap(&lock, 0);
			
		#else
			sys_print(PRINTCHAR);
	
		#endif
		sys_yield();
	}

	// exit instead of yielding forever
	sys_exit(0);
}
