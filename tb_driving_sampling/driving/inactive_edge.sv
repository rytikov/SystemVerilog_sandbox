module inactive_edge();
   bit clk;
   bit [7:0] a;
   bit [7:0] q;

   always @(posedge clk)
     q <= a;

   always
     #10 clk = ~clk;

   initial
     begin
        @(negedge clk);
        a <= 1;

        @(negedge clk);
        a <= 2;
     end

   initial
     #60 $finish();

endmodule
