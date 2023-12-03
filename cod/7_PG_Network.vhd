library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PG_Network is
    GENERIC(N: Integer := 8);
    Port ( x_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           p_out : out  STD_LOGIC_VECTOR (N-1 downto 0);
           g_out : out  STD_LOGIC_VECTOR (N-1 downto 0));
end PG_Network;

architecture Behavioral of PG_Network is

COMPONENT PG_Block is
    Port ( x_in : in  STD_LOGIC;
           y_in : in  STD_LOGIC;
           p_out : out  STD_LOGIC;
           g_out : out  STD_LOGIC);
END COMPONENT;

signal p_app,g_app : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');

begin

p_out <= p_app;
g_out <= g_app;

PG_GEN:for i in 0 to N-1 generate
	PGBLK: PG_Block port map(x_in(i),y_in(i),p_app(i),g_app(i));
end generate;

end Behavioral;
