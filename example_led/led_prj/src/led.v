module led (
    input sys_clk,
    input sys_rst_n,
    output LED_R,
    output LED_G,
    output LED_B
);

reg [31:0] counter;
wire [7:0] r;
wire [7:0] g;
wire [7:0] b;
reg [7:0] h;
wire [7:0] s = 255;
wire [7:0] v = 255;
wire [7:0] max = 255;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        counter <= 0;
        h <= 0;
    end
    else if (counter < 31'd1350_00)       // 0.005s delay
        counter <= counter + 1;
    else begin
        counter <= 0;
        h <= h+1;
    end
end

hsv2rgb (
    .r(r), .g(g), .b(b),
    .h(h), .s(s), .v(v)
);

pwm #(8) pwm_r (
    .clk (sys_clk),
    .reset (sys_rst_n),
    .threshold (r),
    .max (max),
    .pwm (LED_R)
);

pwm #(8) pwm_g(
    .clk (sys_clk),
    .reset (sys_rst_n),
    .threshold (g),
    .max (max),
    .pwm (LED_G)
);

pwm #(8) pwm_b(
    .clk (sys_clk),
    .reset (sys_rst_n),
    .threshold (b),
    .max (max),
    .pwm (LED_B)
);

endmodule


