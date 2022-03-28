module pwm(
    input clk,
    input reset,
    input [7:0] threshold,
    input [7:0] max,
    output reg pwm
);
reg [7:0] counter;

always @ (posedge clk)
begin
    if (counter < threshold )
        pwm <= 1;
    else
        pwm <= 0;
end

always @ (posedge clk or negedge reset )
begin
    if (!reset)
        counter <= 0;
    else if (counter >= max )
        counter <= 0;
    else
        counter <= counter+1;
end

endmodule