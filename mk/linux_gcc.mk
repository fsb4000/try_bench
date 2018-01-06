CCACHE = ccache
CC = $(CCACHE) gcc
CXX = $(CCACHE) g++

WARNINGS = -Wall -Wextra -pedantic -Wstrict-aliasing=2 -Wformat-security        \
    -Wstrict-overflow=5 -Wfloat-equal -Wformat-extra-args -Wshadow -Winit-self  \
    -Wswitch-default -Wformat-nonliteral -Wdouble-promotion -Wstack-protector   \
     -Wdouble-promotion -Wchkp -Wswitch-enum -Wmissing-include-dirs -Wcast-qual \
    -Wconversion -Wpadded -Wwrite-strings -Wcast-align -Wlogical-not-parentheses\
    -Wformat-y2k   -Wlogical-op  -Wsign-conversion -Wredundant-decls
WARNINGS_CXX_ONLY = -Wuseless-cast -Wold-style-cast -Woverloaded-virtual        \
    -Wsuggest-final-methods -Wsuggest-override -Wzero-as-null-pointer-constant  \
    -Wsuggest-final-types -Weffc++
WARNINGS_C_ONLY = -Wbad-function-cast -Winit-self
WARNINGS_FORCE_CXX = -Wno-zero-as-null-pointer-constant -Wno-old-style-cast

LTO = -flto -fno-fat-lto-objects
INCLUDE = -I"include" -isystem"3rd"
SECURITY = -fPIE -fPIC -fstack-protector-all --param ssp-buffer-size=4 -fstack-check -Wa,--noexecstack
DEFINES = -D_FORTIFY_SOURCE=2 -D__STDC_WANT_LIB_EXT1__=1 -D__STDC_WANT_LIB_EXT2__=1 -DCEXCEPTION_USE_CONFIG_FILE
DEBUG = -g3
OPENMP = -fopenmp
OPTIMIZE = -O3 -fstrict-aliasing -funsafe-math-optimizations -ftracer
CSTANDARD = -std=c11
CXXSTANDARD = -std=c++1z
TEST_DEFINES_CXX = -D_GLIBCXX_DEBUG
TEST_DEFINES_C =

SANITIZERS =
LIBS_SANITIZERS =
LIBS_SANITIZERS_32 =
LIBS_SANITIZERS_64 =

CPU_64_FLAG = -m64
CPU_32_FLAG = -m32

LD_LTO = -flto=2 -fno-fat-lto-objects -fuse-linker-plugin
LD_INCLUDE =
LD_SECURITY = -pie -Wl,-z,relro,-z,now -Wl,-z,noexecstack
LD_SYSTEM = -Wl,-O1 -rdynamic

LIBS_OPENMP = -fopenmp
LIBS_SYSTEM_C = -lm 
LIBS_SYSTEM_CXX = -lstdc++fs
LIBS_THREAD =  -pthread -Wl,--no-as-needed -lpthread
LIBS_3RD_C =
LIBS_3RD_CXX =

FLAGS = $(OPTIMIZE) $(WARNINGS) $(INCLUDE) $(LTO) $(DEFINES) $(OPENMP) $(SECURITY) $(DEBUG)
CFLAGS = $(CSTANDARD) $(FLAGS) $(WARNINGS_C_ONLY)
LDFLAGS_C = $(LD_INCLUDE) $(LD_SECURITY) $(LD_LTO) $(LD_SYSTEM)
LIBS_C = $(LIBS_3RD_C) $(LIBS_OPENMP) $(LIBS_SYSTEM_C) $(LIBS_THREAD)

CXXFLAGS = $(CXXSTANDARD) $(FLAGS) $(WARNINGS_CXX_ONLY)
LDFLAGS_CXX = $(LDFLAGS_C)
LIBS_CXX = $(LIBS_3RD_CXX) $(LIBS_OPENMP) $(LIBS_SYSTEM_CXX) $(LIBS_THREAD)
