library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
    generic (
        depth : integer range 1 to 100 := 2
    );
    Port ( clk : in std_logic;
           reset : in std_logic;
           input : in std_logic;
           output : out std_logic
    );
end ShiftRegister;




architecture Behavioral of ShiftRegister is

signal sr : std_logic_vector(depth - 2 downto 0);
 
begin
 
process(clk, reset)
begin

if(reset = '1') then
    output <= '0';
elsif (clk = '1' and clk'event) then
    sr <= sr(sr'high - 1 downto sr'low) & input;
    output <= sr(sr'high);
end if;
end process;

end Behavioral;
