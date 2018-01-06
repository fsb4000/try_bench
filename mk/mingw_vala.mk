VALAC = valac
VALA_FLAGS = -g -v --save-temps
VALA_CFLAGS =  -X -flto-partition=none -X -flto -X -ffat-lto-objects           \
    -X -O3 -X -ftracer -X -fstrict-aliasing -X -funsafe-math-optimizations     \
    -X -fstack-protector-all -X --param -X ssp-buffer-size=4  -X -fstack-check \
    -X "-Wl,--dynamicbase" -X "-Wl,--nxcompat" -X "-Wl,-subsystem,console"     \
    -X -Wl,-O1
ifeq ($(findstring 64,$(BITS)),64)
	VALA_CFLAGS += -X "-Wl,--high-entropy-va"
endif
VALA_CEXCEPTION = -X -Iinclude -X -isystem"3rd" \
    -X -DCEXCEPTION_USE_CONFIG_FILE -X src/c/platform_specific/windows/CExceptionConfig_win.c -X 3rd/cexception/CException.c

VALA_CFLAGS += $(VALA_CEXCEPTION)
