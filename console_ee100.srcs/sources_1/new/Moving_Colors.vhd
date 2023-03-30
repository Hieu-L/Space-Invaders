library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Moving_Colors is 
	port (
    	Clk100 , reset : in std_logic ;
        RED_Out , GREEN_Out , BLUE_Out : out std_logic_vector(3 downto 0)
 		);
end Moving_Colors;


architecture archi of Moving_Colors is 
signal Clk10 : std_logic ;

signal RED_In , GREEN_In , BLUE_In : std_logic_vector(3 downto 0) ;

signal Com_RED , Com_GREEN , Com_BLUE : std_logic_vector(1 downto 0);

begin
    clkdiv10 : entity work.ClkDiv10 
        port map (
            Clk => Clk100 ,
            Clk10 => Clk10 
            );
            
	red : entity work.count_red
		port map ( 
		    reset => reset ,
    		RED_Out => Red_In,
    	    Clk => Clk10,
    	    Com => Com_RED );

	blue : entity work.count_blue
		port map ( 
		    reset => reset ,
    		BLUE_Out => BLUE_In,
    	    Clk => Clk10,
    	    Com => Com_BLUE );
    
    green : entity work.count_green
		port map ( 
		    reset => reset ,
    		GREEN_Out => GREEN_In,
    	    Clk => Clk10,
    	    Com => Com_GREEN );
    
    machine_a_etat : entity work.Mach_etat 
    	port map (
        	RED_In => RED_In ,   
            Com_RED => Com_RED,
            
            GREEN_In => GREEN_In,   
            COM_GREEN => Com_GREEN,
            
            BLUE_In => BLUE_In,   
            Com_BLUE => Com_BLue,
            
        	Clk100 => Clk100 );
    
    RED_Out <= RED_In;
    GREEN_Out <= GREEN_In;
    BLUE_Out <= BLUE_In;

end archi;
