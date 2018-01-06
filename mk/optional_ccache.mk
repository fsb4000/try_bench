CCACHE_VER := $(shell $(CCACHE) -V 2>$(NULL); false)
ifeq ($(CCACHE_VER),)
	CCACHE =
endif
