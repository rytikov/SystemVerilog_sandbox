module engine(input logic clk, input logic rst,input load,
              input       int_types::INT04_t operand,
              output      int_types::INT41_t product,
              input logic pre, input logic acc, output logic stop);

   int_types::INT04_t term;

   always_ff @(posedge clk)
     begin
        if (rst)
          term <= '0;
        else if (load)
          term <= operand;
        else  if (acc)
          term <= term - 1;
     end

   always_ff @(posedge clk)
     begin
        if (pre)
          product <= 1;
        else if (acc)
          product <= product * term;
     end

   assign stop = (term == 1);

endmodule
