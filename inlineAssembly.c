#include <stdio.h>
// Program tests assembly in C by changing and reading the value of a register
// By: Stacy Hudman

int main()
{
   
   // Initialize value of int regVal and afterVal
   int regVal = 0;
   int afterVal = 0;
   
   // Load eax value into regVal
   asm("\t movl %%eax,%0" : "=r"(regVal));
   
   //Insert

   // Load eax value into afterVal
   asm("\t movl %%eax,%0" : "=r"(afterVal));

   // If value of eax changed by one, exit 0, else exit 1
   if ((afterVal + 1 == regVal) || (afterVal == regVal + 1))
      return 0;
   
   return 1;
} 
