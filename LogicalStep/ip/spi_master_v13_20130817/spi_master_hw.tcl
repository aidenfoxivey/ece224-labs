# TCL File Generated by Component Editor 15.1
# Mon Apr 15 14:58:07 EDT 2019
# DO NOT MODIFY


# 
# spi_master "SPI Master (3 Wire Serial)" v1.3
# Michael Fischer 2019.04.15.14:58:07
# SPI Master (3 Wire Serial)
# 

# 
# request TCL package from ACDS 15.1
# 
package require -exact qsys 15.1


# 
# module spi_master
# 
set_module_property DESCRIPTION "SPI Master (3 Wire Serial)"
set_module_property NAME spi_master
set_module_property VERSION 1.3
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "Michael Fischer"
set_module_property DISPLAY_NAME "SPI Master (3 Wire Serial)"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL spi_master_if
set_fileset_property quartus_synth ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property quartus_synth ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file spi_master_if.vhd VHDL PATH spi_master_if.vhd TOP_LEVEL_FILE
add_fileset_file spi_master_core.vhd VHDL PATH spi_master_core.vhd

add_fileset sim_vhdl SIM_VHDL "" "VHDL Simulation"
set_fileset_property sim_vhdl ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property sim_vhdl ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file spi_master_if.vhd VHDL PATH spi_master_if.vhd
add_fileset_file spi_master_core.vhd VHDL PATH spi_master_core.vhd


# 
# documentation links
# 
add_documentation_link "Data Sheet" http://www.emb4fun.de/fpga/components/index.html


# 
# parameters
# 


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clk
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point clk
# 
add_interface clk clock end
set_interface_property clk clockRate 0
set_interface_property clk ENABLED true
set_interface_property clk EXPORT_OF ""
set_interface_property clk PORT_NAME_MAP ""
set_interface_property clk CMSIS_SVD_VARIABLES ""
set_interface_property clk SVD_ADDRESS_GROUP ""

add_interface_port clk clk clk Input 1


# 
# connection point s1
# 
add_interface s1 avalon end
set_interface_property s1 addressUnits WORDS
set_interface_property s1 associatedClock clk
set_interface_property s1 associatedReset reset
set_interface_property s1 bitsPerSymbol 8
set_interface_property s1 burstOnBurstBoundariesOnly false
set_interface_property s1 burstcountUnits WORDS
set_interface_property s1 explicitAddressSpan 0
set_interface_property s1 holdTime 1
set_interface_property s1 linewrapBursts false
set_interface_property s1 maximumPendingReadTransactions 0
set_interface_property s1 maximumPendingWriteTransactions 0
set_interface_property s1 readLatency 0
set_interface_property s1 readWaitTime 1
set_interface_property s1 setupTime 1
set_interface_property s1 timingUnits Cycles
set_interface_property s1 writeWaitStates 1
set_interface_property s1 writeWaitTime 1
set_interface_property s1 ENABLED true
set_interface_property s1 EXPORT_OF ""
set_interface_property s1 PORT_NAME_MAP ""
set_interface_property s1 CMSIS_SVD_VARIABLES ""
set_interface_property s1 SVD_ADDRESS_GROUP ""

add_interface_port s1 chipselect chipselect Input 1
add_interface_port s1 address address Input 3
add_interface_port s1 write write Input 1
add_interface_port s1 writedata writedata Input 32
add_interface_port s1 read read Input 1
add_interface_port s1 readdata readdata Output 32
set_interface_assignment s1 embeddedsw.configuration.isFlash 0
set_interface_assignment s1 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s1 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s1 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point external
# 
add_interface external conduit end
set_interface_property external associatedClock ""
set_interface_property external associatedReset ""
set_interface_property external ENABLED true
set_interface_property external EXPORT_OF ""
set_interface_property external PORT_NAME_MAP ""
set_interface_property external CMSIS_SVD_VARIABLES ""
set_interface_property external SVD_ADDRESS_GROUP ""

add_interface_port external cs cs Output 1
add_interface_port external sclk sclk Output 1
add_interface_port external mosi mosi Output 1
add_interface_port external miso miso Input 1
add_interface_port external cd cd Input 1
add_interface_port external wp wp Input 1

