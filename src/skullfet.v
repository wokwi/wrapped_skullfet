(* blackbox *)
module skullfet_inverter (
`ifdef USE_POWER_PINS
    input  VGND,
    input  VPWR,
`endif  // USE_POWER_PINS
    input  A,
    output Y
);
endmodule
