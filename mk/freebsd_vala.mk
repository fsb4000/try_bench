VALAC = valac
VALA_FLAGS = -g -v --save-temps
VALA_CFLAGS =  -X -flto -X -fuse-ld=gold                                       \
    -X -O3 -X -fstrict-aliasing -X -funsafe-math-optimizations                 \
    -X -fstack-protector-all -X --param -X ssp-buffer-size=4  -X -fstack-check \
    -X -fsanitize=cfi -X -fvisibility=hidden                                   \
    -X -fPIC -X -fPIE -X -pie -X -Wl,-z,relro,-z,now -X -Wl,-z,noexecstack     \
    -X -Wl,-O1 -X -rdynamic
VALA_CEXCEPTION = -X -Iinclude -X -isystem"3rd" \
    -X -DCEXCEPTION_USE_CONFIG_FILE -X src/c/platform_specific/unix/CExceptionConfig_pthread.c -X 3rd/cexception/CException.c

VALA_CFLAGS += $(VALA_CEXCEPTION)
