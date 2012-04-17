FAQ
----
    * How do I use the 0x42c Kernel?

    First include the kernel jump table in your source code by using the assembler directive ``.include "kern_jumptable.dasm16"``. For this to work you need to ensure the kernel jumptable file is in the same directory as your source file. 

    Then, when you want to use a kernel routine, set the appropriate registers to the parameters using the overview below and run the __JSR__ instruction (jump to sub-routine), passing the address of the desired routine from the jump table. For example:

     .. code-block:: none
     
        hello dat "Hello, World!", 0`
        set a, hello`
        jsr [kern_printnl]

    * It won't assemble!

     Make sure you're using `noname22's assembler <https://github.com/noname22/dtools/>`_
