SRC = src
BIN = bin
IVERI = iverilog
VERISIM = vvp
WAVE = gtkwave
WAVEFILES = waves

VERIFLAGS = -g2012
SIMFLAGS = 
WAVEFLAGS =

CWD = $(CURDIR)
makefile_dir:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

##### Compilation rules:
$(BIN)/core_main.o: $(SRC)/core_main.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

###### Objects:
BINS = $(BIN)/core_main.o

##### Main rules:
# Compile:
all: $(BINS)
	@printf "Finished!\n"

# Simulate:
%:
	@cd $(WAVEFILES) && $(VERISIM) $(CWD)/$(BIN)/$(basename $@).o
	
# GTKWave:
w%:
	$(WAVE) $(WAVEFILES)/$(basename $(@:w%=%)).vcd

clean:
	$(RM) $(BIN)/*
