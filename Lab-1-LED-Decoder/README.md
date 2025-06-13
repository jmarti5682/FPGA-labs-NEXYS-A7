# LAB 1: Seven-Segment Decoder

The main purpose of this lab is to first introduce you to using the FPGA board and seeing actual results. It was really neat the first I got around to it. For this lab, we are focusing on the
seven-segment display. We are going to first using it to display 0-F in binary using the on-board dip switches. Then we are going to create a counter that counts from 0 to F.

## Project 1:
For the first part of the project we are simply following the directions from the [GitHub page](https://github.com/byett/dsd/tree/CPE487-Fall2024/Nexys-A7/Lab-1) that is found on the main README doc. 

Now as for the translation from VHDL to SystemVerilog: 

First we have to translate the ports that we created in `leddec.vhd`

##### VHDL
```
ENTITY leddec IS
	PORT (
		dig : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
	);
END leddec;
```
##### SystemVerilog
Now in SystemVerilog the Entity and Architecture bits are combined, but for simplicity sake, we'll first look at the Entity part first. In SystemVerilog, we use **modules** to define
inputs, outputs, logic, etc. Now from our VHDL program, we have an `ENTITY` `leddec`, which has four total ports, we have two inputs (`dig`, `data`) and two outputs (`anode`, `seg`). Also take note that we are dealing with 
`STD_LOGIC_VECTOR`s meaning it's an array of bits, where each bit is of type `STD_LOGIC`. 

  Lets take the first port `dig` and translate it into SystemVerilog: 
  - `dig : IN STD_LOGIC_VECTOR (2 DOWNTO 0);` From this we can see it is a 3 bit array that defines which of the 8 digits on the 7-segment display its going to activate.
	- `input [2:0] dig` is how we would translate the following into SystemVerilog. Like in the VHDL code, we are going `2 DOWNTO 0` therefore, we place the `2` first in the brackets, followed by the `0`. This would be reversed if it was `UPTO`. TLDR, we are making `2` the MSB and `0` the LSB. Following the VHDL code, we see that the `data` port follows the same convention.
  - `anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);` This is where things slighty change. One would think you would just do `output [7:0] anode`, however, we just need to add one more thing, `logic`. Essentially what `logic` does is allow us to hold a value until it has changed. This is important because we are using `anode` inside an `always` block. It is important to note that `logic` is a SystemVerilog feature because in Verilog, you would have to define it as either a `wire` or a `reg`, in this case, it would be a `reg`.
	- TLDR: `anode: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);` == `output logic [7:0] anode` : `seg` also follows this convention

Putting everything together we get:
```
module leddec
(input [2:0] dig,
 input [3:0] data,
 output logic [7:0] anode,
 output logic [6:0] seg
);

endmodule: leddec
```

Now we can focus on the second part of the program, the conditional. 
##### VHDL
```
ARCHITECTURE Behavioral OF leddec IS
BEGIN
	-- Turn on segments corresponding to 4-bit data word
	seg <= "0000001" WHEN data = "0000" ELSE -- 0
	       "1001111" WHEN data = "0001" ELSE -- 1
	       "0010010" WHEN data = "0010" ELSE -- 2
	       "0000110" WHEN data = "0011" ELSE -- 3
	       "1001100" WHEN data = "0100" ELSE -- 4
	       "0100100" WHEN data = "0101" ELSE -- 5
	       "0100000" WHEN data = "0110" ELSE -- 6
	       "0001111" WHEN data = "0111" ELSE -- 7
	       "0000000" WHEN data = "1000" ELSE -- 8
	       "0000100" WHEN data = "1001" ELSE -- 9
	       "0001000" WHEN data = "1010" ELSE -- A
	       "1100000" WHEN data = "1011" ELSE -- B
	       "0110001" WHEN data = "1100" ELSE -- C
	       "1000010" WHEN data = "1101" ELSE -- D
	       "0110000" WHEN data = "1110" ELSE -- E
	       "0111000" WHEN data = "1111" ELSE -- F
	       "1111111";
	-- Turn on anode of 7-segment display addressed by 3-bit digit selector dig
	anode <= "11111110" WHEN dig = "000" ELSE -- 0
	         "11111101" WHEN dig = "001" ELSE -- 1
	         "11111011" WHEN dig = "010" ELSE -- 2
	         "11110111" WHEN dig = "011" ELSE -- 3
	         "11101111" WHEN dig = "100" ELSE -- 4
	         "11011111" WHEN dig = "101" ELSE -- 5
	         "10111111" WHEN dig = "110" ELSE -- 6
	         "01111111" WHEN dig = "111" ELSE -- 7
	         "11111111";
END Behavioral;
```

##### SystemVerilog
Remember, in SystemVerilog, our module combines the `ENTITY` and `ARCHITECTURE` parts of VHDL, therefore we are going to add the `ARCHITECTURE` part to our module in SystemVerilog. Since we are dealing with a decoder (3:8 decoder in particular), we are dealing with combinational logic. Looking at the VHDL code, we see we have a series of `WHEN...ELSE` statements that determine the what and where of the program. These are concurrent signal assignments meaning that they are continuously updated whenever there is a change in `data` or `dig`. In SystemVerilog, there is no `WHEN...ELSE` statements or concurrent assignment, therefore we solve this using the `always` procedural block. Since `data` and `dig` is what determines the what and the where, we can call these our events in the sensitivity list (the things inside the parentheses of the `always`). 

- `always @ (data, dig)`

Then like in VHDL we follow up with a `begin` and an `end`.

```
  always @ (data, dig)
  begin
  
  end
```
**NOTE** : `always @ (data, dig)` can be replaced by `always_comb` in SystemVerilog. The main difference is that `always_comb` will automatically fill in the sensitivity list for you. 

The actual `WHEN...ELSE` statements are a bit confusing to translate into verilog, at least I found it to be at first. However, let's first understand what exactly is going on in our `WHEN...ElSE` statements. 
```
seg <= "0000001" WHEN data = "0000" ELSE -- 0
```
So **WHEN** `data` is equal to `0000` we set `seg` to `0000001` (the corresponding LED Segment Code CA-CG) followed by the **ELSE**. The **ELSE** is acting as a `else if` in a traditional if/else if/else structure, thus it allows us to create this chain of `WHEN...ELSE` statements. Then when we get to the last statement, we get the else case of `1111111`, which just signifies to turn off the display (a condition that is never met). 

In SystemVerilog, we first want to address what the case expression is, in this case it is `data`. We are going to create a case that looks at `data` and changes `seg` accordingly. 
```
case(data)
...
endcase
```
To write out binary numbers in SystemVerilog, we have to follow this convention `4'b000`. First we have an optional size value, followed by an `'` and then the acutal binary value. We have an input of a 4-bit binary value which then translates into a 7-bit binary value. Putting this together we get:
```
4'b0000 : seg <= 7'b0000001; // 0
```
Again, this is saying when `data` is `0000`, set `seg` to `0000001`. Now, we can finally create our case structure:
```
case(data)
	4'b0000 : seg <= 7'b0000001; // 0
        4'b0001 : seg <= 7'b1001111; // 1
        4'b0010 : seg <= 7'b0010010; // 2
        4'b0011 : seg <= 7'b0000110; // 3
        4'b0100 : seg <= 7'b1001100; // 4
        4'b0101 : seg <= 7'b0100100; // 5
        4'b0110 : seg <= 7'b0100000; // 6
        4'b0111 : seg <= 7'b0001111; // 7
        4'b1000 : seg <= 7'b0000000; // 8
        4'b1001 : seg <= 7'b0000100; // 9
        4'b1010 : seg <= 7'b0001000; // A
        4'b1011 : seg <= 7'b1100000; // B
        4'b1100 : seg <= 7'b0110001; // C
        4'b1101 : seg <= 7'b1000010; // D
        4'b1110 : seg <= 7'b0110000; // E
        4'b1111 : seg <= 7'b0111000; // F
        default : seg <= 7'b1111111;
endcase 
```
The same can be done for `anode` with it being dependent on the case expression `dig`. 

```
case(dig)
        3'b000 : anode <= 8'b11111110; // 0
        3'b001 : anode <= 8'b11111101; // 1
        3'b010 : anode <= 8'b11111011; // 2
        3'b011 : anode <= 8'b11110111; // 3
        3'b100 : anode <= 8'b11101111; // 4
        3'b101 : anode <= 8'b11011111; // 5
        3'b110 : anode <= 8'b10111111; // 6
        3'b111 : anode <= 8'b01111111; // 7
        default: anode <= 8'b11111111;
    endcase
```
Lastly, we can go ahead and place those case structures inside of our module and call it a day! You can refer to the `leddec.vs` file to see everything together. 

#### Example Image:
![F](assets/lab1/F.png)

## Project 2: 
