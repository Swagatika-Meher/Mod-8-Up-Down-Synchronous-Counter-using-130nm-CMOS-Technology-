////////////////////////////////////////////////////////////////////////
//
// Design Name:        T Flipflop
// Designer:               Swagatika Meher
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

