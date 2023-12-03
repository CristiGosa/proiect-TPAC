library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vect_mux is
    GENERIC (N: Integer := 8);
    Port ( m_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  scan : in STD_LOGIC;
           value_out : out  STD_LOGIC_VECTOR (N-1 downto 0));
end vect_mux;

architecture Behavioral of vect_mux is
signal null_in : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');

begin

with scan select
	  value_out <= m_in when '1', null_in when others; 


end Behavioral;
