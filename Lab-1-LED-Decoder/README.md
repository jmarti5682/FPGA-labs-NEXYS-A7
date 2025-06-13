# LAB 1: Seven-Segment Decoder

The main purpose of this lab is to first introduce you to using the FPGA board and seeing actual results. It was really neat the first I got around to it. For this lab, we are focusing on the
seven-segment display. We are going to first using it to display 0-F in binary using the on-board dip switches. Then we are going to create a counter that counts from 0 to F.

## Project 1:
For the first part of the project we are simply following the directions from the GitHub page that is found on the main README doc. 

Now as for the translation from VHDL to SystemVerilog: 

First we have to translate the ports that we created in `leddec.vhd`

#### VHDL:
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
### SystemVerilog
Now in SystemVerilog the Entity and Architecture bits are combined, but for simplicity sake, we'll first look at the Entity part first. In SystemVerilog, we use **modules** to define
inputs, outputs, logic, etc. Now from our VHDL program, we have an `ENTITY` `leddec`, which has four total ports, we have two inputs (`dig`, `data`) and two outputs (`anode`, `seg`). Also take note that we are dealing with 
`STD_LOGIC_VECTOR`s meaning it's an array of bits, where each bit is of type `STD_LOGIC`. 

  Lets take the first port `dig` and translate it into SystemVerilog: 
  - `dig : IN STD_LOGIC_VECTOR (2 DOWNTO 0);` From this we can see it is a 3 bit array that defines which of the 8 digits on the 7-segment display its going to activate.
	- `input [2:0] dig` is how we would translate the following into SystemVerilog. Like in the VHDL code, we are going `2 DOWNTO 0` therefore, we place the `2` first in the brackets, followed by the `0`. This would be reversed if it was `UPTO`. TLDR, we are making `2` the MSB and `0` the LSB. Following the VHDL code, we see that the `data` port follows the same convention.
  - `anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);` This is where things slighty change. One would think you would just do `output [7:0] anode`, however, we just need to add one more thing, `logic`. Essentially what `logic` does is allow us to hold a value until it has changed. This is important because we are using `anode` inside an `always` block. It is important to note that `logic` is a SystemVerilog feature because in Verilog, you would have to define it as either a `wire` or a `reg`, in this case, it would be a `reg`.
	- TLDR: `anode: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);` == `output logic [7:0] anode` : `seg` also follows this convention
  - 



## Project 2: 
