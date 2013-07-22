module binary2bcd_tb();

   logic [15:0] data_in, data_out;
   binary2bcd DUT(.*);

   bit          clk;

   initial
     forever #5 clk = ~clk;

   clocking cb @(posedge clk);
      output    data_in;
      input     data_out;
   endclocking

   initial
     #1000 $finish();

   task init();
      @(cb) cb.data_in <= 0;
   endtask

   task do_test(logic [15:0] data_in, logic [15:0] expected);
      @(cb) cb.data_in <= data_in;
      $display("==============================================================================================");
      @(cb);
      assert(cb.data_out == expected) $display("Pass - data_in %d data_out %x", data_in, data_out);
      else $error("Got %x expected %x", cb.data_out, expected);

   endtask

   initial
     begin
        init();
        do_test(255, 16'h255);

        do_test(0,0);
        do_test(1,1);
        do_test(9,9);
        do_test(10,8'h10);
        do_test(11,8'h11);
        do_test(12,8'h12);
        do_test(16,8'h16);
        do_test(19,8'h19);
        do_test(20,8'h20);
        do_test(7321,16'h7321);
   end
endmodule
