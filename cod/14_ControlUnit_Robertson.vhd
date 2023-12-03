library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit_Robertson is
    GENERIC(N: Integer := 8);
    Port ( q0 : in  STD_LOGIC;
              in_reset : in  STD_LOGIC;
              clock : in  STD_LOGIC;
           count : in  STD_LOGIC;
           count_in : out  STD_LOGIC;
           en_vect : out  STD_LOGIC_VECTOR (2 downto 0);
           en_shft1 : out  STD_LOGIC;
           en_shft2 : out  STD_LOGIC;
              load : out STD_LOGIC;
           reset : out  STD_LOGIC;
           subtract : out  STD_LOGIC;
           mux : out  STD_LOGIC);
end ControlUnit_Robertson;

architecture Behavioral of ControlUnit_Robertson is

type state is (RST, INIT, SC, LOAD0, LOADM, ADD, RSHIFT, VERIFY, SUBTK, OUTPUT);
signal current_state, next_state: state;
signal done, correct : STD_LOGIC := '0';
begin


STATE_ENHANCE: PROCESS(clock)
BEGIN
    if rising_edge(clock) then
        current_state <= next_state;
    end if;
END PROCESS;

STATE_SELECT: PROCESS(clock, q0, in_reset, count, current_state)
BEGIN
    CASE current_state IS
        WHEN RST =>
         en_vect(0) <= '1'; -- A
         en_vect(1) <= '1'; -- Q 
         en_vect(2) <= '1'; -- M      
           en_shft1 <= '0';  
           en_shft2 <= '0';
            subtract <= '0';
            correct <= '0';
            next_state <= INIT;
            load <= '0';
        WHEN INIT =>
           reset <= '0';
           count_in <= '0';
           next_state <= SC;
        WHEN SC =>
           count_in <= '0';
         en_vect(0) <= '0';  
           en_shft1 <= '0';  
           en_shft2 <= '0';
         en_vect(1) <= '0';
         en_vect(2) <= '0';
           if q0 = '0' then
               mux <= '0'; 
                next_state <= LOAD0;
                elsif count = '1' then
                   done <= '1';
                    next_state <= VERIFY;
            else
               mux <= '1';
                next_state <= LOADM;
            end if;         
        WHEN LOAD0 =>
         en_vect(0) <= '1';  
           en_shft1 <= '0';  
           en_shft2 <= '0';
            next_state <= ADD;         
        WHEN LOADM =>
            next_state <= OUTPUT;
         en_vect(0) <= '1';  
           en_shft1 <= '0';  
           en_shft2 <= '0';
            next_state <= ADD;
        WHEN ADD =>  
         en_vect(0) <= '0';
           next_state <= RSHIFT;
        WHEN RSHIFT =>
         en_vect(0) <= '0';
           count_in <= '1';  
           en_shft1 <= '1';  
           en_shft2 <= '1';
                if count = '0' then 
                next_state <= SC;
                elsif done = '1' then    
                en_shft1 <= '0';  
                en_shft2 <= '1';
                load <= '1';
                next_state <= OUTPUT;
                else                
                count_in <= '0';
                next_state <= OUTPUT;
            end if;
        WHEN VERIFY =>
            en_vect(0) <= '0';
         en_vect(1) <= '0';
           count_in <= '0';  
           en_shft1 <= '0';  
           en_shft2 <= '0';
            if q0 = '1' then
            next_state <= SUBTK;
            elsif done = '1' then           
         en_vect(0) <= '0';
         en_vect(1) <= '0';
            next_state <= SC;
            else
            next_state <= RSHIFT;
            end if;
        WHEN SUBTK =>       
         en_vect(0) <= '1';        
           subtract <= '1';
            next_state <= RSHIFT;
        WHEN OUTPUT =>
            load <= '0';    
           en_shft1 <= '0';  
           en_shft2 <= '0';
           if in_reset = '1' then
            next_state <= RST;
            else
            next_state <= OUTPUT;
            end if;          
END CASE;
END PROCESS;
end Behavioral;

