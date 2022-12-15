# Mod-8 Up/Down Synchronous Counter using 130nm CMOS Technology
# Table of contents
* [Abstract](#Abstract)
* [Reference Circuit Diagram](#Reference-Circuit-Diagram)
* [Circuit Details](#Circuit-Details)
* [Truth Table](#Truth-Table)
* [Designing Steps](#Designing-Steps)
* [Software Used](#Software-Used)
  * [eSim](#eSim)
  * [NgSpice](#NgSpice)
  * [Makerchip](#Makerchip)
  * [Verilator](#Verilator)
* [Verilog Code](#Verilog-Code)
* [Makerchip](#Makerchip)
* [Makerchip Plots](#Makerchip-Plots)
* [Generating Model for T Flipflop using NgVeri](#Generating-Model-for-T-Flipflop-using-NgVeri)
* [Circuit Diagram in eSim](#Circuit-Diagram-in-eSim)
* [Netlists](#Netlists)
* [NgSpice Plots](#NgSpice-Plots)
* [Steps to run and generate NgVeri Model](#Steps-to-run-and-generate-NgVeri-Model)
* [Author](#Author)
* [Acknowledgements](#Acknowledgements)
* [References](#References)
# Abstract
In this study, 3 bit or mod 8 up/down synchronous counter is designed using transistors and Verilog code. This design is built with both analog and digital circuitry. As the counter is synchronous, the clock signal is applied to all of the flipflops at the same time. Here, an astable multivibrator is used to generate the clock signal. The analog circuitry consists of the astable multivibrator, the combination of AND gates and XOR gate implemented using CMOS transistors. The digital circuitry of MOD - 8 is made up of three T flipflops with synchronous clear. The control input M=0 is assumed for UP counting and M=1 for DOWN counting. The entire design process of sequential circuits and simulations are carried out using eSim software.
# Reference Circuit Diagram
Given attached is the block diagram for Mod-8 Up/Down Synchronous Counter.

![ref_ckt_d](https://user-images.githubusercontent.com/114692581/207661098-4b1f53f0-d88f-43fd-9d25-5462446bef35.png)
                                                       
Fig:1 Block diagram of Mod-8 Up/Down Synchronous Counter
# Circuit Details
In 3 bit or mod-8 Up or Down counting, 3 Flip Flops are required, which can count up to $\{2^3} - 1 = 7\$ states. Here, the counter's mode control input determines which sequence will be generated. In this scenario, the counter's mode control input determines whether it will execute up counting or down counting. Such a counter must be designed similarly to a synchronous counter, but it also needs additional combinational logic for mode control input.
Here 3 T flipflops are designed using Verilog code. For the control input (M), let’s assume M=0 for UP counting and M=1 for DOWN counting. Here, Fig.2 shows the state transition diagram of 3-bit up/down synchronous counter.

![IN1](https://user-images.githubusercontent.com/114692581/207883613-bc32d46f-c370-43a8-aa86-0ee315675689.png)

Fig:2 State Transition diagram of Mod-8 Up/Down Synchronous Counter

For the generation of clock pulse, the astable multivibrator is constructed by cascading three inverters, and the clock pulse signal is produced using a resistor and capacitor. The inverters serve as a buffer, and an important factor in switching the inputs and outputs of the inverter is the direction in which the capacitor is charged and discharged.
When the positive edge triggered clock pulse is applied and input T of the flip-flops, the present states of the counting sequence, as well as the next states are represented by the circuit excitation table. Using the Flip Flops excitation table, we can determine the input values for 3 Flip Flops by observing the change from one state to the subsequent state. In table 1, the excitation table is created using the necessary counting sequence.
# Truth Table
Table 1: Excitation table for each T-Flipflop of Mod-8 Up/Down Synchronous Counter 

![TT](https://user-images.githubusercontent.com/114692581/207885375-bb44a50a-046f-4e5b-8d87-49da028e6716.PNG)

The circuit excitation table is reduced using the K-map to obtain the Boolean functions for the input to the flipflops. To create circuit schematics, the simplified expression for Flip Flops is adopted. In this case, all connections are formed using reduced expressions for flip flops. 
The Boolean functions for input of flipflops are,

For 

$\{T_3} = M'{Q_2}{Q_1} + M{Q_2}^\prime {Q_1}^\prime \$

$\{T_2} = M'{Q_1} + M{Q_1}^\prime \$

$\{T_1} = 1\$

# Designing Steps
* Step 1 : Writing Verilog code for a T- flipflop with synchronous positive edge triggered clock pulse and simulating it on the Makerchip. The top module of Verilog code should have the same name as the file.
* Step 2: Generating models on NgVeri and employing Makerchip to simulate.
* Step 3 : Schematics creation using Eeschema.
* Step 4: Making a netlist after running an electrical rule check (ERC) and annotating the schematic.
* Step 5: Configuring the KiCad to NgSpice Converter's simulation instance parameters. Before switching to NgSpice, sub-circuits should also have the default path added.
* Step 6: Results verification and simulation.
# Software Used
* **eSim**

It is an Open Source EDA developed by FOSSEE, IIT Bombay. It is used for electronic circuit simulation. It is made by the combination of two software namely NgSpice and KiCAD. For more details refer: [https://esim.fossee.in/home](https://esim.fossee.in/home)
* **NgSpice**

It is an Open Source Software for Spice Simulations. For more details refer: [http://ngspice.sourceforge.net/docs.html](http://ngspice.sourceforge.net/docs.html)
* **Makerchip**

It is an Online Web Browser IDE for Verilog/System-verilog/TL-Verilog Simulation. For more details refer: [https://www.makerchip.com/](https://www.makerchip.com/)
* **Verilator**

It is a tool which converts Verilog code to C++ objects. For more details refer: [https://www.veripool.org/verilator/](https://www.veripool.org/verilator/)
# Verilog Code

```
////////////////////////////////////////////////////////////////////////
//
// Design Name:        T Flipflop
// Designer:           Swagatika Meher
// Module Name:        swagatika_T_FF
//
///////////////////////////////////////////////////////////////////////


module swagatika_T_FF(t,clk,clr,Q,Qbar);
	input clk,clr,t;
	output reg Q;
	output Qbar;
	
	always @(posedge clk) 
	begin
		if (!clr)
			Q<=0;
		else 
			if (t)
				 Q<=~Q;
			else
                                 Q<=Q;
	end
                           assign Qbar = ~Q;
endmodule
```
# Makerchip

```
\TLV_version 1d: tl-x.org
\SV
/* verilator lint_off UNUSED*/  /* verilator lint_off DECLFILENAME*/  /* verilator lint_off BLKSEQ*/  /* verilator lint_off WIDTH*/  /* verilator lint_off SELRANGE*/  /* verilator lint_off PINCONNECTEMPTY*/  /* verilator lint_off DEFPARAM*/  /* verilator lint_off IMPLICIT*/  /* verilator lint_off COMBDLY*/  /* verilator lint_off SYNCASYNCNET*/  /* verilator lint_off UNOPTFLAT */  /* verilator lint_off UNSIGNED*/  /* verilator lint_off CASEINCOMPLETE*/  /* verilator lint_off UNDRIVEN*/  /* verilator lint_off VARHIDDEN*/  /* verilator lint_off CASEX*/  /* verilator lint_off CASEOVERLAP*/  /* verilator lint_off PINMISSING*/  /* verilator lint_off BLKANDNBLK*/  /* verilator lint_off MULTIDRIVEN*/  /* verilator lint_off WIDTHCONCAT*/  /* verilator lint_off ASSIGNDLY*/  /* verilator lint_off MODDUP*/  /* verilator lint_off STMTDLY*/  /* verilator lint_off LITENDIAN*/  /* verilator lint_off INITIALDLY*/  

//Your Verilog/System Verilog Code Starts Here:
////////////////////////////////////////////////////////////////////////
//
// Design Name:        T Flipflop
// Designer:           Swagatika Meher
// Module Name:        swagatika_T_FF
//
///////////////////////////////////////////////////////////////////////


module swagatika_T_FF(t,clk,clr,Q,Qbar);
	input clk,clr,t;
	output reg Q;
	output Qbar;
	
	always @(posedge clk) 
	begin
		if (!clr)
			Q<=0;
		else 
			if (t)
				 Q<=~Q;
			else
                                 Q<=Q;
	end
                           assign Qbar = ~Q;
endmodule



//Top Module Code Starts here:
	module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
		logic  clr;//input
		logic  t;//input
		logic  Q;//output
		logic  Qbar;//output
//The $random() can be replaced if user wants to assign values
		assign clr = $random();
		assign t = $random();
		swagatika_T_FF swagatika_T_FF(.clk(clk), .clr(clr), .t(t), .Q(Q), .Qbar(Qbar));
	
\TLV
//Add \TLV here if desired                                     
\SV
endmodule
```
# Makerchip Plots
The functioning of the positive edge-triggered T flipflop with synchronous clear for input T = 1 is shown in this plot.

![T_ff](https://user-images.githubusercontent.com/114692581/207893123-bdb8e3b4-d840-438f-a362-de9c65b4667c.PNG)

# Generating Model for T Flipflop  using NgVeri
Digital logic of T Flipflop is created using verilog code in NgVeri simulator.

![model](https://user-images.githubusercontent.com/114692581/207894492-b824c92b-bbc2-4375-8843-0651bb775bae.PNG)

# Circuit Diagram in eSim
The following is the schematic in eSim simulator.

**Power Supply**

![power_supply](https://user-images.githubusercontent.com/114692581/207895724-ea63b928-0259-4859-8cc9-46804a8e25be.png)

**Control Input [M]**

![control_inputM](https://user-images.githubusercontent.com/114692581/207896384-bb9d5f61-21f1-4f9a-832b-935d664d2e44.png)

**Astable Multivibrator**

![astable_multibrator](https://user-images.githubusercontent.com/114692581/207896774-f961b575-766d-4a38-86f7-418cd5f956b7.png)

**Input of T-FF 3**

![IpT3](https://user-images.githubusercontent.com/114692581/207897093-f0903436-6807-451a-ba0d-c97ada67f79f.png)

**Input of T-FF 2**

![IpT2](https://user-images.githubusercontent.com/114692581/207897256-370da7b2-e2a7-4a48-ba5b-2490885df833.png)

**Schematic Diagram of MOD-8 UP/DOWN Synchronous counter using T-flipflops**

![cktdia](https://user-images.githubusercontent.com/114692581/207897548-f46b9e36-c31f-413f-9fa8-2fb261fd0509.png)

**Mixed signal MOD-8 UP/DOWN Synchronous counter using 130nm CMOS technology**

![full circuit](https://user-images.githubusercontent.com/114692581/207898083-306d25b3-26f4-4466-8ab8-1081c7ed1676.png)

# Netlists
```
* e:\esim\mod8_synchronouscounter\mod8_synchronouscounter.cir

.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__r+c.model.spice"
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__linear.model.spice"
.lib "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130.lib.spice" tt
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__diode_pd2nw_11v0.model.spice"
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__pnp.model.spice"
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__inductors.model.spice"
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__diode_pw2nd_11v0.model.spice"
v1 t_ff_1 gnd  dc 1.8
xsc1 net-_sc1-pad1_ net-_sc1-pad2_ t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc3 net-_sc3-pad1_ net-_sc1-pad1_ t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc6 clk net-_sc3-pad1_ t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc2 net-_sc1-pad1_ net-_sc1-pad2_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc4 net-_sc3-pad1_ net-_sc1-pad1_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc7 clk net-_sc3-pad1_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc5 net-_sc3-pad1_ net-_sc1-pad2_ sky130_fd_pr__cap_mim_m3_1 W=1000 L=6000 MF=5000
xsc8 net-_sc1-pad2_ clk supply_voltage sky130_fd_pr__res_generic_nd W=1 L=900
v2 supply_voltage gnd  dc 3.5
* s c m o d e
xsc9 mbar control_input__m_ t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc10 mbar control_input__m_ gnd gnd sky130_fd_pr__nfet_01v8 
v3  control_input__m_ gnd pulse(3.5 0 0 0.001m 0.001m 50m 100m)
* u2  q1bar q2bar q1_bar q2_bar dac_bridge_2
* u1  q1 q2 q_1 q_2 dac_bridge_2
xsc11 net-_sc11-pad1_ mbar t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc16 net-_sc11-pad1_ q_2 t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc21 net-_sc11-pad1_ q_1 t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc12 net-_sc12-pad1_ control_input__m_ net-_sc11-pad1_ net-_sc11-pad1_ sky130_fd_pr__pfet_01v8 
xsc17 net-_sc12-pad1_ q2_bar net-_sc11-pad1_ net-_sc11-pad1_ sky130_fd_pr__pfet_01v8 
xsc22 net-_sc12-pad1_ q1_bar net-_sc11-pad1_ net-_sc11-pad1_ sky130_fd_pr__pfet_01v8 
xsc13 net-_sc12-pad1_ mbar net-_sc13-pad3_ net-_sc13-pad3_ sky130_fd_pr__nfet_01v8 
xsc14 net-_sc13-pad3_ q_2 net-_sc14-pad3_ net-_sc14-pad3_ sky130_fd_pr__nfet_01v8 
xsc15 net-_sc14-pad3_ q_1 gnd gnd sky130_fd_pr__nfet_01v8 
xsc18 net-_sc12-pad1_ control_input__m_ net-_sc18-pad3_ net-_sc18-pad3_ sky130_fd_pr__nfet_01v8 
xsc19 net-_sc18-pad3_ q2_bar net-_sc19-pad3_ net-_sc19-pad3_ sky130_fd_pr__nfet_01v8 
xsc20 net-_sc19-pad3_ q1_bar gnd gnd sky130_fd_pr__nfet_01v8 
xsc23 t_ff_3 net-_sc12-pad1_ t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc24 t_ff_3 net-_sc12-pad1_ gnd gnd sky130_fd_pr__nfet_01v8 
* u3  t_ff_3 plot_v1
xsc25 net-_sc25-pad1_ q_1 t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc26 t_ff_2 mbar net-_sc25-pad1_ net-_sc25-pad1_ sky130_fd_pr__pfet_01v8 
xsc29 net-_sc29-pad1_ q1_bar t_ff_1 t_ff_1 sky130_fd_pr__pfet_01v8 
xsc30 t_ff_2 control_input__m_ net-_sc29-pad1_ net-_sc29-pad1_ sky130_fd_pr__pfet_01v8 
xsc27 t_ff_2 mbar net-_sc27-pad3_ net-_sc27-pad3_ sky130_fd_pr__nfet_01v8 
xsc28 net-_sc27-pad3_ q1_bar gnd gnd sky130_fd_pr__nfet_01v8 
xsc31 t_ff_2 control_input__m_ net-_sc31-pad3_ net-_sc31-pad3_ sky130_fd_pr__nfet_01v8 
xsc32 net-_sc31-pad3_ q_1 gnd gnd sky130_fd_pr__nfet_01v8 
* u4  t_ff_2 plot_v1
* u7  t_ff_1 t_ff_2 t_ff_3 clk clear ff_1_ta ff_2_tb ff_3_tc ff_clk ff_clr adc_bridge_5
* u5  t_ff_1 plot_v1
v4  clear gnd pulse(0 3.5 0 0.001m 0.001m 30m 50m)
* u6  clear plot_v1
* u8  ff_clk clock dac_bridge_1
* u9  clock plot_v1
* u11  ff_clk ff_clr ff_1_ta q1 q1bar swagatika_t_ff
* u16  ff_clk ff_clr ff_2_tb q2 q2bar swagatika_t_ff
* u17  ff_clk ff_clr ff_3_tc q3 ? swagatika_t_ff
* u12  q3 q2 q1 tq3 tq2 tq1 dac_bridge_3
* u13  tq3 plot_v1
* u14  tq2 plot_v1
* u15  tq1 plot_v1
* u10  control_input__m_ plot_v1
xsc33 t_ff_3 gnd sky130_fd_pr__cap_mim_m3_1 W=100 L=500 MF=5000
xsc34 t_ff_2 gnd sky130_fd_pr__cap_mim_m3_1 W=100 L=100 MF=5000
a1 [q1bar q2bar ] [q1_bar q2_bar ] u2
a2 [q1 q2 ] [q_1 q_2 ] u1
a3 [t_ff_1 t_ff_2 t_ff_3 clk clear ] [ff_1_ta ff_2_tb ff_3_tc ff_clk ff_clr ] u7
a4 [ff_clk ] [clock ] u8
a5 [ff_clk ] [ff_clr ] [ff_1_ta ] [q1 ] [q1bar ] u11
a6 [ff_clk ] [ff_clr ] [ff_2_tb ] [q2 ] [q2bar ] u16
a7 [ff_clk ] [ff_clr ] [ff_3_tc ] [q3 ] [? ] u17
a8 [q3 q2 q1 ] [tq3 tq2 tq1 ] u12
* Schematic Name:                             dac_bridge_2, NgSpice Name: dac_bridge
.model u2 dac_bridge(out_low=0.0 out_high=5.0 out_undef=0.5 input_load=1.0e-12 t_rise=1.0e-9 t_fall=1.0e-9 ) 
* Schematic Name:                             dac_bridge_2, NgSpice Name: dac_bridge
.model u1 dac_bridge(out_low=0.0 out_high=5.0 out_undef=0.5 input_load=1.0e-12 t_rise=1.0e-9 t_fall=1.0e-9 ) 
* Schematic Name:                             adc_bridge_5, NgSpice Name: adc_bridge
.model u7 adc_bridge(in_low=1.0 in_high=2.0 rise_delay=1.0e-9 fall_delay=1.0e-9 ) 
* Schematic Name:                             dac_bridge_1, NgSpice Name: dac_bridge
.model u8 dac_bridge(out_low=0.0 out_high=5.0 out_undef=0.5 input_load=1.0e-12 t_rise=1.0e-9 t_fall=1.0e-9 ) 
* Schematic Name:                             swagatika_t_ff, NgSpice Name: swagatika_t_ff
.model u11 swagatika_t_ff(rise_delay=1.0e-9 fall_delay=1.0e-9 input_load=1.0e-12 instance_id=1 ) 
* Schematic Name:                             swagatika_t_ff, NgSpice Name: swagatika_t_ff
.model u16 swagatika_t_ff(rise_delay=1.0e-9 fall_delay=1.0e-9 input_load=1.0e-12 instance_id=1 ) 
* Schematic Name:                             swagatika_t_ff, NgSpice Name: swagatika_t_ff
.model u17 swagatika_t_ff(rise_delay=1.0e-9 fall_delay=1.0e-9 input_load=1.0e-12 instance_id=1 ) 
* Schematic Name:                             dac_bridge_3, NgSpice Name: dac_bridge
.model u12 dac_bridge(out_low=0.0 out_high=5.0 out_undef=0.5 input_load=1.0e-12 t_rise=1.0e-9 t_fall=1.0e-9 ) 
.tran 0.01e-03 100e-03 0e-03

* Control Statements 
.control
run
print allv > plot_data_v.txt
print alli > plot_data_i.txt
plot v(clock)+54 v(clear)+48 v(control_input__m_)+40 v(t_ff_3)+34 v(t_ff_2)+29 v(t_ff_1)+24 v(tq3)+17 v(tq2)+8 v(tq1)
.endc
.end
```
# NgSpice Plots
Here, sine wave is taken as input voltage with amplitude 6V and frequency 20MHz. Reference voltage is also taken as 6V. Reference voltages of each comparator are varying with respect to width of PMOS. We know that, the output is high if reference voltage is less than input voltage and the output is low, if reference voltage is greater than input voltage. We can see in the output plots, from 0sec to 1sec the output bits are low and after that all the digital output bits are high. 

![p1](https://user-images.githubusercontent.com/114692581/194712499-ae960d9c-3d2c-4a51-81c4-05b40ad427f4.PNG)


![P2](https://user-images.githubusercontent.com/114692581/194712517-1fbcba98-826f-4507-b0c4-7524cbff8682.PNG)


![p3](https://user-images.githubusercontent.com/114692581/194717301-bfd01c5f-b994-498e-b36e-8a7af0b3d77e.PNG)


![r1](https://user-images.githubusercontent.com/114692581/194745729-84e92afc-8948-41e0-992d-cc2a848f19e2.PNG)


![r2](https://user-images.githubusercontent.com/114692581/194745740-9986585d-326e-40d4-8d79-04405b505ee2.PNG)

# Steps to run and generate NgVeri Model
1. Open eSim
2. Run NgVeri-Makerchip
3. Add top level verilog file in Makerchip Tab [Keep module name same as file name]
4. Click on NgVeri tab
5. Add dependency files
6. Click on Run Verilog to NgSpice Converter
7. Debug if any errors
8. Model created successfully
# Author
Swagatika Meher, M.Tech (ECE), Odisha University of Technology and Research, Bhubaneswar, Odisha, India, 751029
# Acknowledgements
1. FOSSEE, IIT Bombay  
   [http://iitb.ac.in/](http://iitb.ac.in/), [https://fossee.in/](https://fossee.in/)
2. Steve Hoover, Founder, Redwood EDA
3. Kunal Ghosh, Co-founder, VSD Corp. Pvt. Ltd. - [kunalpghosh@gmail.com](kunalpghosh@gmail.com)
4. Sumanto Kar, eSim Team, FOSSEE, IIT Bombay
5. VLSI System Design - [https://www.vlsisystemdesign.com/](https://www.vlsisystemdesign.com/)
6. Spoken Tutorial - [https://spoken-tutorial.org/](https://spoken-tutorial.org/)
7. Ministry of Electronics & Information Technology (MeitY) Chips to Startup (C2S) - [https://www.c2s.gov.in/](https://www.c2s.gov.in/)
8. Google - [https://www.google.co.in/](https://www.google.co.in/)
# References
1. Moyal, Vishal, and Neeta Tripathi. "Adiabatic threshold inverter quantizer for a 3-bit flash ADC." 2016 International Conference on Wireless Communications, Signal Processing and Networking (WiSPNET). IEEE, 2016. - [https://doi.org/10.1109/WiSPNET.2016.7566395](https://doi.org/10.1109/WiSPNET.2016.7566395)
2. Sireesha, Ranam, and Abhishek Kumar. "Design of low power 0.8 V Flash ADC using TIQ in 90nm technology." 2015 International Conference on Smart Technologies and Management for Computing, Communication, Controls, Energy and Materials (ICSTM). IEEE, 2015. - [https://doi.org/10.1109/ICSTM.2015.7225451](https://doi.org/10.1109/ICSTM.2015.7225451)
