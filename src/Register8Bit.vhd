library ieee;
use ieee.std_logic_1164.all;
entity storage is
port(
	A: in std_logic_vector(7 downto 0); -- 8bit A input
	Resetn, Clock: in std_logic; --1 bit clock input and 1bit reset input
	Q: out std_logic_vector(7 downto 0)); --8bit output
end storage;
architecture behaviour of storage is
begin
PROCESS(Resetn, Clock)
	BEGIN
		IF Resetn = '0' THEN
			Q <= "00000000";
		ELSIF Clock'EVENT AND Clock = '1' THEN
			Q <= A;
		END IF;	
	END PROCESS;
end behaviour;