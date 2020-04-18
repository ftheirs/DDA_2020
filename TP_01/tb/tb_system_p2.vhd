library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_system_p2 is
end tb_system_p2;


architecture Behavioral of tb_system_p2 is

component SystemP2
    Port(
        clk: in std_logic;
        reset: in std_logic;
        switch: in std_logic_vector(3 downto 0);
        button: in std_logic;
        
        pwm_red: out std_logic;
        pwm_green: out std_logic;
        pwm_blue: out std_logic
    );
end component;


signal reset: std_logic;
signal clk: std_logic;
signal switch: std_logic_vector(3 downto 0);
signal button: std_logic;

constant TbPeriod : time := 20 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';


begin

dut : SystemP2
port map (reset => reset,
          clk => clk,
          switch => switch,
          button => button
        );
      
-- Clock generation
TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

-- EDIT: Check that Clk is really your main clock signal
Clk <= TbClock;

stimuli : process
    begin
    -- EDIT Adapt initialization as needed
    switch <= (others => '0');
    button <= '1';

    -- Reset generation
    -- EDIT: Check that Reset is really your reset signal
    Reset <= '1';
    wait for 100 ns;
    Reset <= '0';
    wait for 100 ns;

    -- EDIT Add stimuli here
    wait for 1 ms;
    switch <= "1000";
    wait for 1 ms;
    button <= '1';
    wait for 1 ms;
    button <= '0';
    
    wait for 1 ms;
    switch <= "1100";
    wait for 1 ms;
    button <= '1';
    wait for 1 ms;
    button <= '0';
    
    wait for 1 ms;
    switch <= "0010";
    wait for 1 ms;
    button <= '1';
    wait for 1 ms;
    button <= '0';
    
    wait for 5 ms;
    
    
    wait for 1 ms;
    switch <= "1001";
    wait for 1 ms;
    button <= '1';
    wait for 1 ms;
    button <= '0';
    
    wait for 1 ms;
    switch <= "1111";
    wait for 1 ms;
    button <= '1';
    wait for 1 ms;
    button <= '0';
    
    wait for 1 ms;
    switch <= "0000";
    wait for 1 ms;
    button <= '1';
    wait for 1 ms;
    button <= '0';    
    
    
    
    
    wait for 10 ms;
    -- Stop the clock and hence terminate the simulation
    TbSimEnded <= '1';
    wait;
end process;

end Behavioral;
