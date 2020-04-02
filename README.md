# FPGA_Uart_Servo
Uart Servo control on verilog, DE10-Nano FPGA Configuration from Linux, Servo control from linux
# Uart Servo control
This part is placed in UART_PWM folder. It consist of PWM, servo control logic, uart protocol. All written on verilog and works on DE10-nano.
## HowTo
Configure FPGA as normal using Quartus II.
# DE10-Nano FPGA Configuration from Linux
You can configurate FPGA from u-boot or preloader, but doing it from linux will allow reconfiguration on fly without turning off your SoC FPGA. This part is placed in de10nano_fpga_from_linux folder. And consist of main.o program to configure fpga from binary fpga_rbf_load and source code to build this program on ARM.
## HowTo
Run makefile with SoC EDS Command Shell to build main.o. Run main.o on de10-nano it will search fpga_rbf_load to reconfigure FPGA.
# Servo Control from linux
This part is placed in two folders: LedThing, System_Verilog_PWM_w_MMAP. First one is HPS connection Test that works with leds. It configure FPGA to golden top and allow user to control LEDs from linux. System_Verilog_PWM_w_MMAP golden top configure with PWM and servo logic written on SystemVerilog & QSYS settings for virtual mapping. For Linux controling servos please, use our latest version with linux programms placed in [fossbot-pkg](https://github.com/binyot/fossbot-pkg)
## HowTo
Place Binary file on your sd card with Linux on it.
