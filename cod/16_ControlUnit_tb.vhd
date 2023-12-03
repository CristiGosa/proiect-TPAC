library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit_Robertson_TB is
end ControlUnit_Robertson_TB;

architecture TB_ARCH of ControlUnit_Robertson_TB is
    constant CLK_PERIOD: time := 10 ns; -- Clock period (adjust as needed)

    signal q0_tb, in_reset_tb, clock_tb, count_tb: std_logic;
    signal count_in_tb: std_logic;  -- Corrected to std_logic
    signal en_vect_tb: std_logic_vector(2 downto 0);
    signal en_shft1_tb, en_shft2_tb, load_tb, reset_tb, subtract_tb, mux_tb: std_logic;

    component ControlUnit_Robertson
        GENERIC(N: Integer := 8);
        Port (
           q0 : in  STD_LOGIC;
           in_reset : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           count : in  STD_LOGIC;
           count_in : out  STD_LOGIC; -- Changed to std_logic
           en_vect : out  STD_LOGIC_VECTOR (2 downto 0);
           en_shft1 : out  STD_LOGIC;
           en_shft2 : out  STD_LOGIC;
           load : out STD_LOGIC;
           reset : out  STD_LOGIC;
           subtract : out  STD_LOGIC;
           mux : out  STD_LOGIC
        );
    end component;

begin

    UUT: ControlUnit_Robertson
        generic map(N => 8) -- Assuming N = 8
        port map (
            q0 => q0_tb,
            in_reset => in_reset_tb,
            clock => clock_tb,
            count => count_tb,
            count_in => count_in_tb,
            en_vect => en_vect_tb,
            en_shft1 => en_shft1_tb,
            en_shft2 => en_shft2_tb,
            load => load_tb,
            reset => reset_tb,
            subtract => subtract_tb,
            mux => mux_tb
        );

    stimulus_process: process
    begin
        -- Initialize inputs
        q0_tb <= '0';
        in_reset_tb <= '0';
        clock_tb <= '0';
        count_tb <= '0';

        -- Apply reset
        in_reset_tb <= '1';
        wait for 10 ns;
        in_reset_tb <= '0';

        -- Clock toggling
        wait for CLK_PERIOD / 2;

        -- Scenario: Simulating a sequence
        -- Here, we are assuming a sequence where count goes high after a few clock cycles
        for i in 1 to 5 loop
            clock_tb <= '1';
            wait for CLK_PERIOD / 2;
            clock_tb <= '0';
            wait for CLK_PERIOD / 2;
        end loop;

        -- Setting count signal high after 5 clock cycles
        count_tb <= '1';
        wait for CLK_PERIOD;

        -- Continue simulation or add further scenarios as needed
        
        wait;
    end process;

end TB_ARCH;

