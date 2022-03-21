`default_nettype none

module skullfet_inverter (
`ifdef USE_POWER_PINS
    input VGND,
    input VPWR,
`endif  // USE_POWER_PINS
    input wire A,
    output wire Y
);
`ifdef USE_POWER_PINS
  wire power_good = VPWR == 1 && VGND == 0;
`else
  wire power_good = 1'b1;
`endif  // USE_POWER_PINS

  wire buf_not_A;
  buf buf0 (buf_not_A, !A);
  assign Y = power_good ? buf_not_A : 1'bx;
endmodule

module skullfet_inverter_10x (
`ifdef USE_POWER_PINS
    input VGND,
    input VPWR,
`endif  // USE_POWER_PINS
    input wire A,
    output wire Y
);
`ifdef USE_POWER_PINS
  wire power_good = VPWR == 1 && VGND == 0;
`else
  wire power_good = 1'b1;
`endif  // USE_POWER_PINS

  wire buf_not_A;
  buf buf0 (buf_not_A, !A);
  assign Y = power_good ? buf_not_A : 1'bx;
endmodule

module skullfet_nand (
`ifdef USE_POWER_PINS
    input VGND,
    input VPWR,
`endif  // USE_POWER_PINS
    input wire A,
    input wire B,
    output wire Y
);
`ifdef USE_POWER_PINS
  wire power_good = VPWR == 1 && VGND == 0;
`else
  wire power_good = 1'b1;
`endif  // USE_POWER_PINS

  wire nand_out = !(A & B); 
  wire nand_out_pg = power_good ? nand_out : 1'bx;
  buf buf0 (Y, nand_out_pg);
endmodule
