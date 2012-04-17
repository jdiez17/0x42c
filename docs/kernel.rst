Kernel functions
----------------

[0x002] kern_return
=================== 

.. warning::
    
    Deprecated.

[0x003] kern_strcmp
===================
Compares two strings, sets A to 0 if they are equivalent

Input:

========    =======
Input       Description
========    =======
A           The first string
B           The second string
========    =======

Output:

========    =======
Output      Condition
========    =======
0           A === B
<> 0        A != B
========    =======

[0x005] kern_startswith
=======================

Checks whether the first string starts with the second string, sets Y to 0 if it does.

Input:

========    =======
Input       Description
========    =======
A           The first string
B           The second string
========    =======

Output:

========    =======
Output      Condition
========    =======
0           A starts with B
<> 0        A does not start with B
========    =======

[0x007] kern_strlen
===================


Sets A to the length of the given string

Input:

========    =======
Input       Description
========    =======
A           The first string
========    =======

Output:

========    =======
Output      Condition
========    =======
n           The length of zero-terminated string A
========    =======


[0x009] kern_strcat
===================
Concatenates two strings

Input:

========    =======
Input       Description
========    =======
A           The first string
B           The second string
========    =======

Output:

========    =======
Output      Condition
========    =======
pointer     --           
========    =======

.. note:: 

    strcat currently only appends one character.

[0x00B] kern_print
==================
Prints a string

Input:

========    =======
Input       Description
========    =======
A           The string
========    =======


[0x00D] kern_printnl
====================
Prints a string followed by a new line

========    =======
Input       Description
========    =======
A           The string
========    =======

[0x00F] kern_printchar
======================
Prints a character

========    =======
Input       Description
========    =======
A           The character
========    =======

[0x011] kern_newline
====================
Prints a new line

[0x013] kern_scroll
===================
Scrolls the screen one line up.

[0x015] kern_clear
==================
Clears the screen.

[0x017] kern_vidmem
===================
.. warning::
    
    Deprecated.

[0x018] kern_backspace
======================
.. warning::
    
    Deprecated.

[0x01A] kern_memcpy
===================
Copies n words from dst to src.

Input:

========    =======
Input       Description
========    =======
A           The destination address
B           The source address
C           The number of words to copy
========    =======

.. note::
    
    It does not do error checking. Yet.

[0x01C] kern_reserve
====================

.. warning::
    Deprecated.

[0x01E] kern_malloc
===================

Returns a pointer with n words of free space ahead of it.

Input:

========    =======
Input       Description
========    =======
A           The owner of the memory to be allocated.
B           The number of words requested.
========    =======

Output:

========    =======
Output      Condition
========    =======
pointer     --           
========    =======

[0x020] kern_memset
===================
Sets n words of dst to a constant word.

Input:

========    =======
Input       Description
========    =======
A           The destination address
B           The word that will fill the destination address.
C           The number of words to fill
========    =======

[0x022] kern_free
=================

Sets free a memory block, and attempts free-block merges.

Input:

========    =======
Input       Description
========    =======
A           Pointer to the memory to be freed
========    =======

[0x01E] kern_readline
=====================

Reads a line (sequence of characters ended by a newline, not included).

Input:

========    =======
Input       Description
========    =======
A           The buffer in which the line should be copied.
========    =======

.. note::
    
    You will need to allocate the buffer yourself. Example:
    
    .. code-block:: none
    
        set a, 0x42c
        set b, 32
        jsr [kern_malloc] ; buffer gets passed to readline as an argument
        jsr [kern_readline]
