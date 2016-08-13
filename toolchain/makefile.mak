SRC = src
BIN = bin
IVERI = iverilog
VERISIM = vvp
WAVE = gtkwave
WAVESPATH = waves

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
	$(BIN)/fetch_stage.o \
	$(BIN)/l1_dcache.o \
	$(BIN)/l1_icache.o \
	$(BIN)/l2_cache.o \
	$(BIN)/memory.o \
	$(BIN)/microcode.o \
	$(BIN)/pipeline.o \
	$(BIN)/top.o \
	$(BIN)/top_tb.o 

$(BIN)/alu.o: $(SRC)/alu.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/alu_tb.o: $(SRC)/alu_tb.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/core_main.o: $(SRC)/core_main.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/fetch_stage.o: $(SRC)/fetch_stage.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/l1_dcache.o: $(SRC)/l1_dcache.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/l1_icache.o: $(SRC)/l1_icache.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/l2_cache.o: $(SRC)/l2_cache.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/memory.o: $(SRC)/memory.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/microcode.o: $(SRC)/microcode.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/pipeline.o: $(SRC)/pipeline.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/top.o: $(SRC)/top.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/top_tb.o: $(SRC)/top_tb.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

#__GENMAKE_END__

##### Main rules:
# Compile:
all: $(BINS)
	@printf "Finished!\n"

# Simulate:
%:
	@cd $(WAVESPATH) && $(VERISIM) ../$(BIN)/$(basename $@).o
	
# GTKWave:
w%:
	$(WAVE) $(WAVESPATH)/$(basename $(@:w%=%)).vcd

clean:
	$(RM) $(BIN)/*

clean_waves:
	$(RM) $(WAVESPATH)/*