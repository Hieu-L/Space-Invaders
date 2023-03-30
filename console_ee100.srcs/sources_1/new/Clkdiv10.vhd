library IEEE;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_1164.all;

entity ClkDiv10 is 
	port ( 
    	Clk : in std_logic;
        Clk10 : out std_logic
        );
end entity;

architecture archi of ClkDiv10 is 
	
signal q : std_logic_vector(21 downto 0) := "0000000000000000000000";
signal val : std_logic := '0';

begin

Clk10 <= val;

process(Clk)
begin
	if rising_edge(Clk) then 
    	q <= q + 1 ;
    	if q = "1001100010010110100000" then 
        	q <= "0000000000000000000000" ;
            val <= not val;
        end if;
    end if;
end process;


end archi;