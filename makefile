VALGRIND ?= 0

OBJ_CEXCEPTION = 3rd/cexception/CException.o

OBJ_PLATFORM_SPECIFIC_C =

OBJ_SOLUTION_VALA = src/vala/main.vala

OBJ_BENCH = bench/main.o bench/try.o                                                                                                                      \
                                                                                                                                                          \
            $(OBJ_CEXCEPTION)                                                                                                                             \
                                                                                                                                                          \
            $(OBJ_PLATFORM_SPECIFIC_C)

include mk/detect_os.mk

ifeq ($(findstring MINGW, $(PLATFORM)), MINGW)
    include mk/mingw.mk
    include mk/mingw_gcc.mk
    include mk/mingw_vala.mk

    OBJ_PLATFORM_SPECIFIC_C = src/c/platform_specific/windows/CExceptionConfig_win.o
endif

ifeq ($(findstring Windows, $(PLATFORM)),Windows)
    include mk/windows.mk
    include mk/windows_gcc.mk
    include mk/windows_vala.mk

    OBJ_PLATFORM_SPECIFIC_C = src/c/platform_specific/windows/CExceptionConfig_win.o
endif

ifeq ($(findstring Linux,$(PLATFORM)),Linux)
    include mk/linux.mk
    include mk/linux_gcc.mk
    include mk/linux_vala.mk

    OBJ_PLATFORM_SPECIFIC_C = src/c/platform_specific/unix/CExceptionConfig_pthread.o
endif

ifeq ($(findstring FreeBSD,$(PLATFORM)),FreeBSD)
    include mk/freebsd.mk
    include mk/freebsd_clang.mk
    include mk/freebsd_vala.mk

    OBJ_PLATFORM_SPECIFIC_C = src/c/platform_specific/unix/CExceptionConfig_pthread.o
endif

include mk/optional_ccache.mk
include mk/choose_sanitizers_libs.mk
include mk/disable_sanitizers_if_enabled_valgrind.mk

all: bench nodius_bench

solution_vala: $(OBJ_SOLUTION_VALA)
	$(VALAC) -o bin/$@ $^ $(VALA_FLAGS) $(VALA_CFLAGS)

bench: CXXFLAGS += -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fpermissive
bench: $(OBJ_BENCH)
	$(CXX) -o bin/$@ $^ $(LDFLAGS) $(LIBS_CXX) $(LIBS_3RD_C) -lgobject-2.0 -lglib-2.0

nodius_bench: bench/try_nonius.o
	$(CXX) -o bin/$@ $^ $(LDFLAGS) $(LIBS_CXX) $(LIBS_3RD_C)

clean:
	$(RM_REC_START) "*.o" $(RM_REC_END)
	$(RM_REC_START) "*.orig" $(RM_REC_END)
	$(RM) "bin$(SLASH)solution_vala$(EXEEXT)"
	$(RM) "bin$(SLASH)bench$(EXEEXT)"

