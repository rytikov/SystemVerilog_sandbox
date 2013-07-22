module binary2bcd(input wire [15:0] data_in, output reg [15:0] data_out);

   function [15:0] bcd_norm(input [15:0] arg);
      automatic reg [15:0] r = arg;

      if (r[3:0] > 4'd4)
        r[3:0] = r[3:0] + 4'd3;

      if (r[7:4] > 4'd4)
        r[7:4] = r[7:4] + 4'd3;

      if (r[11:8] > 4'd4)
        r[11:8] = r[11:8] + 4'd3;

      if (r[15:12] > 4'd4)
        r[15:12] = r[15:12] + 4'd3;

      return r;
   endfunction

   function [31:0] stage(input [31:0] stage_state);
      stage_state[31:16] = bcd_norm(stage_state[31:16]);
      stage_state <<= 1;
      return stage_state;
   endfunction

   reg [31:0]    state[0:16];

   assign state[0] = {16'h0, data_in};

   generate
      genvar     i;
      for (i = 0; i < 16; i = i + 1)
        assign state[i+1] = stage(state[i]);
   endgenerate

   assign data_out = state[16][31:16];
endmodule
