module f_adder(n1, n2, carry_in, sum, carry_out);
	input n1, n2, carry_in;
	output sum, carry_out;	
	
	assign sum = (n1 ^ n2) ^ carry_in;
	assign carry_out = (n1 & n2) | (carry_in	& (n1 ^ n2));
endmodule
