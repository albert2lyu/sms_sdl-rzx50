
# Makefile for sms+sdl
#
# Copyright (C) 1998, 1999, 2000  Charles Mac Donald
# SDL version by Gregory Montoir <cyx@frenchkiss.net>
#
# Defines :
# LSB_FIRST : for little endian systems.
# X86_ASM   : enable x86 assembly optimizations
# USE_ZLIB  : enable ZIP file support

NAME	  = sms_sdl.dge
CC        = mipsel-linux-gcc
CFLAGS    = -O3 -march=mips32 -mtune=r4600 -fomit-frame-pointer -ffast-math -msoft-float
DEFINES   = -DLSB_FIRST -DALIGN_DWORD
INCLUDES  = -I. -Ibase -Icpu -Isound
LIBS	  = -s -lSDL -lz

OBJECTS   = main.o saves.o sdlsms.o \
            base/render.o base/sms.o base/system.o base/vdp.o \
            cpu/z80.o sound/emu2413.o sound/sn76496.o scaler.o

# (un)comment to enable ZIP support
DEFINES  += -DUSE_ZLIB
#LIBS     += -Lz
OBJECTS  += unzip.o


all: $(NAME)

$(NAME): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o bin/$@

.c.o:
	$(CC) -c $(CFLAGS) $(INCLUDES) $(DEFINES) $< -o $@

clean:
	rm -f $(OBJECTS) bin/$(NAME)
