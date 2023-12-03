library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( s1 : in  STD_LOGIC;
           s2 : in  STD_LOGIC;
           carry_in : in  STD_LOGIC;
           result : out  STD_LOGIC;
           carry_out : out  STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

	 COMPONENT half_adder
    PORT(
         s1 : IN  std_logic;
         s2 : IN  std_logic;
         r : OUT  std_logic;
         c : OUT  std_logic
        );
    END COMPONENT;

signal coll1,coll2 : STD_LOGIC := '0';
signal r_fin,carry_fin : STD_LOGIC := '0';

begin

HA1: half_adder port map(s1,s2,coll1,coll2);
HA2: half_adder port map(coll1,carry_in,r_fin,carry_fin);

result <= r_fin;
carry_out <= coll2 or carry_fin;

end Behavioral;
