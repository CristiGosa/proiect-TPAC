library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_Network is
    GENERIC(N: Integer := 8);
    Port ( p_i : in  STD_LOGIC_VECTOR (7 downto 0);
           g_i : in  STD_LOGIC_VECTOR (7 downto 0);
			  c0 : in STD_LOGIC;
           carry_out : out  STD_LOGIC_VECTOR (8 downto 0));
end CLA_Network;

architecture Behavioral of CLA_Network is

COMPONENT CLA_Module is
    Port ( p : in  STD_LOGIC;
           g : in  STD_LOGIC;
           c_i : in  STD_LOGIC;
           c_i1 : out  STD_LOGIC);
END COMPONENT;

signal comm_carry : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
begin

carry_out <= comm_carry;

comm_carry(0) <= c0;
CLANET: for i in 0 to N-1 generate
CLM: CLA_Module port map(p_i(i),g_i(i),comm_carry(i),comm_carry(i+1));
end generate;

end Behavioral;
