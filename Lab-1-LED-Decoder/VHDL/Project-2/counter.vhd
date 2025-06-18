LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter IS
	PORT (
		clk : IN STD_LOGIC;
		count : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- 4 bit counter, counts from 0-F
		dig_out : OUT STD_LOGIC_VECTOR (2 DOWNTO 0) -- 3 bit counter, counts for dig
	);
END counter;

ARCHITECTURE Behavioral OF counter IS
	SIGNAL cnt : STD_LOGIC_VECTOR (28 DOWNTO 0); -- 29 bit counter
BEGIN
	PROCESS (clk)
	BEGIN
		IF clk'EVENT AND clk = '1' THEN -- on rising edge of clock
			cnt <= cnt + 5; -- increment counter
		END IF;
	END PROCESS;
	count <= cnt (28 DOWNTO 25); -- Has to be 4 bits long
	dig_out <= cnt (28 DOWNTO 26); -- Has to be 3 bits long
END Behavioral;
