# Blinky - Verilog Nexys A7-100T

This is my first real Verilog program, written after following the YouTube tutorial by Phil's Lab:  
🔗 [ FPGA Design Tutorial (Verilog, Simulation, Implementation) - Phil's Lab #109 ](https://www.youtube.com/watch?v=msXKWn24TN4)

I modified the example code to use the Nexys A7-100T clock, switch, and led. 

The program blinks an led `LED_0` on and off at different speeds depending if the dip switch `SW_0` is set to the **HIGH** or **LOW** position on the board. 

- If the switch is set to **LOW**, the LED blinks every 0.1678 seconds
- If the switch is set to **HIGH**, the LED blinks every 0.0838 seconds

The program contains a 32 bit counter `counter` that increments every clock cycle on a 100 Mhz clock (default clock speed for this board). The rate of which the LED is blinking is 
affected from which bit it is looking at depending on the state of the switch (either `counter[22]`, `counter[23]`).
  



