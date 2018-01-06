CCACHE = ccache
CC = $(CCACHE) gcc
CXX = $(CCACHE) g++
AR = ar rcs

WARNINGS = -Wall -Wextra -pedantic -Wstrict-aliasing=2 -Wformat-security      \
    -Wstrict-overflow=5 -Wfloat-equal -Wformat-extra-args -Wshadow -Winit-self\
    -Wswitch-default -Wformat-nonliteral -Wdouble-promotion -Wnull-dereference\
    -Walloca -Wdouble-promotion -Wduplicated-branches -Wduplicated-cond       \
    -Wconversion -Wpadded -Wlogical-not-parentheses -Walloc-zero -Wcast-qual  \
    -Wformat-y2k -Wcast-align -Wlogical-op -Wwrite-strings -Wsign-conversion  \
    -Wredundant-decls -Wmissing-include-dirs -Wswitch-enum -Wstack-protector  \
    -Wunused-const-variable=2
WARNINGS_CXX_ONLY = -Wuseless-cast -Wold-style-cast -Woverloaded-virtual      \
    -Wsuggest-final-methods -Wsuggest-override -Wzero-as-null-pointer-constant\
    -Wsuggest-final-types -Weffc++ -Wsubobject-linkage
WARNINGS_C_ONLY = -Wbad-function-cast -Winit-self -Wno-clobbered
WARNINGS_FORCE_CXX = -Wno-zero-as-null-pointer-constant -Wno-old-style-cast

LTO = -flto-partition=none -flto -ffat-lto-objects
INCLUDE = -I"include" -isystem"3rd"
SECURITY = -fPIC -fstack-protector-all --param ssp-buffer-size=4 -fstack-check
SECURITY_CXX = -fvtable-verify=std
DEFINES = -D__STDC_WANT_LIB_EXT1__=1 -D__STDC_WANT_LIB_EXT2__=1               \
    -DDEFINE_CONSOLEV2_PROPERTIES -DWIN32_LEAN_AND_MEAN                       \
    -DCEXCEPTION_USE_CONFIG_FILE
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

LD_LTO = -flto-partition=none -flto -ffat-lto-objects
LD_INCLUDE =
LD_SECURITY = -Wl,--dynamicbase -Wl,--nxcompat
ifeq ($(findstring 64,$(BITS)),64)
	LD_SECURITY += -Wl,--high-entropy-va
endif
LD_SYSTEM = -Wl,-subsystem,console -Wl,-O1

LIBS_OPENMP = -fopenmp
LIBS_SYSTEM_C = -lm -lssp
LIBS_SYSTEM_CXX = -lssp
LIBS_THREAD =  -pthread -Wl,--no-as-needed -lpthread
LIBS_3RD_C =
LIBS_3RD_CXX =

FLAGS = $(OPTIMIZE) $(WARNINGS) $(INCLUDE) $(LTO) $(DEFINES) $(OPENMP) $(SECURITY) $(DEBUG)
CFLAGS = $(CSTANDARD) $(FLAGS) $(WARNINGS_C_ONLY)
LDFLAGS_C = $(LD_INCLUDE) $(LD_SECURITY) $(LD_LTO) $(LD_SYSTEM)
LIBS_C = $(LIBS_3RD_C) $(LIBS_OPENMP) $(LIBS_SYSTEM_C) $(LIBS_THREAD)

CXXFLAGS = $(CXXSTANDARD) $(FLAGS) $(WARNINGS_CXX_ONLY) $(SECURITY_CXX)
LDFLAGS_CXX = $(LDFLAGS_C)
LIBS_CXX = $(LIBS_3RD_CXX) $(LIBS_OPENMP) $(LIBS_SYSTEM_CXX) $(LIBS_THREAD)
