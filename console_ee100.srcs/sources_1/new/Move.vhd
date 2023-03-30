-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Move is 
	port (
    	Clk25 , reset : in std_logic;
        QA , QB : in std_logic;
        Rot_Left , Rot_Right : out std_logic 
        );
end Move;


architecture archi of Move is 

signal state : std_logic_vector(2 downto 0) := "000";
signal RL , RR : std_logic;

begin

	Rot_Left <= RL;
    Rot_Right <= RR;

	process(Clk25 , reset) 
	begin 
    
    if reset = '0' then state <= "000";
    
    elsif rising_edge(Clk25) then 
    	--EL1 = "001"
    	if (state = "000") and ( (QA='1') and (QB='0') ) then 
        	state <= "001" ;
        	
        elsif (state = "000") and ( (QA='1') and (QB='1') ) then 
        	state <= "010" ;
        	
        elsif (state = "001") or (state = "010") then 
        	state <= "011" ;
        	
         elsif (state = "011") and ( (QA='0') and (QB='1') ) then 
        	state <= "100" ; 
        	
        elsif (state = "011") and ( (QA='0') and (QB='0') ) then 
        	state <= "101" ; 
        
        elsif (state = "100") or (state = "101") then 
        	state <= "000" ;	
        
        else state <= state;
        
        end if;
    end if;
    
    end process;
    
    process(state)
    begin
    case(state) is 
    	when "001" => 
        	RL <= '1';
            RR <= '0';
            
        when "010" => 
        	RL <= '0';
            RR <= '1';
            
        when "100" => 
        	RL <= '1';
            RR <= '0';
            
        when "101" => 
        	RL <= '0';
            RR <= '1';
            
        when others => 
        	RL <= '0';
            RR <= '0';
    end case;
    end process;
    
end archi;

