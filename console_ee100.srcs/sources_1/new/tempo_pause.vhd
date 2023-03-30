library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Tempo_Pause is
	port (
    	RAZ_Tempo_Pause , Update_Tempo_Pause: in std_logic ;
        Clk25, Reset : in std_logic ;
        Fin_Tempo_Pause : out std_logic ) ;
end entity;

architecture archi of Tempo_Pause is 

signal cmpt : std_logic_vector(9 downto 0) := "0000000000" ; 

begin

process(Clk25,Raz_Tempo_Pause,Update_Tempo_Pause,reset,cmpt) 
begin
	if reset = '0' then cmpt <= "0000000000" ;
    elsif rising_edge(Clk25) then
    	if Raz_Tempo_Pause = '1' then cmpt <= "0000000000" ;
        elsif cmpt /= "1111111111" and Update_Tempo_Pause = '1' then
        	cmpt <= cmpt + 1;
		end if;
    end if;
end process;

process(cmpt) 
begin
	if cmpt = "1111111111" then Fin_Tempo_Pause <= '1';
    else Fin_Tempo_Pause <= '0';
    end if;
end process;

end archi;