library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity timer_lost is
port(load_timer_lost, update_timer_lost, clk25, reset : in std_logic;
	game_lost : out std_logic;
	timer_lost : out std_logic_vector(5 downto 0));
end timer_lost;

architecture archi of timer_lost is

signal cpt : std_logic_vector(5 downto 0) := "111111";


begin

timer_lost <= cpt;
--game_lost <= '0';
process(clk25, reset, load_timer_lost, update_timer_lost, cpt)
begin

	if (reset = '0') then cpt <= "111111"; game_lost <= '0';
	elsif (load_timer_lost = '1')then cpt <= "111111";
    elsif rising_edge(Clk25) then 
        	if cpt = "000000" then game_lost <= '0'; 
    		elsif update_timer_lost = '1' then cpt <= cpt - 1; game_lost <= '1';
            end if;
    else cpt <= cpt;
    end if;
    
end process;
end archi;
    