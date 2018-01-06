ifeq ($(OS),Windows_NT)
    PLATFORM := $(shell uname 2>NUL; false)
    ifeq ($(findstring MINGW,$(PLATFORM)),MINGW)
	DEL_NUL := $(shell rm -f NUL; false)
        ifeq ($(findstring MINGW64,$(PLATFORM)),MINGW64)
            BITS = "64"
        else
            BITS = "32"
        endif
    else
        PLATFORM = "Windows"
	    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
            	BITS = "64"
	    else
            ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
	    	BITS = "64"
            endif
            ifeq ($(PROCESSOR_ARCHITECTURE),x86)
	    	BITS = "32"
            endif
        endif
    endif	
else
	PLATFORM = $(shell uname)
	BITS = $(shell getconf LONG_BIT)
endif
