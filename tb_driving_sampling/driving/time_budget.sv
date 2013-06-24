`define CLOCK_PERIOD    10
`define CLOCK_PERIOD_20 2
`define CLOCK_PERIOD_80 8

module time_budget();
   bit clk;
   bit [7:0] a;
   bit [7:0] q;

   always @(posedge clk)
     q <= a;

   always
     #(`CLOCK_PERIOD/2) clk = ~clk;

   initial
     begin
        @(posedge clk);
        #`CLOCK_PERIOD_20 a <= 1;

        @(posedge clk);
        #`CLOCK_PERIOD_20 a <= 2;
     end

   initial
     #30 $finish();

endmodule
