interface tb_interface(input logic clk);
   logic   rst,  load;
   logic   done, dack;
   int_types::INT04_t operand;
   int_types::INT41_t product;

`ifdef SIMULATION
   default clocking cb @(posedge clk);
      default input #1step;

      output operand, load, rst, dack;
      input  product, done;
   endclocking

  modport tb_side(clocking cb);
`endif

   modport dut_side(input clk, input rst, input operand, output product, input load, output done, input dack);

`ifdef SIMULATION
   assert_latency_range: assert property(load |=> ##[2:15] done);

   property exact_latency();
      int    op;
      (load,op=operand) |=> (!done, op = op-1)[*0:$] ##1 done && (op == 0);
   endproperty

   assert_exact_latency: assert property(exact_latency);
`endif

endinterface
