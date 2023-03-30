library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Mach_Etat is
	port (
    	RED_In , GREEN_In , Blue_In : in std_logic_vector(3 downto 0) ;
        Clk100 : in std_logic ;
        Com_RED , Com_GREEN , Com_BLUE : out std_logic_vector(1 downto 0)
        );
end entity;


architecture archi of Mach_etat is 

signal RGB : std_logic_vector(11 downto 0);
signal RED , GREEN , BLUE : std_logic_vector(1 downto 0) ;

begin
	
    RGB <= RED_In & GREEN_In & BLUE_In ;
    
    Com_RED <= RED;
    Com_GREEN <= GREEN;
    Com_BLUE <= BLUE;
	

	process(Clk100, RGB) 
    begin
    if rising_edge(Clk100) then 
    	---COM : 00 = constante | 01 = incremente | les autres = decremente
        
    	case (RGB) is 
        	when "111100000000" =>  
            	RED <= "10" ; 
                GREEN <= "01" ;
                BLUE <= "00" ;
                
            when "000011110000" =>  
            	RED <= "00";
                GREEN <= "10";
                BLUE <= "01";   
                
            when "000000001111" =>  
            	RED <= "01";
                GREEN <= "00";
                BLUE <= "10";
                
            when others => 
            	RED <= RED;
                GREEN <= GREEN;
                BLUE <= BLUE;
        end case;
        
    end if;
    end process;
    
end archi;