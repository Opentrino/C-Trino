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
BINS = $(BIN)/chip_die.o \
	$(BIN)/execution_stage.o \
	$(BIN)/fetch_stage.o \
	$(BIN)/integer.o \
	$(BIN)/integer_tb.o \
	$(BIN)/l1_dcache.o \
	$(BIN)/l1_icache.o \
	$(BIN)/l2_cache.o \
	$(BIN)/l3_cache.o \
	$(BIN)/memory.o \
	$(BIN)/memory_access_stage.o \
	$(BIN)/microcode.o \
	$(BIN)/predecode_stage.o \
	$(BIN)/register_file.o \
	$(BIN)/subcore.o \
	$(BIN)/top.o \
	$(BIN)/top_tb.o \
	$(BIN)/uncore.o 

$(BIN)/chip_die.o: $(SRC)/chip_die.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/execution_stage.o: $(SRC)/execution_stage.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/fetch_stage.o: $(SRC)/fetch_stage.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/integer.o: $(SRC)/integer.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/integer_tb.o: $(SRC)/integer_tb.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/l1_dcache.o: $(SRC)/l1_dcache.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/l1_icache.o: $(SRC)/l1_icache.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/l2_cache.o: $(SRC)/l2_cache.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/l3_cache.o: $(SRC)/l3_cache.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/memory.o: $(SRC)/memory.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/memory_access_stage.o: $(SRC)/memory_access_stage.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/microcode.o: $(SRC)/microcode.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/predecode_stage.o: $(SRC)/predecode_stage.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/register_file.o: $(SRC)/register_file.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/subcore.o: $(SRC)/subcore.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/top.o: $(SRC)/top.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/top_tb.o: $(SRC)/top_tb.sv
	$(IVERI) -o $@ $(VERIFLAGS) $^

$(BIN)/uncore.o: $(SRC)/uncore.sv
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