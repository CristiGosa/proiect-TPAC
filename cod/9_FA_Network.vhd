library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA_Network is
    GENERIC(N: integer := 8);
    Port ( x_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           c_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           s_out : out  STD_LOGIC_VECTOR (N-1 downto 0));
end FA_Network;

architecture Behavioral of FA_Network is

COMPONENT full_adder 
    Port ( s1 : in  STD_LOGIC;
           s2 : in  STD_LOGIC;
           carry_in : in  STD_LOGIC;
           result : out  STD_LOGIC;
           carry_out : out  STD_LOGIC);
END COMPONENT;

signal s_app : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');

begin

s_out <= s_app;

FA_NET:for i in 0 to N-1 generate
FA: full_adder port map(x_in(i),y_in(i),c_in(i),s_app(i),open);
end generate; 

end Behavioral;
