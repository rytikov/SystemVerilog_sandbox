module factorial(tb_interface.dut_side tif);
   logic clk, rst, stop, acc, pre, load, dack, done;

   int_types::INT04_t operand;
   int_types::INT41_t product;

   assign clk = tif.clk;
   assign rst = tif.rst;
   assign load = tif.load;
   assign tif.done = done;
   assign dack = tif.dack;
   assign operand = tif.operand;
   assign tif.product = product;

   engine_pgm engine_pgm0(.*);
   engine engine0(.*);
endmodule
