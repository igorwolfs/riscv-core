`timescale 1ns/10ps

module imemory (
    input clkin,
    // read
    input rd_idx_in,
    output rd_data_out
);

reg [255:0] RAM;

assign rd_data_out = RAM[rd_idx_in];

endmodule
