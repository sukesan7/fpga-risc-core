LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSM_Controller IS
    PORT(
        clk           : IN  std_logic;
        rst_n         : IN  std_logic;
        trigger       : IN  std_logic;
        current_state : OUT std_logic_vector(3 DOWNTO 0)
    );
END FSM_Controller;

ARCHITECTURE Behavioral OF FSM_Controller IS
    TYPE state_type IS (S_IDLE, S_LOAD, S_EXEC, S_STORE); 
    SIGNAL state_reg, state_next : state_type;
BEGIN

    -- State Register
    PROCESS(clk, rst_n)
    BEGIN
        IF rst_n = '0' THEN
            state_reg <= S_IDLE;
        ELSIF rising_edge(clk) THEN
            state_reg <= state_next;
        END IF;
    END PROCESS;

    -- Next State Logic
    PROCESS(state_reg, trigger)
    BEGIN
        state_next <= state_reg;
        current_state <= "0000";

        CASE state_reg IS
            WHEN S_IDLE =>
                current_state <= "0001"; -- Display 1
                IF trigger = '1' THEN state_next <= S_LOAD; END IF;
            WHEN S_LOAD =>
                current_state <= "0010"; -- Display 2
                IF trigger = '1' THEN state_next <= S_EXEC; END IF;
            WHEN S_EXEC =>
                current_state <= "0100"; -- Display 4
                state_next <= S_STORE;   -- Auto transition
            WHEN S_STORE =>
                current_state <= "1000"; -- Display 8
                IF trigger = '0' THEN state_next <= S_IDLE; END IF;
            WHEN OTHERS =>
                state_next <= S_IDLE;
        END CASE;
    END PROCESS;
END Behavioral;