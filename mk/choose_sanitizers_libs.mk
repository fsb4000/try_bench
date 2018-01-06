ifeq ($(findstring 64,$(BITS)),64)
	LIBS_SANITIZERS = $(LIBS_SANITIZERS_64)
endif

ifeq ($(findstring 32,$(BITS)),32)
	LIBS_SANITIZERS = $(LIBS_SANITIZERS_32)
endif
