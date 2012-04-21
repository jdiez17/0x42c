cmake_minimum_required (VERSION 2.6)
project(kernel)

# Check to see if we are being built as part of
# DCPU-Toolchain or whether this is being built
# on it's own.
if(NOT DEFINED IS_ROOT)
  # We need to define a CMakeLists.standalone.txt file for
  # this to work; at the moment it simply errors.
  #include(CMakeLists.standalone.txt NO_POLICY_SCOPE)
  message(FATAL_ERROR "The CMake generation can't currently generate 0x42c standalone.")
endif(NOT DEFINED IS_ROOT)

# Define the working directory for tools.
set(KERNEL_TOOLS ${OUTPUT_DIR})
set(KERNEL_SRC ${ROOT_DIR}/kernel/src)

# Define function to specify a kernel target.
function(add_dcpu_image target)
	set(outputs "")

	# Define a general function that allows us to
	# define tools and their handling of files.
	function(define_dcpu_tool tool toolargs verb files)
		foreach(arg ${ARGN})
			set(UARGN "${UARGN} ${arg}")
		endforeach(arg ${ARGN})
		message("    .. defining tool ${tool} ${toolargs} with '${files}'")
		message("       recognising ${UARGN}")
		foreach(i ${files})
			get_filename_component(fext "${i}" EXT)
			get_filename_component(fpth "${i}" PATH)
			get_filename_component(fbse "${i}" NAME_WE)
			string(TOLOWER "${fext}" fextc)
			message("       .. scanning ${i}")
			message("          extension: ${fext}")
			set(extension_matches false)
			foreach(e ${ARGN})
				message("          .. checking ${e}")
				if("${fext}" STREQUAL "${e}")
					message("             (extension matches)")
					set(extension_matches true)
				endif("${fext}" STREQUAL "${e}")
			endforeach(e ${ARGN})
			if(${extension_matches} STREQUAL "true")
				message("       .. adding command")
				message("          output: ${fpth}/${fbse}.o")
				message("          command: ${KERNEL_TOOLS}/${tool}${CMAKE_EXECUTABLE_SUFFIX} ${toolargs} -o \"${fpth}/${fbse}.o\" \"${i}\"")
				message("          depends: ${tool}")
				add_custom_command(
					OUTPUT ${fpth}/${fbse}.o
					COMMAND ${KERNEL_TOOLS}/${tool}${CMAKE_EXECUTABLE_SUFFIX}
						ARGS ${toolargs} -o "${fpth}/${fbse}.o" "${i}" 2>>./CMakeFiles/dcpu-${tool}-log
					DEPENDS ${tool}
					COMMENT "${verb} ${fbse}${fext} with DCPU-Toolchain...")
				if("${outputs}" STREQUAL "")
					set(outputs "${fpth}/${fbse}.o" PARENT_SCOPE)
				else("${outputs}" STREQUAL "")
					set(outputs "${outputs} ${fpth}/${fbse}.o" PARENT_SCOPE)
				endif("${outputs}" STREQUAL "")
			endif(${extension_matches} STREQUAL "true")
		endforeach(i ${files})
	endfunction(define_dcpu_tool tool toolargs files)
	
	message("  >> ${target}")

	# Define each of the tools using the files list.
	define_dcpu_tool(assembler "-i" "Assembling" "${ARGN}" ".dasm" ".dasm16")
	define_dcpu_tool(compiler "" "Compiling" "${ARGN}" ".c")

	# Define our target.
	add_custom_target(${target} ALL DEPENDS ${outputs})

endfunction(add_dcpu_image target)

# Define the kernel.
add_dcpu_image(kernel
	src/openf.dasm16
	src/echof.dasm16
	src/cleanf.dasm16
	src/aperture.dasm16
#	src/0x42c.dasm16
#	src/kernel.dasm16
)

# We still need to rely on the rest of the DCPU-Toolchain
# suite being having built at this point.
dt_needs_exe(compiler)
dt_needs_exe(assembler)
dt_needs_exe(linker)