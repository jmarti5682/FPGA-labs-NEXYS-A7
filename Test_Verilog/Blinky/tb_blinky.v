`timescale 10ns/ 100ps

module tb_blinky();
    reg clk10;
    reg dip;
    wire led;
    
    blinky dut (.clk10 (clk10), .dip (dip), .led (led));
    
    initial
        begin
            clk10 <= 0;
            dip   <= 0;
        end
        
    always
        begin
        
        #5 // wait for 5 time units => 50ns
        clk10 = ~clk10;
        
        end    
endmodule
