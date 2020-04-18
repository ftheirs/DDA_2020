library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_shift_register is
end tb_shift_register;

architecture Behavioral of tb_shift_register is

component ShiftRegister
    generic (
        depth : integer range 1 to 100 := 2
    );
    Port ( clk : in std_logic;
           reset : in std_logic;
           input : in std_logic;
           output : out std_logic
    );
end component;


signal reset: std_logic;
signal clk: std_logic;
signal input: std_logic;

constant TbPeriod : time := 20 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';


begin

dut : ShiftRegister
generic map(depth => 10)
port map (reset => reset,
          clk => clk,
          input => input
        );
      
-- Clock generation
TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

-- EDIT: Check that Clk is really your main clock signal
Clk <= TbClock;

stimuli : process
    begin
    -- EDIT Adapt initialization as needed
    input <= '0';

    -- Reset generation
    -- EDIT: Check that Reset is really your reset signal
    Reset <= '1';
    wait for 100 ns;
    Reset <= '0';
    wait for 100 ns;

    -- EDIT Add stimuli here
    wait for 10 ns;
    input <= '1';
    wait for 10 ns;
    input <= '0';
    wait for 10 ns;
    input <= '1';    
    wait for 10 ns;
    input <= '0';    
    wait for 10 ns;
    input <= '1';    
    wait for 10 ns;
    input <= '0';
    wait for 10 ns;
    input <= '1';
    wait for 10 ns;
    input <= '0';
    wait for 10 ns;
    input <= '1';
    wait for 100 ns;
    input <= '1';                    
       
       
    wait for 100 ns;
  
  
    wait for 10 ns;
    input <= '1';
    wait for 10 ns;
    input <= '0';
    wait for 10 ns;
    input <= '1';    
    wait for 10 ns;
    input <= '0';    
    wait for 10 ns;
    input <= '1';    
    wait for 10 ns;
    input <= '0';
    wait for 10 ns;
    input <= '1';
    wait for 10 ns;
    input <= '0';
    wait for 10 ns;
    input <= '1';
    wait for 10 ns;
    input <= '0';     
  
  
  

    wait for 10 ms;
    -- Stop the clock and hence terminate the simulation
    TbSimEnded <= '1';
    wait;
end process;

end Behavioral;