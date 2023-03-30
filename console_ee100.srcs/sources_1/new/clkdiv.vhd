library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ClkDiv is
	port ( 
    	clk100 , reset : in std_logic ;
        clk25 : out std_logic 
        );
end entity;

architecture archi of ClkDiv is 

signal cpt : std_logic_vector(1 downto 0) := "00";
signal s : std_logic := '0' ; 

begin
	
    process(clk100,reset)
    begin
    	if reset = '0' then cpt <= "00"; s <='0';
        elsif rising_edge(clk100) then
        	cpt <= cpt + 1;
            if cpt = "01" then cpt <= "00" ; s <= not s;
            end if;
        end if;
    end process;
    
    clk25 <= s;
end archi;

