module clocking_block();
   bit clk;
   bit [7:0] a,q;

   clocking cb @(posedge clk);
      default output #2ns;
      // direction from the tb point of view
      output  a;
      input q;
   endclocking

   always @(posedge clk)
     q <= a;

   always
     #10 clk = ~clk;

   initial
     begin
        @(cb);
        cb.a <= 1;

        @(cb);
        cb.a <= 2;
     end

   initial
     #60 $finish();

endmodule
