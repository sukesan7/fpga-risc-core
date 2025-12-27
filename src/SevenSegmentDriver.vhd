LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg IS
PORT(
	bcd : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
	neg : IN STD_LOGIC;
	negled : OUT STD_LOGIC_VECTOR(0 To 6);
	leds : OUT STD_LOGIC_VECTOR (0 TO 6));
END sseg;

ARCHITECTURE Behaviour OF sseg IS
BEGIN
PROCESS (bcd, neg)
BEGIN

CASE bcd IS 		-- abcdef g
	WHEN "0000" => leds <= "0000001";
	WHEN "0001" => leds <= "1001111";
	WHEN "0010" => leds <= "0010010";
	WHEN "0011" => leds <= "0000110";
	WHEN "0100" => leds <= "1001100";
	WHEN "0101" => leds <= "0100100";
	WHEN "0110" => leds <= "0100000";
	WHEN "0111" => leds <= "0001111";
	WHEN "1000" => leds <= "0000000";
	WHEN "1001" => leds <= "0001100";
	WHEN OTHERS => leds <= "-------";
END CASE;

CASE neg IS
	WHEN '1' => negled <= "1111110";
	WHEN OTHERS => negled <= "1111111";
END CASE;
END PROCESS;
END Behaviour;

-- Unmodified ABCDEF
	--WHEN "0000" => leds <= "1111110";
	--WHEN "0001" => leds <= "0110000";
	--WHEN "0010" => leds <= "1101101";
	--WHEN "0011" => leds <= "1111001";
	--WHEN "0100" => leds <= "0110011";
	--WHEN "0101" => leds <= "1011011";
	--WHEN "0110" => leds <= "1011111";
	--WHEN "0111" => leds <= "1110000";
	--WHEN "1000" => leds <= "1111111";
	--WHEN "1001" => leds <= "1110011";
	--WHEN OTHERS => leds <= "-------";

	--WHEN "0000" => leds <= "0000001";
	--WHEN "0001" => leds <= "1001111";
	--WHEN "0010" => leds <= "0010010";
	--WHEN "0011" => leds <= "0000110";
	--WHEN "0100" => leds <= "1001100";
	--WHEN "0101" => leds <= "0100100";
	--WHEN "0110" => leds <= "0100000";
	--WHEN "0111" => leds <= "0001111";
	--WHEN "1000" => leds <= "0000000";
	--WHEN "1001" => leds <= "0001100";
	--WHEN OTHERS => leds <= "-------";