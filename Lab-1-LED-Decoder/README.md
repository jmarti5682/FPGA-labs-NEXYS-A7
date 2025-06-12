# LAB 1: Seven-Segment Decoder

The main purpose of this lab is to first introduce you to using the FPGA board and seeing actual results. It was really neat the first I got around to it. For this lab, we are focusing on the
seven-segment display. We are going to first using it to display 0-F in binary using the on-board dip switches. Then we are going to create a counter that counts from 0 to F.

## Project 1:
For the first part of the project we are simply following the directions from the GitHub page that is found on the main README doc. 

Now as for the translation from VHDL to System Verilog: 

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
### System Verilog
Now in System Verilog the Entity and Architecture bits are combined, but for simplicity sake, we'll first look at the Entity part first. In System Verilog, we use **modules** to define
inputs, outputs, logic, etc. Now from our VHDL program, we have an `ENTITY` `leddec`, which has four total ports, we have two inputs (`dig`, `data`) and two outputs (`anode`, `seg`). Also take note that we are dealing with 
`STD_LOGIC_VECTOR`s meaning its an array of bits, where each bit is of type `STD_LOGIC`. 

  Lets take the first port `dig` and translate it into System Verilog: 
  - `dig : IN STD_LOGIC_VECTOR (2 DOWNTO 0);` From this we can see it is a 3 bit array that defines the digit



## Project 2: 
