library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CLA_Parallel_Adder_TB is
end CLA_Parallel_Adder_TB;

architecture TB_ARCH of CLA_Parallel_Adder_TB is
    constant N: integer := 8; -- Vector size
    constant CLK_PERIOD: time := 10 ns; -- Clock period (adjust as needed)

    signal x_in_tb, y_in_tb, sum_tb: std_logic_vector(N-1 downto 0);
    signal c_in_tb, c_out_tb: std_logic;

    component CLA_Parallel_Adder
        GENERIC(N: Integer := 8);
        Port (
           x_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           c_in : in STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (N-1 downto 0);
           c_out : out STD_LOGIC
        );
    end component;

begin

    UUT: CLA_Parallel_Adder
        generic map(N => N)
        port map (
            x_in => x_in_tb,
            y_in => y_in_tb,
            c_in => c_in_tb,
            sum => sum_tb,
            c_out => c_out_tb
        );

    stimulus_process: process
    begin
        -- Initialize inputs
        x_in_tb <= (others => '0');
        y_in_tb <= (others => '0');
        c_in_tb <= '0';

        -- Assign values for input vectors and carry input
        x_in_tb <= "00100001"; -- 21 in binary
        y_in_tb <= "01000010"; -- 42 in binary
        c_in_tb <= '0';

        -- Wait for some time after inputs are set
        wait for 10 ns;

        -- Wait for simulation to complete (adjust according to expected time)
        wait for 100 ns;

        -- Add assertions to verify the expected sum and carry output
        assert sum_tb = "01100011" -- 63 in binary
            report "Sum incorrect"
            severity error;

        assert c_out_tb = '0' -- No carry out
            report "Carry out incorrect"
            severity error;

        wait;
    end process;

end TB_ARCH;

