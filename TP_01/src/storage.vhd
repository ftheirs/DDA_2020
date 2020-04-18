library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Storage is
    generic (
        inputSize: integer range 0 to 31 := 3
    );
    Port ( clk : in std_logic;
           reset : in std_logic;
           storage: in std_logic;
           input : in std_logic_vector (inputSize downto 0);
           output : out std_logic_vector (inputSize downto 0));
end Storage;

architecture Behavioral of Storage is

signal storagedInput: std_logic_vector(inputSize downto 0) := (others => '0');

begin

process(clk, reset)
begin
if(reset = '1') then
    storagedInput <= (others => '0');
elsif (clk = '1' and clk'event) then
    if(storage = '1') then
        storagedInput <= input;
    end if;
end if;

end process;

output <= storagedInput;

end Behavioral;
