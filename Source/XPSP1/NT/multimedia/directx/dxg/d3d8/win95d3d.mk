PLAT_DIR = win9x
ALT_PROJECT_TARGET=Win9x

!include bldd3d.mk

USE_MAPSYM=1

C_DEFINES = $(C_DEFINES) \
	-DWIN95

UMTYPE = windows
