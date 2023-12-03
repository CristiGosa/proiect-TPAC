library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.std_logic_1164.all;

entity F_Flip is
	port (
	clk,M7,Q0,reset : in STD_LOGIC;
	v_out : out STD_LOGIC);
end F_Flip;

architecture Behavioral of F_Flip is
begin

process(clk,reset)
variable result : std_logic := '0';
begin
	if rising_edge(clk) then
	   if reset = '0' then
			result := (M7 and Q0) or result;
		else
			result := '0';
		end if;
	end if;	
		v_out <= result;
end process;

end Behavioral;
