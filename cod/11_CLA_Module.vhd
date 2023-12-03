library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_Module is
    Port ( p : in  STD_LOGIC;
           g : in  STD_LOGIC;
           c_i : in  STD_LOGIC;
           c_i1 : out  STD_LOGIC);
end CLA_Module;

architecture Behavioral of CLA_Module is

begin

c_i1 <= g or (c_i and p);

end Behavioral;
