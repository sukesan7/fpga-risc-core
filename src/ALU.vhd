LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY ALU IS
    PORT(
        clk          : IN  std_logic;
        rst_n        : IN  std_logic;
        op_code      : IN  std_logic_vector(15 DOWNTO 0);
        A, B         : IN  std_logic_vector(7 DOWNTO 0);
        result_high  : OUT std_logic_vector(3 DOWNTO 0);
        result_low   : OUT std_logic_vector(3 DOWNTO 0);
        flag_neg     : OUT std_logic;
        flag_err     : OUT std_logic
    );
END ALU;

ARCHITECTURE RTL OF ALU IS
    SIGNAL A_uns, B_uns : unsigned(7 DOWNTO 0);
    SIGNAL res_uns      : unsigned(7 DOWNTO 0);
BEGIN
    A_uns <= unsigned(A);
    B_uns <= unsigned(B);

    PROCESS(clk, rst_n)
    BEGIN
        IF rst_n = '0' THEN
            res_uns  <= (others => '0');
            flag_neg <= '0';
            flag_err <= '0';
        ELSIF rising_edge(clk) THEN
            flag_neg <= '0';
            flag_err <= '0';
            
            -- Simplified Opcode Mapping for Demo
            -- Map specific bits of op_code to operations
            IF op_code(0) = '1' THEN      -- ADD
                res_uns <= A_uns + B_uns;
            ELSIF op_code(1) = '1' THEN   -- SUB
                IF A_uns < B_uns THEN
                    res_uns  <= B_uns - A_uns;
                    flag_neg <= '1';
                ELSE
                    res_uns <= A_uns - B_uns;
                END IF;
            ELSIF op_code(2) = '1' THEN   -- NAND
                res_uns <= A_uns NAND B_uns;
            ELSIF op_code(3) = '1' THEN   -- XOR
                res_uns <= A_uns XOR B_uns;
            ELSE
                res_uns <= (others => '0');
            END IF;
        END IF;
    END PROCESS;

    result_low  <= std_logic_vector(res_uns(3 DOWNTO 0));
    result_high <= std_logic_vector(res_uns(7 DOWNTO 4));
END RTL;