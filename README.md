# Mod-8 Up/Down Synchronous Counter using 130nm CMOS Technology

* [Abstract](#Abstract)
* [Reference Circuit Diagram](#Reference-Circuit-Diagram)
* [Reference Waveform](#Reference-Waveform)
* [Circuit Details](#Circuit-Details)
* [Truth Table](#Truth-Table)
* [Designing Steps](#Designing-Steps)
* [Software Used](#Software-Used)
  * [eSim](#eSim)
  * [NgSpice](#NgSpice)
  * [Makerchip](#Makerchip)
  * [Verilator](#Verilator)
* [Circuit Diagram in eSim](#Circuit-Diagram-in-eSim)
* [Verilog Code](#Verilog-Code)
* [Makerchip](#Makerchip)
* [Makerchip Plots](#Makerchip-Plots)
* [Generating Model for T Flipflop using NgVeri](#Generating-Model-for-T-Flipflop-using-NgVeri)
* [Netlists](#Netlists)
* [NgSpice Plots](#NgSpice-Plots)
* [Steps to run and generate NgVeri Model](#Steps-to-run-and-generate-NgVeri-Model)
* [Author](#Author)
* [Acknowledgements](#Acknowledgements)
* [References](#References)
# Abstract
This design describes a 3-bit high-speed and low-power Flash Analog to Digital Converter. The conventional Flash ADC contains the resistor ladder network, comparator, and encoder. Power consumption is higher in typical Flash ADCs since resistor ladder networks are used. The Threshold Inverter Quantization (TIQ) comparator and mux-based encoding technique has been employed in 3-bit Flash ADC to get over this problem and speed up the conversion rate. These designs increase speed and reduce power consumption by employing simply a series of inverters and multiplexers.
# Reference Circuit Diagram
Given attached is the block diagram for TIQ comparator based 3-bit Flash type ADC.

![diagram](https://user-images.githubusercontent.com/114692581/194697017-283623c1-a901-4f7f-9798-6264ac4d1deb.png)
                                                       
Fig:1 3-bit Flash ADC using TIQ Comparator
# Circuit Details
In TIQ technique, it uses two cascaded CMOS inverters as a comparator. While the second inverter serves as a gain booster, the first inverter internally creates reference voltage (Vref). As we adjust the size of CMOS, the cascading inverters produce various switching/reference voltages internally which serves as reference voltages. The purpose of TIQ comparator is to transform an input voltage (Vin) toward logic '1' or '0' by estimating a reference voltage (Vref) with the Vin. If Vin is greater than Vref, the comparator output is '1', otherwise '0'. This occurs when transistor width is altered while keeping the transistor length constant. The gain boosters create sharper thresholds for comparator outputs and offer a complete digital output voltage swing. The comparator outputs the thermometer code are turned to a binary code using 8:3 priority encoder. In this design, sine wave is given as input voltage with 20MHz frequency.
# TIQ Comparator
Two inverters are linked in series on the TIQ Comparator for comparing and balancing. The threshold voltage of the inverter circuits can be modified to provide different reference voltages by adjusting the width of PMOS and NMOS transistors. In analog section of 3-bit ADC, $\[{2^n} - 1\]$ comparators that is, 7 TIQ comparators are connected parallelly using CMOS inverters. Where, n is the number of output binary bits.
 
![images](https://user-images.githubusercontent.com/114692581/194702441-2e6e4ff6-7534-437c-b5da-8171514baa5d.png)

Fig:2 TIQ Comparator
# Truth Table

![Capture](https://user-images.githubusercontent.com/114692581/194705103-fb21f514-ca59-4f26-9e4e-8a998e3640c9.PNG)

# Designing Steps
* Step 1 : Writing Verilog code for an 8:3 mux-based Priority Encoder and simulating it on the Makerchip. The top module of Verilog code should have the same name as the file.
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
// Mixed Signal Design Hackathon
//
// (Organised by FOSSEE IIT Bombay, VSD Corp. Pvt. Ltd.)
//
// Design Name:        8:3 Mux based Encoder
// Designer:           Swagatika Meher
// Module Name:        Swagatika_8to3_mux_based_priorityencoder
//
///////////////////////////////////////////////////////////////////////

// Enter the code here

module Swagatika_8to3_mux_based_priorityencoder(in,O);
  
  input [7:0]in;
  output [2:0]O;
  
assign O = (in[7] ==1'b1 ) ? 3'b111:
               (in[6] ==1'b1 ) ? 3'b110:
               (in[5] ==1'b1 ) ? 3'b101:
               (in[4] ==1'b1) ? 3'b100:
               (in[3] ==1'b1) ? 3'b011:
               (in[2] ==1'b1) ? 3'b010:
               (in[1] ==1'b1) ? 3'b001:
               (in[0] ==1'b1) ? 3'b000: 3'bxxx;

endmodule
```
# Makerchip

```
\TLV_version 1d: tl-x.org
\SV
/* verilator lint_off UNUSED*/  /* verilator lint_off DECLFILENAME*/  /* verilator lint_off BLKSEQ*/  /* verilator lint_off WIDTH*/  /* verilator lint_off SELRANGE*/  /* verilator lint_off PINCONNECTEMPTY*/  /* verilator lint_off DEFPARAM*/  /* verilator lint_off IMPLICIT*/  /* verilator lint_off COMBDLY*/  /* verilator lint_off SYNCASYNCNET*/  /* verilator lint_off UNOPTFLAT */  /* verilator lint_off UNSIGNED*/  /* verilator lint_off CASEINCOMPLETE*/  /* verilator lint_off UNDRIVEN*/  /* verilator lint_off VARHIDDEN*/  /* verilator lint_off CASEX*/  /* verilator lint_off CASEOVERLAP*/  /* verilator lint_off PINMISSING*/  /* verilator lint_off BLKANDNBLK*/  /* verilator lint_off MULTIDRIVEN*/  /* verilator lint_off WIDTHCONCAT*/  /* verilator lint_off ASSIGNDLY*/  /* verilator lint_off MODDUP*/  /* verilator lint_off STMTDLY*/  /* verilator lint_off LITENDIAN*/  /* verilator lint_off INITIALDLY*/  

//Your Verilog/System Verilog Code Starts Here:
////////////////////////////////////////////////////////////////////////
// Mixed Signal Design Hackathon
//
// (Organised by FOSSEE IIT Bombay, VSD Corp. Pvt. Ltd.)
//
// Design Name:        8:3 Mux based Encoder
// Designer:           Swagatika Meher
// Module Name:        Swagatika_8to3_mux_based_priorityencoder
//
///////////////////////////////////////////////////////////////////////

// Enter the code here

module Swagatika_8to3_mux_based_priorityencoder(in,O);
  
  input [7:0]in;
  output [2:0]O;
  
assign O = (in[7] ==1'b1 ) ? 3'b111:
               (in[6] ==1'b1 ) ? 3'b110:
               (in[5] ==1'b1 ) ? 3'b101:
               (in[4] ==1'b1) ? 3'b100:
               (in[3] ==1'b1) ? 3'b011:
               (in[2] ==1'b1) ? 3'b010:
               (in[1] ==1'b1) ? 3'b001:
               (in[0] ==1'b1) ? 3'b000: 3'bxxx;

endmodule

//Top Module Code Starts here:
	module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
		logic  [7:0] in;//input
		logic  [2:0] O;//output
//The $random() can be replaced if user wants to assign values
		assign in = $random();
		Swagatika_8to3_mux_based_priorityencoder Swagatika_8to3_mux_based_priorityencoder(.in(in), .O(O));
	
\TLV
//Add \TLV here if desired                                     
\SV
endmodule
```
# Makerchip Plots
The waveforms for different inputs given to 8:3 priority encoder & their respective outputs :

![Encoder](https://user-images.githubusercontent.com/114692581/194708805-069f7fb7-5d40-4016-b859-a8d43d690b1e.PNG)

# Generating Model for 8 to 3 Priority Encoder using NgVeri
To encode the thermometric code into binary code, digital logic of 8:3 priority encoder is created using verilog code in NgVeri simulator.

![Model](https://user-images.githubusercontent.com/114692581/194709369-957c0425-831e-41aa-85d8-a2fac267025d.PNG)

# Circuit Diagram in eSim
The following is the schematic in eSim simulator.

![Sch1](https://user-images.githubusercontent.com/114692581/194710243-f9ccb0e7-a9d9-4303-b07d-b450b23c94b2.PNG)


![sch2](https://user-images.githubusercontent.com/114692581/194710247-ea507ad5-56b7-41dd-9f15-1f89c0df53f1.PNG)


![sch3](https://user-images.githubusercontent.com/114692581/194710263-48b2036b-cc2a-4b53-a2b5-b417f06ca597.PNG)


![sch4](https://user-images.githubusercontent.com/114692581/194710283-9b59d4a4-5315-4509-b5e3-8f672a98c612.PNG)

As we can see, 7 TIQ comparators are connected in parallel manner. From all the TIQ components, first inverters are acting as comparators and second inverters are acting as gain boosters. In the next stage, the outputs of TIQ comparators are passing through ADC bridge to convert the analog voltages to digital form that is, 0s and 1s. Then, the 8:3 priority encoder is used to generate 3 bit binary output for the input with highest priority.
# Netlists
```
* e:\esim\adc\adc.cir

.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__r+c.model.spice"
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__inductors.model.spice"
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__diode_pw2nd_11v0.model.spice"
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__pnp.model.spice"
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__diode_pd2nw_11v0.model.spice"
.lib "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130.lib.spice" tt
.include "C:\FOSSEE\eSim\library\sky130_fd_pr\models\sky130_fd_pr__model__linear.model.spice"
xsc1 net-_sc1-pad1_ vin vref vref sky130_fd_pr__pfet_01v8 M=1 W=0.5 L=10
xsc15 tiq1 net-_sc1-pad1_ vref vref sky130_fd_pr__pfet_01v8 
xsc2 net-_sc1-pad1_ vin gnd gnd sky130_fd_pr__nfet_01v8 W=20 L=0.3
xsc3 net-_sc17-pad2_ vin vref vref sky130_fd_pr__pfet_01v8 W=0.5 L=1
xsc17 tiq2 net-_sc17-pad2_ vref vref sky130_fd_pr__pfet_01v8 
xsc4 net-_sc17-pad2_ vin gnd gnd sky130_fd_pr__nfet_01v8 W=12 L=0.3
xsc18 tiq2 net-_sc17-pad2_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc5 net-_sc19-pad2_ vin vref vref sky130_fd_pr__pfet_01v8 W=0.42 L=0.18
xsc19 tiq3 net-_sc19-pad2_ vref vref sky130_fd_pr__pfet_01v8 
xsc7 net-_sc21-pad2_ vin vref vref sky130_fd_pr__pfet_01v8 W=2 L=0.18
xsc21 tiq4 net-_sc21-pad2_ vref vref sky130_fd_pr__pfet_01v8 
xsc6 net-_sc19-pad2_ vin gnd gnd sky130_fd_pr__nfet_01v8 W=1 L=0.18
xsc20 tiq3 net-_sc19-pad2_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc8 net-_sc21-pad2_ vin gnd gnd sky130_fd_pr__nfet_01v8 W=0.42 L=0.18
xsc22 tiq4 net-_sc21-pad2_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc9 net-_sc10-pad1_ vin vref vref sky130_fd_pr__pfet_01v8 W=3 L=0.18
xsc23 tiq5 net-_sc10-pad1_ vref vref sky130_fd_pr__pfet_01v8 
xsc10 net-_sc10-pad1_ vin gnd gnd sky130_fd_pr__nfet_01v8 W=0.42 L=1
xsc24 tiq5 net-_sc10-pad1_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc11 net-_sc11-pad1_ vin vref vref sky130_fd_pr__pfet_01v8 W=15 L=0.18
xsc25 tiq6 net-_sc11-pad1_ vref vref sky130_fd_pr__pfet_01v8 
xsc12 net-_sc11-pad1_ vin gnd gnd sky130_fd_pr__nfet_01v8 W=0.42 L=10
xsc26 tiq6 net-_sc11-pad1_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc13 net-_sc13-pad1_ vin vref vref sky130_fd_pr__pfet_01v8 W=30 L=0.18
xsc27 tiq7 net-_sc13-pad1_ vref vref sky130_fd_pr__pfet_01v8 
xsc14 net-_sc13-pad1_ vin gnd gnd sky130_fd_pr__nfet_01v8 W=0.42 L=20
xsc28 tiq7 net-_sc13-pad1_ gnd gnd sky130_fd_pr__nfet_01v8 
xsc16 tiq1 net-_sc1-pad1_ gnd gnd sky130_fd_pr__nfet_01v8 
vin1  vin gnd sine(0 6 20M 1n 0)
v2 vref gnd  dc 6
* u2  vref plot_v1
* s c m o d e
* u7  net-_u6-pad9_ net-_u6-pad10_ net-_u6-pad11_ y2 y1 y0 dac_bridge_3
* u8  y2 plot_v1
* u9  y1 plot_v1
* u10  y0 plot_v1
* u3  tiq1 tiq2 tiq3 tiq4 tiq5 tiq6 tiq7 gnd net-_u3-pad9_ net-_u3-pad10_ net-_u3-pad11_ net-_u3-pad12_ net-_u3-pad13_ net-_u3-pad14_ net-_u3-pad15_ net-_u3-pad16_ adc_bridge_8
* u5  tiq1 plot_v1
* u12  tiq2 plot_v1
* u15  tiq3 plot_v1
* u4  tiq4 plot_v1
* u11  tiq5 plot_v1
* u13  tiq6 plot_v1
* u14  tiq7 plot_v1
* u1  vin plot_v1
* u6  net-_u3-pad9_ net-_u3-pad10_ net-_u3-pad11_ net-_u3-pad12_ net-_u3-pad13_ net-_u3-pad14_ net-_u3-pad15_ net-_u3-pad16_ net-_u6-pad9_ net-_u6-pad10_ net-_u6-pad11_ swagatika_8to3_mux_based_priorityencoder
a1 [net-_u6-pad9_ net-_u6-pad10_ net-_u6-pad11_ ] [y2 y1 y0 ] u7
a2 [tiq1 tiq2 tiq3 tiq4 tiq5 tiq6 tiq7 gnd ] [net-_u3-pad9_ net-_u3-pad10_ net-_u3-pad11_ net-_u3-pad12_ net-_u3-pad13_ net-_u3-pad14_ net-_u3-pad15_ net-_u3-pad16_ ] u3
a3 [net-_u3-pad9_ net-_u3-pad10_ net-_u3-pad11_ net-_u3-pad12_ net-_u3-pad13_ net-_u3-pad14_ net-_u3-pad15_ net-_u3-pad16_ ] [net-_u6-pad9_ net-_u6-pad10_ net-_u6-pad11_ ] u6
* Schematic Name:                             dac_bridge_3, NgSpice Name: dac_bridge
.model u7 dac_bridge(out_low=0 out_high=5 out_undef=5 input_load=1p t_rise=1n t_fall=1n ) 
* Schematic Name:                             adc_bridge_8, NgSpice Name: adc_bridge
.model u3 adc_bridge(in_low=1.0 in_high=2.0 rise_delay=1.0e-9 fall_delay=1.0e-9 ) 
* Schematic Name:                             swagatika_8to3_mux_based_priorityencoder, NgSpice Name: swagatika_8to3_mux_based_priorityencoder
.model u6 swagatika_8to3_mux_based_priorityencoder(rise_delay=1.0e-9 fall_delay=1.0e-9 input_load=1.0e-12 instance_id=1 ) 
.tran 0.001e-00 14e-00 0e-00

* Control Statements 
.control
run
print allv > plot_data_v.txt
print alli > plot_data_i.txt
plot v(vin) v(tiq1) v(tiq2) v(tiq3) v(tiq4) v(tiq5) v(tiq6) v(tiq7)    
plot v(vref)
plot v(y2)+16 v(y1)+8 v(y0)
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
