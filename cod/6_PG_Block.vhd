library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PG_Block is
    Port ( x_in : in  STD_LOGIC;
           y_in : in  STD_LOGIC;
           p_out : out  STD_LOGIC;
           g_out : out  STD_LOGIC);
end PG_Block;

architecture Behavioral of PG_Block is

begin

g_out <= x_in and y_in;
p_out <= x_in or y_in;

end Behavioral;
