library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
    GENERIC(N: Integer := 8);
    Port ( d : in  STD_LOGIC;
			  data : in STD_LOGIC_VECTOR (N-1 downto 0);
			  enable : in STD_LOGIC;
			  load_me : in STD_LOGIC;
			  shift_me : in STD_LOGIC;
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  data_out : out STD_LOGIC_VECTOR (N-1 downto 0);
           q : out  STD_LOGIC);
end ShiftRegister;
architecture Behavioral of ShiftRegister is

begin

PROCESS (d, clock, reset)
variable internal_value: STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
		BEGIN
			IF rising_edge(clock) THEN
			   IF reset = '1' THEN
					internal_value := (others => '0');
				ELSIF enable = '1' then
					internal_value := data;
				ELSIF shift_me = '1' then
					internal_value := d & internal_value(N-1 downto 1);
				ELSIF load_me = '1' then
					internal_value :=  internal_value(N-1) & internal_value(N-1 downto 1);
				END IF;
			END IF;
			data_out <= internal_value;
			q <= internal_value(0);
END PROCESS;

end Behavioral;
