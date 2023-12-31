library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_Parallel_Adder is
    GENERIC( N: Integer := 8);
    Port ( x_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  c_in : in STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (N-1 downto 0);
			  c_out : out STD_LOGIC);
end CLA_Parallel_Adder;

architecture Behavioral of CLA_Parallel_Adder is

    COMPONENT CLA_Network
    GENERIC(N: integer := 8);
    PORT(
         p_i : IN  std_logic_vector(N-1 downto 0);
         g_i : IN  std_logic_vector(N-1 downto 0);
			c0 : in STD_LOGIC;
         carry_out : OUT  std_logic_vector(N downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT PG_Network
    GENERIC(N: integer := 8);
    PORT(
         x_in : IN  std_logic_vector(N-1 downto 0);
         y_in : IN  std_logic_vector(N-1 downto 0);
         p_out : OUT  std_logic_vector(N-1 downto 0);
         g_out : OUT  std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT FA_Network 
    GENERIC(N: integer := 8);
    Port ( x_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           c_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           s_out : out  STD_LOGIC_VECTOR (N-1 downto 0));
	 END COMPONENT;

signal nullval : STD_LOGIC_VECTOR (N-2 downto 0) := (others => '0');
signal y_ing,x1,p_append,g_append,c_real,sum_p : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
signal c_append : STD_LOGIC_VECTOR (N downto 0) := (others => '0');
begin

PROCESS(c_in)
BEGIN
if c_in = '1' then
nullval <= (others => '1');
END IF;
END PROCESS;

x1 <= nullval & c_in;
y_ing <= y_in xor x1;

c_real <= c_append(N-1 downto 0);
c_out <= c_append(N);
sum <= sum_p;

PG:PG_Network port map(x_in,y_ing,p_append,g_append);
CLAN:CLA_Network port map(p_append,g_append,c_in,c_append);
FANET: FA_Network port map(x_in,y_ing,c_real,sum_p);

end Behavioral;
