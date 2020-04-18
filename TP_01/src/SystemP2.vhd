library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SystemP2 is
    Port(
        clk: in std_logic;
        reset: in std_logic;
        switch: in std_logic_vector(3 downto 0);
        button: in std_logic;
        
        pwm_red: out std_logic;
        pwm_green: out std_logic;
        pwm_blue: out std_logic
    );
end SystemP2;

architecture Behavioral of SystemP2 is

CONSTANT INTERNAL_FREQUENCY: integer range 0 to 125000000 := 50000000;  --Internal clock 50Mhz

Component ClockDivider
    generic (   
        fin:integer range 50000000 to 125000000 := 50000000;    --Default value 50MHz
        fout:integer range 1 to 10000000 := 1000                --Default value 1kHz
    );
    Port ( clk : in std_logic;
           reset : in std_logic;
           duty: in std_logic_vector(3 downto 0);
           newClock : out std_logic);
end component;

component MEF_System
    Port ( 
    clk: in std_logic;
    reset: in std_logic;
    button: in std_logic;
    
    saveR: out std_logic;
    saveG: out std_logic;
    saveB: out std_logic;
    
    showRGB: out std_logic
    );
end component;

component Storage
    generic (
        inputSize: integer range 0 to 31 := 3
    );
    Port ( clk : in std_logic;
           reset : in std_logic;
           storage: in std_logic;
           input : in std_logic_vector (inputSize downto 0);
           output : out std_logic_vector (inputSize downto 0));
end component;

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


signal buttonFiltered: std_logic;
signal saveR, saveG, saveB, showRGB: std_logic;

signal duty50: std_logic_vector(3 downto 0) := "1000";
signal clk1khz: std_logic;


signal duty_red, duty_green, duty_blue: std_logic_vector(3 downto 0);
signal enableRGB: std_logic;
begin


--Use this until anti bounce is ready
--buttonFiltered <= button;


enableRGB <= (reset or not(showRGB));

-- 1 kHz clock for slow process (anti bounce, among others)
Clock1kHz_Component: ClockDivider
generic map( fin => INTERNAL_FREQUENCY, fout => 1000)
port map (clk => clk, reset=>reset, duty => duty50, newClock => clk1khz);
AntiBounce: ShiftRegister
generic map (depth => 5)
port map (clk => clk1khz, reset => reset, input => button, output => buttonFiltered);


PWMRED_Component: ClockDivider
generic map( fin => INTERNAL_FREQUENCY, fout => 1000)
port map (clk => clk, reset=>enableRGB, duty => duty_red, newClock => pwm_red);

PWMGREEN_Component: ClockDivider
generic map( fin => INTERNAL_FREQUENCY, fout => 1000)
port map (clk => clk, reset=>enableRGB, duty => duty_green, newClock => pwm_green);

PWMBLUE_Component: ClockDivider
generic map( fin => INTERNAL_FREQUENCY, fout => 1000)
port map (clk => clk, reset=>enableRGB, duty => duty_blue, newClock => pwm_blue);

MEF: MEF_System
port map(clk => clk, reset => reset, button => buttonFiltered, saveR => saveR, saveG => saveG, saveB=> saveB, showRGB => showRGB);

STORAGE_RED: Storage
generic map (inputSize => 3)
port map(clk => clk, reset => reset, storage => saveR, input => switch, output => duty_red);

STORAGE_GREEN: Storage
generic map (inputSize => 3)
port map(clk => clk, reset => reset, storage => saveG, input => switch, output => duty_green);

STORAGE_BLUE: Storage
generic map (inputSize => 3)
port map(clk => clk, reset => reset, storage => saveB, input => switch, output => duty_blue);

end Behavioral;
