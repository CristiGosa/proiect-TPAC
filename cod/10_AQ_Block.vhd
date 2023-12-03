library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AQ_Block is
    Generic(N: Integer := 8);
    Port ( f_in : in STD_LOGIC;
			  a_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           q_in : in  STD_LOGIC_VECTOR (N-1 downto 0);
           clock : in  STD_LOGIC;
           load1 : in  STD_LOGIC;
           load2 : in  STD_LOGIC;
           enA : in  STD_LOGIC;
           enQ : in  STD_LOGIC;
           shft1 : in  STD_LOGIC;
           shft2 : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           a_out : out  STD_LOGIC_VECTOR (N-1 downto 0);
           q_out : out  STD_LOGIC_VECTOR (N-1 downto 0);
			  q0 : out STD_LOGIC);
end AQ_Block;

architecture Behavioral of AQ_Block is

    COMPONENT ShiftRegister
    PORT(
         d : IN  std_logic;
         data : IN  std_logic_vector(7 downto 0);
         enable : IN  std_logic;
         load_me : IN  std_logic;
         shift_me : IN  std_logic;
         clock : IN  std_logic;
         reset : IN  std_logic;
         data_out : OUT  std_logic_vector(7 downto 0);
         q : OUT  std_logic
        );
    END COMPONENT;

signal pop : STD_LOGIC := '0';
begin

A: ShiftRegister port map(f_in,a_in,enA,load1,shft1,clock,rst,a_out,pop);
Q: ShiftRegister port map(pop,q_in,enQ,load2,shft2,clock,rst,q_out,q0);

end Behavioral;
