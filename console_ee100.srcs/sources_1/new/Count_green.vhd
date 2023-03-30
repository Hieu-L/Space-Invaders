library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity count_green is 
	port ( 
    	Clk ,reset : in std_logic ;
        Com : in std_logic_vector(1 downto 0);
        GREEN_Out : out std_logic_vector(3 downto 0)
        );
end count_green;



architecture archi of count_green is 

signal num : std_logic_vector(4 downto 0) := "00000";

begin

	GREEN_Out <= num(4 downto 1);
	
    process(Clk , Com ,reset) 
    
    begin
    if reset = '0' then num <= "00000";
    
    elsif rising_edge(Clk) then
    	
        if Com = "01" and num < "11111" then num <= num +1 ;
        
        elsif Com = "10" and num > "00000" then num <= num - 1;
        
        end if;
    end if;
    
    end process;
    
end archi;