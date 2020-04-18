
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clock_divider is
end tb_clock_divider;

architecture Behavioral of tb_clock_divider is


component ClockDivider
    generic (   
        fin:integer range 50000000 to 125000000 := 50000000;    --Default value 50MHz
        fout:integer range 1 to 10000000 := 1000                --Default value 1kHz
    );
    Port ( clk : in std_logic;
           reset : in std_logic;
           duty: in std_logic_vector(3 downto 0);
           newClock : out std_logic);
end component;


signal reset: std_logic;
signal clk: std_logic;
signal duty: std_logic_vector(3 downto 0);

constant TbPeriod : time := 20 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';


begin

dut : ClockDivider
generic map(fin => 50000000, fout=> 2000)
port map (reset => reset,
          clk => clk,
          duty => duty
        );
      
-- Clock generation
TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

-- EDIT: Check that Clk is really your main clock signal
Clk <= TbClock;

stimuli : process
    begin
    -- EDIT Adapt initialization as needed
    duty <= (others => '0');

    -- Reset generation
    -- EDIT: Check that Reset is really your reset signal
    Reset <= '1';
    duty <= "1000";
    wait for 100 ns;
    Reset <= '0';
    wait for 100 ns;

    -- EDIT Add stimuli here
    wait for 1 ms;
    duty <= "1111";
    wait for 2 ms;
    duty <= "0000";
    wait for 2 ms;
    duty <= "0001";
    wait for 1 ms;
    duty <= "0010";
    wait for 1 ms;
    duty <= "0011";
    wait for 1 ms;
    duty <= "0100";
    wait for 1 ms;
    duty <= "0101";
    wait for 1 ms;
    duty <= "0110";
    wait for 1 ms;
    duty <= "0111";
    wait for 1 ms;
    duty <= "1000";
    wait for 1 ms;
    duty <= "1001";
    wait for 1 ms;
    duty <= "1010";
    wait for 1 ms;
    duty <= "1011";
    wait for 1 ms;
    duty <= "1100";
    wait for 1 ms;
    duty <= "1101";
    wait for 1 ms;
    duty <= "1110";
    wait for 5 ms;

    
    -- Stop the clock and hence terminate the simulation
    TbSimEnded <= '1';
    wait;
end process;

end Behavioral;


