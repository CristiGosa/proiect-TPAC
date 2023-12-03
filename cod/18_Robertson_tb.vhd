library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Robertson_Testbench is
end Robertson_Testbench;

architecture testbench of Robertson_Testbench is
    constant N_VAL: integer := 8; -- Define the value for N

    signal x_in_tb, y_in_tb: std_logic_vector(N_VAL-1 downto 0);
    signal clock_tb, reset_tb: std_logic := '0';
    signal a_out_tb, q_out_tb: std_logic_vector(N_VAL-1 downto 0); 
    signal total_out_tb: std_logic_vector(2*N_VAL-1 downto 0);

    -- Clock process
    constant CLK_PERIOD: time := 10 ns; -- Define clock period
    signal stop_simulation: boolean := false;

    -- Robertson component instantiation
    component Robertson
        generic(
            N: integer := N_VAL
        );
        port(
            x_in : in  std_logic_vector(N-1 downto 0);
            y_in : in  std_logic_vector(N-1 downto 0);
            clock : in  std_logic;
            reset : in  std_logic;
            a_out : out  std_logic_vector(N-1 downto 0);
            q_out : out  std_logic_vector(N-1 downto 0);
            total_out : out std_logic_vector(2*N-1 downto 0)
        );
    end component;

begin
    -- Instantiate Robertson component
    DUT : Robertson
        generic map(
            N => N_VAL
        )
        port map(
            x_in => x_in_tb,
            y_in => y_in_tb,
            clock => clock_tb,
            reset => reset_tb,
            a_out => a_out_tb,
            q_out => q_out_tb,
            total_out => total_out_tb
        );

    -- Clock Process
    clock_process: process
    begin
        while not stop_simulation loop
            clock_tb <= '0';
            wait for CLK_PERIOD / 2;
            clock_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus Process
    stimulus : process
    begin
        -- Apply test vectors for multiplication of 2 and 3
        x_in_tb <= "00000010"; -- 2 in binary
        y_in_tb <= "00000011"; -- 3 in binary
        reset_tb <= '1';   -- Assert reset to start the calculation

        -- Allow some time for the calculation
        wait for 10 ns;

        reset_tb <= '0';   -- De-assert reset to start the computation

        -- To stop simulation after a certain time, uncomment the below line and modify the time
        wait for 2000 ns;
        stop_simulation <= true;
        wait;
    end process;

    -- Assertion Process
    assertion_process : process
    begin
        wait until stop_simulation;

        -- Verify the result (expected result: 6)
        assert total_out_tb = "0000000000000110" report "Multiplication of 2 by 3 did not produce the expected result of 6" severity failure;
        
        wait;
    end process;

end testbench;

