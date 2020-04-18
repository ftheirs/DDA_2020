library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEF_System is
    Port ( 
    clk: in std_logic;
    reset: in std_logic;
    button: in std_logic;
    
    saveR: out std_logic;
    saveG: out std_logic;
    saveB: out std_logic;
    
    showRGB: out std_logic
    );
end MEF_System;

architecture Behavioral of MEF_System is
	type MEFState is (s0, s1, s2, s3, s4, s5);
	signal state : MEFState;

begin

process (clk,reset)
begin
if (reset ='1') then state <=s0;
elsif (clk='1' and clk'event) then
    saveR <= '0';
    saveG <= '0';
    saveB <= '0';
    showRGB <= '0';

	case state is
	when s0 => 
	   showRGB <= '1';
	   if (button='1') then
	       state <= s1;
        end if;
	when s1 => 
        if (button='0') then
            state <= s2;
            saveR <= '1';
        end if;
	when s2 => 
        if (button='1') then
            state <= s3;
        end if;
	when s3 => 
        if (button='0') then
            state <= s4;
            saveG <= '1';
        end if;
	when s4 => 
        if (button='1') then
            state <= s5;
        end if;
	when s5 =>
        if (button='0') then
            state <= s0;
            saveB <= '1';
        end if;
    end case;            	
end if;
end process;

end behavioral;
