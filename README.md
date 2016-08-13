# Citrino - The Microprocessor
Citrino is the name of the Microprocessor that is currently under development for the goal project Opentrino. 
Each sub project is independent and will be developed separately.

# Design
The design of the Microprocessor is currently being done [on this page](https://github.com/Opentrino/Opentrino-Design/tree/master/CitrinoDesign).
All the technical details can be found there.

# How to install
The required packages before installation are:

- **If you are on Windows:**  
1- Python (for scripting)  
2- MinGW (packages: make, scripting commands, etc...)  
3- Icarus Verilog (for compilation and simulation)  
4- GTKWave (for waveform analysis)  

- **If you are on Linux:**  
1- Python (for scripting)  
2- Icarus Verilog (for compilation and simulation)  
3- GTKWave (for waveform analysis)  

Then, just simply **fork** this project into any location on your computer.

If you wish to run this project on a real FPGA, simply install the proprietary software for that particular FPGA.
So far, this project has support for the following FPGAs:
>1- **Altera** (Quartus II / Quartus Prime)  
>1.1- Cyclone IV  
>1.1.1- EP4CE10E22C8  
>2- **Xilinx**  
>2.1- No support **for now**  

# How to run and use
There are two main ways to develop this project:  
1- Develop systemverilog code and **simulate** with Icarus  
2- Develop systemverilog code and **synthesize** for FPGAs with Quartus  

- In the case of option 1, it is recommended the use of an actual IDE, such as Eclipse IDE. There is a project already prepared with a build system in place. Alternatively, you can just run the Windows/Linux scripts, but please note you need to respect the command-line arguments for these scripts.  
The scripts that can be found inside the folder 'toolchain/< YourOS >' (which work for both Windows and Linux) are:
> 1- **build**- Just compiles the project with Icarus. No synthesization will occur.  
> 2- **build_run** - Compiles and simulates with Icarus.  
> 3- **build_run_wave** - Compiles, simulates and opens GTKWave for a particular systemverilog file, which should be targetted via the command-line's arguments. **NOTE**: Please note that if you wish to use ModelSim instead of GTKWave, please feel free to do so.  
> 4- **clean** - Remove built (object files) systemverilog files from the 'bin' folder.  
> 5- **clean_waves** - Remove wave files (which are present in the folder 'waves').  
> 6- **rebuild** - Cleans, updates the makefile object list and builds the project.  
> 7- **rebuild_run** - Rebuilds and simulates with Icarus.  
> 8- **rebuild_run_wave**- Rebuilds, simulates and opens GTKWave for a particular systemverilog file.  

- In the case of option 2, you should just open Quartus / any proprietary software that you would use for synthesizing.

