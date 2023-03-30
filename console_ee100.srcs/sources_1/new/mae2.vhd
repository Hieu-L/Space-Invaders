library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity mae2 is
port(pause_rqt, endframe, lost, no_brick, clk25, reset, fin_tempo_pause , rip : in std_logic;
	timer_lost : in std_logic_vector(5 downto 0);
    brick_win, pause, raz_tempo_pause, update_tempo_pause, load_timer_lost, update_timer_lost : out std_logic);
end mae2;

architecture archi of mae2 is

signal state : std_logic_vector (2 downto 0) := "000";

begin

process(clk25, reset)
begin
	if reset = '0' then state <= "000";
    elsif rising_edge(clk25) then
    
    	if ((state = "000") and (pause_rqt = '1') and (fin_tempo_pause = '1')) 
        	then state <= "001";        
        
        elsif ((state = "001") and (not pause_rqt = '1'))
        	then state <= "011";
        
        elsif ((state = "011") and (no_brick = '1')) 
        	then state <= "100";
        
        elsif ((state = "011") and (pause_rqt = '1') and (fin_tempo_pause = '1')) 
        	then state <= "010";
        
        elsif ((state = "010") and (not pause_rqt = '1')) 
        	then state <= "000";
        
        elsif ((state = "011") and ( (lost = '1') or (rip = '1') ) ) 
        	then state <= "101";
        
        elsif state = "101" 
        	then state <= "110";
        
        elsif (state = "110") then 
            if ((endframe = '1') and (timer_lost /= "000000")) 
                then state <= "111";
            elsif ((endframe = '1') and (timer_lost = "000000")) then state <= "000";
            end if;
        
        elsif state = "111" 
        	then state <= "110";
        
        else state <= state;

		end if;
        
	end if;
    
end process;

process(state)
begin
case(state) is
	when "000" => 
    	update_tempo_pause <= '1';
        pause <= '1';
        brick_win <= '0';
        raz_tempo_pause <= '0';
        load_timer_lost <= '0';
        update_timer_lost <= '0';
        
    when "001" => 
    	update_tempo_pause <= '0';
        pause <= '0';
        brick_win <= '0';
        raz_tempo_pause <= '1';
        load_timer_lost <= '0';
        update_timer_lost <= '0';
        
    when "011" => 
    	update_tempo_pause <= '1';
        pause <= '0';
        brick_win <= '0';
        raz_tempo_pause <= '0';
        load_timer_lost <= '0';
        update_timer_lost <= '0';
        
    when "010" => 
    	update_tempo_pause <= '0';
        pause <= '0';
        brick_win <= '0';
        raz_tempo_pause <= '1';
        load_timer_lost <= '0';
        update_timer_lost <= '0';
        
    when "100" => 
    	update_tempo_pause <= '0';
        pause <= '0';
        brick_win <= '1';
        raz_tempo_pause <= '0';
        load_timer_lost <= '0';
        update_timer_lost <= '0';
        
    when "101" => 
    	update_tempo_pause <= '0';
        pause <= '0';
        brick_win <= '0';
        raz_tempo_pause <= '0';
        load_timer_lost <= '1';
        update_timer_lost <= '0';
        
    when "110" => 
    	update_tempo_pause <= '0';
        pause <= '0';
        brick_win <= '0';
        raz_tempo_pause <= '0';
        load_timer_lost <= '0';
        update_timer_lost <= '0';
        
    when "111" => 
    	update_tempo_pause <= '0';
        pause <= '0';
        brick_win <= '0';
        raz_tempo_pause <= '0';
        load_timer_lost <= '0';
        update_timer_lost <= '1';
    
    when others =>
    	update_tempo_pause <= '0';
        pause <= '0';
        brick_win <= '0';
        raz_tempo_pause <= '0';
        load_timer_lost <= '0';
        update_timer_lost <= '0';
    
        
    end case;

end process;

end archi;