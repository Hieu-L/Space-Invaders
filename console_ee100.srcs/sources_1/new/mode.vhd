library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity mode is
    port(
        Pause_Rqt, Endframe, Lost, No_Brick,Clk25,Reset : in std_logic;
        Game_Lost, Brick_Win, Pause : out std_logic
        );
end entity;

architecture archi of mode is 
signal raz_tempo_pause, update_tempo_pause, fin_tempo_pause, load_timer_lost, update_timer_lost, rip, p : std_logic;
signal timer_lost : std_logic_vector(5 downto 0);
begin
    pause <= p;
    
    MAE2  : entity work.mae2
        port map(
        pause_rqt, endframe, lost, no_brick, clk25, reset, fin_tempo_pause, rip,
        timer_lost, 
        brick_win, p, raz_tempo_pause, update_tempo_pause, load_timer_lost, update_timer_lost);
    
    Tempo_pause : entity work.tempo_pause
        port map(RAZ_Tempo_Pause , Update_Tempo_Pause, Clk25, Reset, Fin_Tempo_Pause);
        
    TL : entity work.timer_lost
        port map(load_timer_lost, update_timer_lost, clk25, reset, game_lost, timer_lost);
    
    TimeOut : entity work.timeout 
        port map(clk25, reset, p, rip);
end archi;