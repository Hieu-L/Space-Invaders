----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
--	Selection des Couleurs des Pixels a Afficher
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pong_pack.ALL;

entity display is
    Port ( 	visible: in STD_LOGIC;			-- Zone Visible de l'Image
				master_slave: in STD_LOGIC;	-- Mode Console ou Manette
				pad : in  STD_LOGIC;				-- Pixel Courant = Raquette
				
				xpos : in std_logic_vector(9 downto 0);
				ypos : in std_logic_vector(9 downto 0);
				
				wall_pong : in  STD_LOGIC;		-- Pixel Courant = Mur Jeu Pong
				wall_brick : in  STD_LOGIC;	-- Pixel Courant = Mur Jeu Casse Briques
				barrier: in STD_LOGIC;			-- Pixel Courant = Obstacle (Jeu Pong)
				bluebox : in  STD_LOGIC;		-- Pixel Courant = Case Bleue
				ball : in  STD_LOGIC;			-- Pixel Courant = Balle
				brick : in  tableau;				-- Pixel Courant = Brique
				brick_win : in  STD_LOGIC;		-- Partie Gagnee (Jeu Casse Briques)
				lost_game : in  STD_LOGIC;		-- Partie Perdue
				red : out  STD_LOGIC_VECTOR(3 downto 0);			-- Commande Affichage Rouge
				green : out  STD_LOGIC_VECTOR(3 downto 0);			-- Commande Affichage Vert
				----------------------
				--leds : out std_logic;
				---------------------
				blue : out  STD_LOGIC_VECTOR(3 downto 0));			-- Commande Affichage Bleu
			
end display;

architecture Behavioral of display is
signal do_nothing : std_logic;
begin
    
    do_nothing <= bluebox;
    
	process (pad,wall_brick,wall_pong,ball,brick,brick_win,lost_game,barrier,master_slave,visible,ypos)

	begin

		-- SI ON EST DANS LA ZONE VISIBLE DE L'IMAGE
		if visible = '1' then
		
			-- LE PIXEL COURANT APPARTIENT AU DECOR

			-- Si le Pixel Courant Appartient a un Mur ou a l'Obstacle
			--	Couleur = Blanc
			if (wall_brick = '1') then
			     red <= "0000"; green <= "0100"; blue <= "0100";    
			elsif (barrier = '1') then
			     red <= "1010"; green <= "0000"; blue <= "1100";    
			-- Sinon, si le Pixel Courant Appartient a une case Bleue du Decor
			--	Couleur = Bleu
			else
			-- Sinon, le Pixel Courant Est Noir S'Il Fait Partie du Decor
			--	Couleur = Bleu
			     
			    if (ypos >= 0) and (ypos < 77) then
				    red <= "0000"; green <= "0000"; blue <= "0011"; 
				elsif (ypos >= 77) and (ypos < 259) then
				    red <= "0000"; green <= "0000"; blue <= "0100";
				elsif (ypos >= 259) and (ypos < 350) then
				    red <= "0000"; green <= "0000"; blue <= "0101";
				elsif (ypos >= 350) and (ypos < 398) then
				    red <= "0000"; green <= "0000"; blue <= "0110";
				elsif (ypos >= 398) and (ypos < 432) then
				    red <= "0011"; green <= "0000"; blue <= "0110";
				elsif (ypos >= 432) and (ypos < 461) then
				    red <= "0101"; green <= "0000"; blue <= "0111";
				else 
				    red <= "0110"; green <= "0000"; blue <= "0111";
				end if; 
			end if;


			-- LE PIXEL COURANT EST UNE BRIQUE

			-- Couleur = Blanc
			for i in 0 to 1 loop
				for j in 0 to 8 loop
					if brick(i)(j)='1' then 
						red<="1111"; green<="1111"; blue<="1111"; 
					end if;
				end loop;
			end loop;

			-- LE PIXEL COURANT APPARTIENT A LA BALLE OU LA RAQUETTE

			-- Couleur = Jaune
			if (pad or ball) = '1' then 
				red <= "1111"; green <= "1111"; blue <= "0000"; 
			end if;

			-- PARTIE GAGNEE -> Couleur Vert
			-- PARTIE PERDUE -> Couleur Rouge
	
			if brick_win = '1' then 
				red <= "0000"; green <= "1111"; blue <= "0000"; 
			elsif lost_game = '1' then 
				red <= "1111"; green <= "0000"; blue <= "0000"; 
				--leds <= '1';
			end if;

		
			-- PAS D'AFFICHAGE SI ON EST EN MODE MANETTE
			if master_slave = '0' then
				red <= "0000"; green <= "0000"; blue <= "0000"; 
			end if;
		
		-- Si on Est dans la Zone Non Visible (Synchro)
		--		Les Sorties RGB Sont Mise a Zero
		else
			red <= "0000"; green <= "0000"; blue <= "0000"; 
		end if;
end process;


end Behavioral;

