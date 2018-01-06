CCACHE = ccache
CC = $(CCACHE) clang50
CXX = $(CCACHE) clang++50

WARNINGS = -Weverything 
WARNINGS_CXX_ONLY = -Wno-c++98-compat
WARNINGS_C_ONLY = 
WARNINGS_FORCE_CXX = -Wno-deprecated -Wno-old-style-cast

INCLUDE = -I"include" -isystem"3rd" -isystem"/usr/local/include"
LTO = -flto
SECURITY = -fPIE -fPIC -fstack-protector-all --param ssp-buffer-size=4 -fstack-check -fsanitize=cfi -fvisibility=hidden
DEFINES = -D__STDC_WANT_LIB_EXT1__=1 -D__STDC_WANT_LIB_EXT2__=1 -DCEXCEPTION_USE_CONFIG_FILE
DEBUG = -g3
OPENMP = -fopenmp
OPTIMIZE = -O3 -fstrict-aliasing -funsafe-math-optimizations -fwhole-program-vtables
CSTANDARD = -std=c11
CXXSTANDARD = -std=c++1z
TEST_DEFINES_CXX = -D_LIBCXX_DEBUG=1
TEST_DEFINES_C =

SANITIZERS = #-fsanitize=address -fsanitize=undefined -fno-omit-frame-pointer
LIBS_SANITIZERS =
LIBS_SANITIZERS_32 = #/usr/local/llvm50/lib/clang/5.0.0/lib/freebsd/libclang_rt.ubsan_standalone_cxx-i386.a /usr/local/llvm50/lib/clang/5.0.0/lib/freebsd/libclang_rt.asan-i386.a
LIBS_SANITIZERS_64 = #/usr/local/llvm50/lib/clang/5.0.0/lib/freebsd/libclang_rt.ubsan_standalone_cxx-x86_64.a /usr/local/llvm50/lib/clang/5.0.0/lib/freebsd/libclang_rt.asan-x86_64.a

CPU_64_FLAG = -m64
CPU_32_FLAG = -m32

LD_LTO = -flto -fuse-ld=gold
LD_INCLUDE = -L"/usr/local/lib"
LD_SECURITY = -pie -Wl,-z,relro,-z,now -Wl,-z,noexecstack
LD_SYSTEM =

LIBS_OPENMP = -fopenmp=libiomp5
LIBS_SYSTEM_C =
LIBS_SYSTEM_CXX =
LIBS_THREAD = -pthread
LIBS_3RD_C =
LIBS_3RD_CXX =

FLAGS = $(OPTIMIZE) $(WARNINGS) $(INCLUDE) $(LTO) $(DEFINES) $(OPENMP) $(SECURITY) $(DEBUG)
CFLAGS = $(CSTANDARD) $(FLAGS) $(WARNINGS_C_ONLY)
LDFLAGS_C = $(LD_INCLUDE) $(LD_SECURITY) $(LD_LTO) $(LD_SYSTEM)
LIBS_C = $(LIBS_3RD_C) $(LIBS_OPENMP) $(LIBS_SYSTEM_C) $(LIBS_THREAD)

CXXFLAGS = $(CXXSTANDARD) $(FLAGS) $(WARNINGS_CXX_ONLY)
LDFLAGS_CXX = $(LDFLAGS_C)
LIBS_CXX = $(LIBS_3RD_CXX) $(LIBS_OPENMP) $(LIBS_SYSTEM_CXX) $(LIBS_THREAD)
