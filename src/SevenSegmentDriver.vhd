LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SevenSegmentDriver IS
    PORT(
        hex_digit : IN  std_logic_vector(3 DOWNTO 0);
        segments  : OUT std_logic_vector(6 DOWNTO 0) -- gfedcba
    );
END SevenSegmentDriver;

ARCHITECTURE Behavioral OF SevenSegmentDriver IS
BEGIN
    PROCESS(hex_digit)
    BEGIN
        CASE hex_digit IS
            WHEN "0000" => segments <= "1000000"; -- 0
            WHEN "0001" => segments <= "1111001"; -- 1
            WHEN "0010" => segments <= "0100100"; -- 2
            WHEN "0011" => segments <= "0110000"; -- 3
            WHEN "0100" => segments <= "0011001"; -- 4
            WHEN "0101" => segments <= "0010010"; -- 5
            WHEN "0110" => segments <= "0000010"; -- 6
            WHEN "0111" => segments <= "1111000"; -- 7
            WHEN "1000" => segments <= "0000000"; -- 8
            WHEN "1001" => segments <= "0010000"; -- 9
            WHEN "1010" => segments <= "0001000"; -- A
            WHEN "1011" => segments <= "0000011"; -- b
            WHEN "1100" => segments <= "1000110"; -- C
            WHEN "1101" => segments <= "0100001"; -- d
            WHEN "1110" => segments <= "0000110"; -- E
            WHEN "1111" => segments <= "0001110"; -- F
            WHEN OTHERS => segments <= "1111111"; -- Off
        END CASE;
    END PROCESS;
END Behavioral;