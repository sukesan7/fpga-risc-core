library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU_Problem2 is
port(
	clock: in std_logic;
	A, B: in unsigned(7 downto 0);
	student_id: in unsigned (3 downto 0);
	op: in unsigned(15 downto 0);
	carry, neg: out std_logic;
	R1: out unsigned(3 downto 0); --first 4bits from 8bit
	R2: out unsigned(3 downto 0)); --other 4bits from 8bit
end ALU_Problem2;

architecture calculation of ALU_Problem2 is
	signal reg1, reg2, result: unsigned(7 downto 0) := (others => '0');
	signal temp: unsigned(8 downto 0) := (others => '0');
	begin
		Reg1 <= A; --temp store A in reg1
		Reg2 <= B; --temp store B in reg2
		process(clock, op)
		begin
			if(rising_edge(clock)) then --Table F
				CASE OP IS
			WHEN "0000000000000001" => --decrement B by 9
				if (Reg2 < 9) then
					neg <= '1';
					Result <= (9 - Reg2);
				else
					neg <= '0';
					Result <= (Reg2 - 9);
				end if;
			WHEN "0000000000000010"  => --swap the lower and upper 4 bits of B
				Result <= Reg2(3 DOWNTO 0) & Reg2(7 DOWNTO 4); --lower 4bit of B, upper 4bit of B
			WHEN "0000000000000100" =>--shift A to the left by 2 bits, input bit = 0
				Result <= Reg1(5 downto 0) & "00"; --input bit is entering numbers
			WHEN "0000000000001000" =>--produce the result of NANDing A and B
				Result <= Reg1 NAND Reg2;
			WHEN "0000000000010000" =>--Find the greater value of A and B, produce results
				if Reg1 > Reg2 then	
					Result <= Reg1;
				else
					Result <= Reg2;
				end if;
			WHEN "0000000000100000" =>--Invert the even bits of B
				Result <= Reg2(7) & (not Reg2(6)) & Reg2(5) & (not Reg2(4)) & Reg2(3) & (not Reg2(2)) & Reg2(1) & (not Reg2(0)); --NOT (invert) the odd ones in the 8bit
			WHEN "0000000001000000" =>--Produce null on the output
				Result <= (others => '0');
			WHEN "0000000010000000" =>--Replace the upper four bits of B by upper four bits of A
				Result <= Reg1(7 downto 4) & Reg2(3 downto 0); --A upper bits, and B lower bits
			WHEN "0000000100000000" =>--Show A on the output
				Result <= Reg1;
			WHEN OTHERS =>-- Don't care
			END CASE;
		END IF;
	END PROCESS;
	
	R1 <= Result(3 DOWNTO 0);
	R2 <= Result(7 DOWNTO 4);

END calculation;