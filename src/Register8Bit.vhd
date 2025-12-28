LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Register8Bit IS
    PORT(
        clk      : IN  std_logic;
        rst_n    : IN  std_logic; -- Active Low Reset
        data_in  : IN  std_logic_vector(7 DOWNTO 0);
        data_out : OUT std_logic_vector(7 DOWNTO 0)
    );
END Register8Bit;

ARCHITECTURE RTL OF Register8Bit IS
BEGIN
    PROCESS(clk, rst_n)
    BEGIN
        -- Asynchronous Active-Low Reset
        IF rst_n = '0' THEN
            data_out <= (others => '0');
            
        -- Synchronous Loading on Rising Edge
        ELSIF rising_edge(clk) THEN
            data_out <= data_in;
        END IF; 
    END PROCESS;
END RTL;