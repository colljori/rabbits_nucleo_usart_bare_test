# This file is part of not much, if not nothing
# Copyright (C) 2017  Frédéric Pétrot
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

# Minimal makefile to produce a simple cortex-m4 test
# Assume binutils-arm-none-eabi package installed (debian name)
CROSS_COMPILE=arm-none-eabi-
CC=$(CROSS_COMPILE)gcc
AS=$(CROSS_COMPILE)as
LD=$(CROSS_COMPILE)ld
OC=$(CROSS_COMPILE)objcopy
OD=$(CROSS_COMPILE)objdump

test.bin : test.elf
	$(OC) -O binary $^ $@
test.dis : test.elf
	$(OD) -d $^ > $@
test.elf : ldscript.ld start.o vectors.o
	$(LD) -T $< $(filter-out $<,$^) -o $@
start.o : start.c
	$(CC) -mcpu=cortex-m4 -mthumb -g -c $<
vectors.o : vectors.s
	$(AS) -mcpu=cortex-m4 -mthumb -g $< -o $@
clean :
	$(RM) vectors.o start.o
realclean: clean
	$(RM) test.dis test.elf test.bin
