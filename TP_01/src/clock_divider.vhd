library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--This module generates a clock at fout frequency with 50% duty cicle
entity ClockDivider is
    generic (   
        fin:integer range 50000000 to 125000000 := 50000000;    --Default value 50MHz
        fout:integer range 1 to 10000000 := 1000                --Default value 1kHz
    );
    Port ( clk : in std_logic;
           reset : in std_logic;
           duty: in std_logic_vector(3 downto 0);
           newClock : out std_logic);
end ClockDivider;


architecture Behavioral of ClockDivider is

    --Constant for default 50% duty cycle
    CONSTANT MAX_COUNT: integer range 0 to fin/fout := ((fin/fout));
    CONSTANT HALF_COUNT: integer range 0 to fin/fout := ((fin/fout)/2 -1);

    signal sigClockOut: std_logic;
    signal counter: integer range 0 to (fin/fout) := 0;
    
    signal lowCount: integer range 0 to (fin/fout) := HALF_COUNT;
    signal dutySelect: std_logic_vector(3 downto 0);
begin
    
process (reset, clk)
begin
    if (reset = '1') then
        sigClockOut <= '0';
        counter <= 0;
    elsif (clk'event and clk = '1') then
        if(dutySelect = "1111") then
            sigClockOut <= '1';
            counter <= 0;
        elsif(dutySelect = "0000") then
            sigClockOut <= '0';
            counter <= 0;
        else
            if (counter <= lowCount) then
                sigClockOut <= '0';
                counter <= counter + 1;
            elsif (counter = MAX_COUNT) then
                counter <= 0;
            else
                counter <= counter + 1;
                sigClockOut <= '1';
            end if;
        end if;
    end if;
end process;

dutySelect <= duty;
newClock <= sigClockOut;


--Process to select duty cycle
process (clk)
begin
    if (clk'event and clk = '1') then
	case dutySelect is
        when "0001" =>
            lowCount <= ((MAX_COUNT*10)/12);
        when "0010" =>
            lowCount <= ((MAX_COUNT*10)/13);
        when "0011" =>
            lowCount <= ((MAX_COUNT*10)/14);
        when "0100" =>
            lowCount <= ((MAX_COUNT*10)/15);
        when "0101" =>
            lowCount <= ((MAX_COUNT*10)/16);
        when "0110" =>
            lowCount <= ((MAX_COUNT*10)/18);
        when "0111" =>
            lowCount <= ((MAX_COUNT*10)/19); 
        when "1000" =>
            lowCount <= (MAX_COUNT/2 -1);
        when "1001" =>
            lowCount <= ((MAX_COUNT*10)/27);
        when "1010" =>
            lowCount <= ((MAX_COUNT*10)/33);
        when "1011" =>
            lowCount <= ((MAX_COUNT*10)/41);
        when "1100" =>
            lowCount <= ((MAX_COUNT*10)/56);
        when "1101" =>
            lowCount <= ((MAX_COUNT*10)/83);
        when "1110" =>
            lowCount <= ((MAX_COUNT*10)/167);
        when others => 
            lowCount <= (MAX_COUNT/2 -1);
    end case;

    end if;
end process;    
    
end Behavioral;
