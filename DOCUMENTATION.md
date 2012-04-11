0x42c Kernel Documentation
===


FAQ
-
 * How do I use the 0x42c Kernel?

 First include the kernel jump table in your source code by using the assembler directive `.include "kern_jumptable.dasm16"`. For this to work you need to ensure the kernel jumptable file is in the same directory as your source file. 

 Then, when you want to use a kernel routine, set the appropriate registers to the parameters using the overview below and run the __JSR__ instruction (jump to sub-routine), passing the address of the desired routine from the jump table. For example:

 `:hello dat "Hello, World!", 0`<br />
 `set a, hello `<br />
 `jsr [kern_printnl]`

 * It won't assemble!

 Make sure you're using [noname22's assembler](https://github.com/noname22/dtools/)

[0x002] kern_return 
-

[0x003] kern_strcmp
-
Compares two strings, sets A to 0 if they are equivalent
>`A | The first string`

>`B | The second string`

[0x005] kern_startswith
-
Checks whether the first string starts with the second string, sets Y to 0 if it does.
>`A | The first string`

>`B | The second string`

[0x007] kern_strlen
-
Sets A to the length of the given string
>`A | The string to check the length of`

[0x009] kern_strcat
-
Concatenates two strings

[0x00B] kern_print
-
Prints a string
>`A | String to print`

[0x00D] kern_printnl
-
Prints a string followed by a new line
>`A | String to print`


[0x00F] kern_printchar
-
Prints a character

>`A | Character to print`

[0x011] kern_newline
-
Prints a new line

[0x013] kern_scroll
-

[0x015] kern_clear
-

[0x017] kern_vidmem
-

[0x018] kern_backspace
-

[0x01A] kern_memcpy
-

[0x01C] kern_reserve
-

[0x01E] kern_malloc
-

[0x020] kern_memset
-