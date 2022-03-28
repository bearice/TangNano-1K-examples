module led (
    input sys_clk,
    input sys_rst_n,
    output LED_R,
    output LED_G,
    output LED_B
);

reg [31:0] counter;
//reg [25:0] counter;
reg [7:0] max;
reg [7:0] red;
reg [7:0] blue;
reg [7:0] green;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        counter <= 0;
        max <= 255;
        red <= 100;
        blue <= 100;
        green <= 100;
    end
    else if (counter < 31'd1350_000)       // 0.05s delay
        counter <= counter + 1;
    else begin
        counter <= 0;
        red <= red+1;
        blue <= blue+2;
        green <= green+3;
    end
end

pwm pwm_red(
    .clk (sys_clk),
    .reset (sys_rst_n),
    .threshold (red),
    .max (max),
    .pwm (LED_R)
);

pwm pwm_green(
    .clk (sys_clk),
    .reset (sys_rst_n),
    .threshold (blue),
    .max (max),
    .pwm (LED_G)
);

pwm pwm_blue(
    .clk (sys_clk),
    .reset (sys_rst_n),
    .threshold (green),
    .max (max),
    .pwm (LED_B)
);

//assign LED_B = blue[4];

endmodule


