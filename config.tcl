# User config
set script_dir [file dirname [file normalize [info script]]]

# name of your project, should also match the name of the top module
set ::env(DESIGN_NAME) wrapped_skullfet

# add your source files here
set ::env(VERILOG_FILES) "
    $::env(DESIGN_DIR)/wrapper.v
    $::env(DESIGN_DIR)/src/skullfet.v
"

# target density, change this if you can't get your design to fit
set ::env(PL_TARGET_DENSITY) 0.4

# don't put clock buffers on the outputs, need tristates to be the final cells
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

# set absolute size of the die to 200 x 200 um
set ::env(DIE_AREA) "0 0 200 200"
set ::env(FP_SIZING) absolute

# define number of IO pads
set ::env(SYNTH_DEFINES) "MPRJ_IO_PADS=38"

# clock period is ns
set ::env(CLOCK_PERIOD) "10"
set ::env(CLOCK_PORT) "wb_clk_i"

# macro needs to work inside Caravel, so can't be core and can't use metal 5
set ::env(DESIGN_IS_CORE) 0
set ::env(GLB_RT_MAXLAYER) 5

# define power straps so the macro works inside Caravel's PDN
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]

# turn off CVC as we have multiple power domains
set ::env(RUN_CVC) 0

# make pins wider to solve routing issues
set ::env(FP_IO_VTHICKNESS_MULT) 4
set ::env(FP_IO_HTHICKNESS_MULT) 4

# Sub-macro configuration
set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro_placement.cfg
set ::env(EXTRA_LEFS) [glob $::env(DESIGN_DIR)/macros/*.lef]
set ::env(EXTRA_GDS_FILES) [glob $::env(DESIGN_DIR)/macros/*.gds]

# Needed for PDN to work with sub macros
set ::env(FP_PDN_VOFFSET) 0
set ::env(FP_PDN_VPITCH) 30

# LVS fails, unfortunately. Disable it until we figure out why...
set ::env(QUIT_ON_LVS_ERROR) "0"
