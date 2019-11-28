module h_adder (n1, n2, sum, carry);
	input n1, n2;
	output sum, carry;

	assign sum = n1 ^ n2;
	assign carry = n1 & n2;
endmodule