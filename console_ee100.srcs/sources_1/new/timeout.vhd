library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity timeout is
    port (
        Clk25 , reset ,pause : in std_logic ;
        rip : out std_logic );
end timeout;

architecture Behavioral of timeout is

signal internal_clk : std_logic := '0';
signal cmpt : std_logic_vector(23 downto 0) := (others => '0');

signal countdown : std_logic_vector( 8 downto 0 ) := "000100000";
signal done : std_logic := '0';

begin
    
    -- INTERNAL CLK : 1Hz
    process(Clk25, reset , pause) 
    begin
        if reset = '0' then 
            internal_clk <= '0';
            cmpt <= (others => '0');
        elsif rising_edge(Clk25) then
            
            if pause = '0' then
                cmpt <= cmpt + 1;
                
                if (cmpt = "101111101011110000100000") then
                    internal_clk <= not internal_clk;
                    cmpt <= (others => '0');
                end if;
            end if;
        end if;
    end process;
    
    -- TIMEOUT COUNTER : DECREMENTS FROM 5 MIN to 0 "100101100"
    process(internal_clk , reset , countdown, done) 
    begin
        if reset = '0' then 
            countdown <= "000100000";
            rip <= '0';
            done <= '0';
        elsif (rising_edge(internal_clk)) then
            countdown <= countdown - 1;
            if ((countdown = "000000000") and (done = '0')) then
                rip <= '1';
                done <= '1';
            end if;
        end if;
   end process;
    
    
    
    
end Behavioral;
