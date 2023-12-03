library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port ( s1 : in  STD_LOGIC;
           s2 : in  STD_LOGIC;
           r : out  STD_LOGIC;
           c : out  STD_LOGIC);
end half_adder;

architecture Behavioral of half_adder is

begin

r <= s1 xor s2;
c <= s1 and s2;

end Behavioral;
