module engine_pgm(input logic clk, input logic rst, input logic load,
                  input logic  dack, input logic stop, output logic pre,
                  output logic done, output logic acc);

   typedef enum  bit [3:0]  {IDLE, START, COMP, VALID, XXX} state_t;
   state_t state, next;

   always_ff @(posedge clk)
     if (rst)
       state <= IDLE;
     else
       state <= next;

   always_comb
     begin
        next = XXX;
        case (state)
          IDLE:  if (load)          next = START;
                 else               next = IDLE;
          START: if (!load)         next = COMP;
                 else               next = START;
          COMP:  if (!load && stop) next = VALID;
                 else               next = COMP;
          VALID: if (dack)          next = IDLE;
                 else               next = VALID;
        endcase
     end

   assign acc = (state == START) || (state == COMP);
   assign done = (state == VALID);
   assign pre = (state == IDLE);

endmodule
