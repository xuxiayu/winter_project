module adder(A, B, Cin, S, Overflow);
	input [31:0] A, B;
	input Cin;
	
	output [31:0] S;
	output Overflow;
	
	wire [32:0] Carry;
	
	assign Carry[0] = Cin;
	
	CLA_8bit CLA_01(A[7:0], B[7:0], Carry[0], Carry[8:1]);
	CLA_8bit CLA_02(A[15:8], B[15:8], Carry[8], Carry[16:9]);
	CLA_8bit CLA_03(A[23:16], B[23:16], Carry[16], Carry[24:17]);
	CLA_8bit CLA_04(A[31:24], B[31:24], Carry[24], Carry[32:25]);
	l
	// assign Overflow = Carry[32];
	
	generate
	genvar i;
		for(i = 0; i < 32; i = i + 1) begin : adding
			full_adder add_op(A[i], B[i], Carry[i], S[i]);
		end
	endgenerate
	
	assign Overflow = (~A[31] & ~B[31] & S[31]) | (A[31] & B[31] & ~S[31]);

endmodule

module full_adder(In1, In2, Cin, S);
	input In1, In2, Cin;
	output S;
	
	assign S = In1 ^ (In2 ^ Cin);
	// assign Cout = (In1 & In2) | (Cin & (In1 | In2));
	

endmodule

module CLA_8bit(A, B, Cin, Cout);
	input [7:0] A, B;
	input Cin;
	
	output [7:0] Cout;
	
	wire [7:0] G, P;
	
	generate
	genvar i;
		for(i = 0; i < 8; i = i+1) begin : GPGen
			assign G[i] = A[i] & B[i];
			assign P[i] = A[i] | B[i];
		end
	endgenerate

	assign Cout[0] = G[0] | (P[0] & Cin);
	assign Cout[1] = G[1] | (G[0] & P[1]) | (Cin & P[0] & P[1]);
	assign Cout[2] = G[2] | (G[1] & P[2]) | (G[0] & P[1] & P[2]) | (Cin & P[0] & P[1] & P[2]);
	assign Cout[3] = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (Cin & P[0] & P[1] & P[2] & P[3]);
	assign Cout[4] = G[4] | (G[3] & P[4]) | (G[2] & P[3] & P[4]) | (G[1] & P[2] & P[3] & P[4]) | (G[0] & P[1] & P[2] & P[3] & P[4]) | (Cin & P[0] & P[1] & P[2] & P[3] & P[4]);
	assign Cout[5] = G[5] | (G[4] & P[5]) | (G[3] & P[4] & P[5]) | (G[2] & P[3] & P[4] & P[5]) | (G[1] & P[2] & P[3] & P[4] & P[5]) | (G[0] & P[1] & P[2] & P[3] & P[4] & P[5]) | (Cin & P[0] & P[1] & P[2] & P[3] & P[4] & P[5]);
	assign Cout[6] = G[6] | (G[5] & P[6]) | (G[4] & P[5] & P[6]) | (G[3] & P[4] & P[5] & P[6]) | (G[2] & P[3] & P[4] & P[5] & P[6]) | (G[1] & P[2] & P[3] & P[4] & P[5] & P[6]) | (G[0] & P[1] & P[2] & P[3] & P[4] & P[5] & P[6]) | (Cin & P[0] & P[1] & P[2] & P[3] & P[4] & P[5] & P[6]);
	assign Cout[7] = G[7] | (G[6] & P[7]) | (G[5] & P[6] & P[7]) | (G[4] & P[5] & P[6] & P[7]) | (G[3] & P[4] & P[5] & P[6] & P[7]) | (G[2] & P[3] & P[4] & P[5] & P[6] & P[7]) | (G[1] & P[2] & P[3] & P[4] & P[5] & P[6] & P[7]) | (G[0] & P[1] & P[2] & P[3] & P[4] & P[5] & P[6] & P[7]) | (Cin & P[0] & P[1] & P[2] & P[3] & P[4] & P[5] & P[6] & P[7]);
endmodule


