module binary2bcd(input wire [15:0] data_in, output [15:0] data_out);

   function [3:0] norm(input [3:0] arg);
   begin
      norm = arg;
      if (arg > 4'd4)
        norm = arg + 4'd3;
   end
   endfunction

   function [15:0] bcd_norm(input [15:0] arg);
      begin
         bcd_norm =  { norm(arg[15:12]), norm(arg[11:8]), norm(arg[7:4]), norm(arg[3:0]) };
      end
   endfunction

   function [31:0] stage(input [31:0] state);
      reg [31:0] r;
      begin
      r = state;
      r[31:16] = bcd_norm(state[31:16]);
      stage = r << 1;
      end
   endfunction

   wire [31:0]    state[0:16];
   assign state[0] = {16'h0, data_in};

   generate
      genvar     i;
      for (i = 0; i < 16; i = i + 1)
        begin :gen_loop
        assign state[i+1] = stage(state[i]);
        end
   endgenerate

   assign data_out = state[16][31:16];
endmodule
