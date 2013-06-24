// It's not like we really need to randomize this test.
// We obviously can loop through the whole input space (values from 2 to 15).
// It's mostly an example how to randomize stimulus and
// makesure we cover all interesting values using coverage groups.
class Operand;
   randc int_types::INT04_t value;
   constraint allowed_range {value inside {[2:15]};}

   covergroup ensure_tested_range;
      coverpoint value {bins range[] = {[2:15]};}
   endgroup

   function new();
      ensure_tested_range = new();
   endfunction

   function void sample();
      ensure_tested_range.sample();
   endfunction
endclass

module factorial_tb(tb_interface.tb_side tif);

   task reset();
      tif.cb.operand <= '0;
      tif.cb.dack <= '0;
      tif.cb.load <= '0;

      @(tif.cb);
      tif.cb.rst <= '0;
      @(tif.cb);
      tif.cb.rst <= '1;
      @(tif.cb);
      tif.cb.rst <= '0;
   endtask

   task compute_assert(int N, int_types::INT41_t expected);
      int_types::INT41_t actual;

      @(tif.cb);

      tif.cb.operand <= N;
      tif.cb.load <= '1;

      @(tif.cb);
      tif.cb.load <= '0;

      wait (tif.cb.done);

      actual = tif.cb.product;

      assert(actual == expected) else $error("Expected %d actual %d", expected, actual);

      @(tif.cb);
      tif.cb.dack <= '1;
      @(tif.cb);
      tif.cb.dack <= '0;

   endtask

   function automatic int_types::INT41_t F(int_types::INT04_t arg);
      int_types::INT41_t result = 1;

      for (int i = arg;i > 0;i--)
        result *= i;

      return result;
   endfunction

   task automatic do_test();
      Operand operand = new();
      int_types::INT41_t expected_product;

        reset();

        for (int i = 0;i < 14;i++)
          begin
             assert(operand.randomize());
             operand.sample();

             expected_product = F(operand.value);
             $display("%d - %d", operand.value, expected_product);
             compute_assert(operand.value, expected_product);
          end

   endtask

   initial
     begin
        do_test();
        $finish();
     end
endmodule

module top();
   bit clk = 0;

   always
     #5 clk = ~clk;

   initial
     begin
        #200_000;
        $display("Aborted by timeout");
        $finish();
     end

   tb_interface tif(clk);
   factorial factorial0(tif.dut_side);
   factorial_tb factorial_tb0(tif.tb_side);
endmodule
