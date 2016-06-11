SRC = src
BIN = bin
IVERI = iverilog
VERISIM = vvp
WAVE = gtkwave
WAVEFILES = waves

VERIFLAGS = -g2012 -Isrc
SIMFLAGS = 
WAVEFLAGS =

CWD = $(CURDIR)
makefile_dir:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

##### Compilation rules and objects: #####
#__GENMAKE__
BINS = $(BIN)/alu.o \
	$(BIN)/alu_tb.o \
	$(BIN)/core_main.o \
	$(BIN)/counter.o \
	$(BIN)/dff.o 

$(BIN)/alu.o: $(SRC)/alu.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/alu_tb.o: $(SRC)/alu_tb.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/core_main.o: $(SRC)/core_main.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/counter.o: $(SRC)/counter.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/dff.o: $(SRC)/dff.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

#__GENMAKE_END__

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
