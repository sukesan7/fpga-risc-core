LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY TopLevel IS
    PORT(
        CLOCK_50 : IN  std_logic;
        SW       : IN  std_logic_vector(17 DOWNTO 0); -- A=15-8, B=7-0, Op=17-16
        KEY      : IN  std_logic_vector(3 DOWNTO 0);  -- 0=Rst, 1=Trigger
        LEDR     : OUT std_logic_vector(17 DOWNTO 0);
        HEX0     : OUT std_logic_vector(6 DOWNTO 0);  -- Result Low
        HEX1     : OUT std_logic_vector(6 DOWNTO 0);  -- Result High
        HEX4     : OUT std_logic_vector(6 DOWNTO 0)   -- FSM State
    );
END TopLevel;

ARCHITECTURE Structural OF TopLevel IS
    SIGNAL alu_res_hi, alu_res_lo : std_logic_vector(3 DOWNTO 0);
    SIGNAL fsm_state : std_logic_vector(3 DOWNTO 0);
    SIGNAL op_expanded : std_logic_vector(15 DOWNTO 0);
BEGIN
    -- Map Switches 17/16 to simple 1-hot opcode for demo
    -- 00=ADD, 01=SUB, 10=NAND, 11=XOR
    PROCESS(SW)
    BEGIN
        op_expanded <= (others => '0');
        CASE SW(17 DOWNTO 16) IS
            WHEN "00" => op_expanded(0) <= '1';
            WHEN "01" => op_expanded(1) <= '1';
            WHEN "10" => op_expanded(2) <= '1';
            WHEN "11" => op_expanded(3) <= '1';
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS;

    U_ALU: ENTITY work.ALU PORT MAP(
        clk => CLOCK_50, rst_n => KEY(0),
        op_code => op_expanded, A => SW(15 DOWNTO 8), B => SW(7 DOWNTO 0),
        result_high => alu_res_hi, result_low => alu_res_lo,
        flag_neg => LEDR(0), flag_err => LEDR(1)
    );

    U_FSM: ENTITY work.FSM_Controller PORT MAP(
        clk => CLOCK_50, rst_n => KEY(0), trigger => NOT KEY(1), -- Active Low Key
        current_state => fsm_state
    );

    U_HEX0: ENTITY work.SevenSegmentDriver PORT MAP(hex_digit => alu_res_lo, segments => HEX0);
    U_HEX1: ENTITY work.SevenSegmentDriver PORT MAP(hex_digit => alu_res_hi, segments => HEX1);
    U_HEX4: ENTITY work.SevenSegmentDriver PORT MAP(hex_digit => fsm_state, segments => HEX4);
END Structural;