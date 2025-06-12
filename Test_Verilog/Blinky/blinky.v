module blinky(
    input CLK100MHZ,
    input SW_0,
    output LED_0
    );
    
    reg [31:0] counter = 0;
    reg ledState = 0;
    
    assign LED_0 = ledState;
    
    always @ (posedge CLK100MHZ)
    begin
    
        counter <= counter + 1;
        
        if (SW_0)
            ledState <= counter[22];
        else
            ledState <= counter[23];
        
    end
    
endmodule
