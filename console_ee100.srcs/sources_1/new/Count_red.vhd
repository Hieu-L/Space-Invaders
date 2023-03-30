library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity count_red is 
	port ( 
    	Clk ,reset : in std_logic ;
        Com : in std_logic_vector(1 downto 0);
        RED_Out : out std_logic_vector(3 downto 0)
        );
end count_red;



architecture archi of count_red is 

signal num : std_logic_vector(4 downto 0) := "11111";

begin

	RED_Out <= num(4 downto 1);
	
    process(Clk , Com, reset) 
    
    begin
    if reset = '0' then num <= "11111";
    
    elsif Com = "00" then num <= num;
    
    elsif rising_edge(Clk) then
    	
        if Com = "01" and num < "11111" then num <= num +1 ;
        
        elsif Com = "10" and num > "00000" then num <= num - 1;
        
        end if;
    end if;
    
    end process;
    
end archi;