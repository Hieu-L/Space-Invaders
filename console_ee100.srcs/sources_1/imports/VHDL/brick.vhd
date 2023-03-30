----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
--	Gestion des Briques
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pong_pack.all;

entity brick_ctrl is
    Port ( xpos 			:	in std_logic_vector(9 downto 0);	-- Coordonnees X du Pixel Courant
           ypos 			: in std_logic_vector(9 downto 0);	-- Coordonnees Y du Pixel Courant
           game_type		: in std_logic;							-- Type de Jeu
			  brick_bounce	: in tableau;								-- Drapeaux des Collisions Briques
			  brick 			: out tableau								-- Pixel = Brique(i)(j)
			  );
end brick_ctrl;

architecture Behavioral of brick_ctrl is

begin


	-- GESTION DES FLAGS BRIQUE
		-- 1 Flag par Brique
		--	Flag = 1 si la Brique Est Intacte
		--	Flag = 0 si la Brique Est Cassee	
	process(ypos,xpos,brick_bounce,game_type)

		begin
		
		-- Pour Chaque Brique
		for i in 0 to 1 loop
			for j in 0 to 8 loop
				if  (
				    i = 0 and
				    (
				    ((ypos > 50 +i*100) and (ypos < 54 +i*100) and (xpos >= 47 +j*64) and (xpos < 50 +j*64))                            
				    or
				    ((ypos > 50 +i*100) and (ypos < 54 +i*100) and (xpos >= 68 +j*64) and (xpos < 71 +j*64))
				    or
				    ((ypos >= 54 +i*100) and (ypos < 57 +i*100) and (xpos >= 50 +j*64) and (xpos < 53 +j*64))
				    or
				    ((ypos >= 54 +i*100) and (ypos < 57 +i*100) and (xpos >= 65 +j*64) and (xpos < 68 +j*64))
				    or
				    ((ypos >= 57 +i*100) and (ypos < 60 +i*100) and (xpos >= 47 +j*64) and (xpos < 71 +j*64))
				    or
				    ((ypos >= 60 +i*100) and (ypos < 63 +i*100) and (xpos >= 44 +j*64) and (xpos < 50 +j*64))
                    or
                    ((ypos >= 60 +i*100) and (ypos < 63 +i*100) and (xpos >= 53 +j*64) and (xpos < 65 +j*64))
                    or
                    ((ypos >= 60 +i*100) and (ypos < 63 +i*100) and (xpos >= 68 +j*64) and (xpos < 74 +j*64))
                    or
                    ((ypos >= 63 +i*100) and (ypos < 66 +i*100) and (xpos >= 41 +j*64) and (xpos < 77 +j*64))
                    or
                    ((ypos >= 66 +i*100) and (ypos < 69 +i*100) and (xpos >= 41 +j*64) and (xpos < 44 +j*64))
                    or
                    ((ypos >= 66 +i*100) and (ypos < 69 +i*100) and (xpos >= 47 +j*64) and (xpos < 71 +j*64))
                    or
                    ((ypos >= 66 +i*100) and (ypos < 69 +i*100) and (xpos >= 74 +j*64) and (xpos < 77 +j*64))
                    or
                    ((ypos >= 69 +i*100) and (ypos < 72 +i*100) and (xpos >= 41 +j*64) and (xpos < 44 +j*64))
                    or
                    ((ypos >= 69 +i*100) and (ypos < 72 +i*100) and (xpos >= 47 +j*64) and (xpos < 50 +j*64))
                    or
                    ((ypos >= 69 +i*100) and (ypos < 72 +i*100) and (xpos >= 68 +j*64) and (xpos < 71 +j*64))
                    or
                    ((ypos >= 69 +i*100) and (ypos < 72 +i*100) and (xpos >= 74 +j*64) and (xpos < 77 +j*64))
                    or
                    ((ypos >= 72 +i*100) and (ypos < 75 +i*100) and (xpos >= 50 +j*64) and (xpos < 56 +j*64))
                    or
                    ((ypos >= 72 +i*100) and (ypos < 75 +i*100) and (xpos >= 62 +j*64) and (xpos < 68 +j*64))
				    )
					and 	(brick_bounce(i)(j) = '0') 					-- Brique Non Detruite
					and	(game_type='0')	
					)								-- Jeu = Casse Briques 
					or
					(
				    i = 1 and
				    (
				    ((ypos > 50 +i*80) and (ypos < 54 +i*80) and (xpos >= 53 +j*64) and (xpos < 65 +j*64))                           
				    or
				    ((ypos >= 54 +i*80) and (ypos < 57 +i*80) and (xpos >= 44 +j*64) and (xpos < 74 +j*64))
				    or
				    ((ypos >= 57 +i*80) and (ypos < 60 +i*80) and (xpos >= 41 +j*64) and (xpos < 77 +j*64))
				    or
				    ((ypos >= 60 +i*80) and (ypos < 63 +i*80) and (xpos >= 41 +j*64) and (xpos < 50 +j*64))
                    or
                    ((ypos >= 60 +i*80) and (ypos < 63 +i*80) and (xpos >= 56 +j*64) and (xpos < 62 +j*64))
                    or
                    ((ypos >= 60 +i*80) and (ypos < 63 +i*80) and (xpos >= 68 +j*64) and (xpos < 77 +j*64))
                    or
                    ((ypos >= 63 +i*80) and (ypos < 66 +i*80) and (xpos >= 41 +j*64) and (xpos < 77 +j*64))
                    or
                    ((ypos >= 66 +i*80) and (ypos < 69 +i*80) and (xpos >= 50 +j*64) and (xpos < 56 +j*64))
                    or
                    ((ypos >= 66 +i*80) and (ypos < 69 +i*80) and (xpos >= 62 +j*64) and (xpos < 68 +j*64))
                    or
                    ((ypos >= 69 +i*80) and (ypos < 72 +i*80) and (xpos >= 47 +j*64) and (xpos < 53 +j*64))
                    or
                    ((ypos >= 69 +i*80) and (ypos < 72 +i*80) and (xpos >= 56 +j*64) and (xpos < 62 +j*64))
                    or
                    ((ypos >= 69 +i*80) and (ypos < 72 +i*80) and (xpos >= 65 +j*64) and (xpos < 71 +j*64))
                    or
                    ((ypos >= 72 +i*80) and (ypos < 75 +i*80) and (xpos >= 41 +j*64) and (xpos < 47 +j*64))
                    or
                    ((ypos >= 72 +i*80) and (ypos < 75 +i*80) and (xpos >= 71 +j*64) and (xpos < 77 +j*64))
				    )
					and 	(brick_bounce(i)(j) = '0') 					-- Brique Non Detruite
					and	(game_type='0')	
					)								-- Jeu = Casse Briques 
				then
						brick(i)(j) <= '1';		-- Ce Pixel Appartient a la Brique(i)(j)
				else 	
						brick(i)(j) <= '0';		-- Ce Pixel N'Appartient Pas a la Brique(i)(j)
				end if;
			end loop;
		end loop;
		
	end process;
-----------------------------------------------------------------------------------------


end Behavioral;

