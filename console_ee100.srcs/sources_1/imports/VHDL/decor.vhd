----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Generation du Decor et Gestion de l'Obstacle du Jeu Pong
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity decor is
    Port (	clk25: in STD_LOGIC;								-- Horloge 25 MHz
				reset: in STD_LOGIC;								-- Reset Asynchrone
				
				-- INDICATIONS D'AFFICHAGE DES PIXELS
				endframe: in  STD_LOGIC;						-- Fin de l'Image Visible 
				xpos : in  STD_LOGIC_VECTOR (9 downto 0);	-- Coordonnee X du Pixel Courant
				ypos : in  STD_LOGIC_VECTOR (9 downto 0);	-- Coordonnee Y du Pixel Courant
				
				-- PARAMETRES DE JEU
				game_type: in STD_LOGIC;						-- Type de Jeu
				obstacle: in STD_LOGIC;							-- Parametre Obstacle
			  
				-- ELEMENTS DE DECOR
				bluebox : out  STD_LOGIC;						-- Pixel Courant = Case Bleue
				left: out STD_LOGIC;								-- Pixel Courant = Gauche de l'Ecran
				right: out STD_LOGIC;							-- Pixel Courant = Droite de l'Ecran
				bottom : out  STD_LOGIC;						-- Pixel Courant = Bas de l'Ecran
				barrier: out std_logic;							-- Pixel Courant = Obstacle (Jeu Pong)
				wall_top : out  STD_LOGIC;						-- Pixel Courant = Mur du Haut
				wall_bottom : out  STD_LOGIC;					-- Pixel Courant = Mur du Bas
				wall_left : out  STD_LOGIC;					-- Pixel Courant = Mur de Gauche
				wall_right : out  STD_LOGIC;					-- Pixel Courant = Mur de Droite
				wall_pong : out  STD_LOGIC;					-- Pixel Courant = Mur Jeu Casse Briques
				wall_brick : out  STD_LOGIC);					-- Pixel Courant = Mur Jeu Pong
end decor;

architecture Behavioral of decor is

signal xbarrier: std_logic;						-- Coordonnees X du Pixel dans la Zone de l'Obstacle
signal xbarrier2: std_logic;						-- Coordonnees X du Pixel dans la Zone de l'Obstacle

signal ybarrier: std_logic;	-- Corrdonnees en Y de l'Obstacle
signal direction: std_logic;
signal direction2: std_logic;
signal my_pixel :std_logic_vector(9 downto 0);					-- Sens de Deplacement de l'Obstacle
signal my_pixel2 :std_logic_vector(9 downto 0);					-- Sens de Deplacement de l'Obstacle

signal ok : std_logic;

begin

-------------------------------------------------------------------------------------------

	-- GESTION DU DECOR
		-- Damier Bleu et Noir de Fond d'Ecran
		-- Generation des Murs (En Fonction du Jeu Choisi)
		-- Signal de Bas de l'Ecran
	process (xpos,ypos,game_type)

	begin

		wall_pong	<= '0';
		wall_brick	<= '0';
		wall_left	<=	'0';
		wall_right	<=	'0';
		wall_top 	<=	'0';
		wall_bottom	<=	'0';
		left			<= '0';
		right			<= '0';
		bottom 		<=	'0';
		bluebox		<=	'0';

		
		-- Delimitation des Cases Bleues
			-- Tous les 32x32 Pixels
		bluebox <= xpos(3) xor ypos(3);
		
		
		-- Mur Haut (Present dans Pong et Casse Briques)
		if (ypos < 4) then 
			wall_top <= '1'; wall_brick <= '1'; wall_pong <= '1';
		end if;

		-- Si on Joue au Casse Briques
		if game_type = '0' then
			
			-- Mur Gauche
			if (xpos <= 4) then 
				wall_left <= '1'; wall_brick <= '1';
			end if;
		
			-- Mur Droit
			if (xpos > 635) then 
				wall_right <= '1'; wall_brick <= '1';
			end if;
	
			-- Bas de l'ecran
			if (ypos > 475) then 
				bottom <= '1'; 
			end if;
						
		-- Si on Joue a Pong
		else

			-- Mur du Bas
			if (ypos > 475) then 
				wall_bottom <= '1'; wall_pong <= '1';
			end if;

			-- Bord Gauche de L'Ecran
			if (xpos <= 4) then 
				left <= '1';
			end if;
		
			-- Bord Droit de l'Ecran
			if (xpos > 635) then 
				right <= '1';
			end if;


		end if;
	
	end process;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

ok <= not(game_type) and obstacle;

-- OBSTACLE : MOVE LEFT OR RIGHT ?
process( Clk25 , reset , direction , endframe , my_pixel, my_pixel2 ,direction2 ) 
begin
    if reset = '0' then 
        direction <= '1';
        direction2 <= '0';
        my_pixel <= "0101000001"; -- 322
        my_pixel2 <="0100111110"; -- 318
    
    elsif rising_edge(clk25) and (endframe = '1') then
    
        if my_pixel >= "1000011101" then --542
            direction <= '0';
        elsif my_pixel <= "0101000001" then --320
            direction <= '1';
        else 
            direction <= direction;
        end if;
        
        if my_pixel2 >= "0100111110" then  --318
            direction2 <= '0';
        elsif my_pixel2 <= "0001100010" then --98
            direction2 <= '1';
        else 
            direction2 <= direction2;
        end if;
        
        if direction = '0' then
            my_pixel <= my_pixel - 2;
        elsif direction = '1' then
            my_pixel <= my_pixel + 2;
        end if;
        
        if direction2 = '0' then
            my_pixel2 <= my_pixel2 - 2;
        elsif direction2 = '1' then
            my_pixel2 <= my_pixel2 + 2;
        end if;
        
    end if;
end process;

-- XBARRIER AND YBARRIER <3 
process( clk25 , reset , xpos , ypos , my_pixel ,  my_pixel2 ) 
begin
    if reset = '0' then 
        xbarrier <= '0';
        xbarrier2 <= '0';
        ybarrier <= '0';
        
    elsif rising_edge(clk25) then
        if (ypos>235) and (ypos<244) then
            ybarrier <= '1';
        else 
            ybarrier <= '0';
        end if;
        
        if (my_pixel <= xpos) and (xpos <= my_pixel +98) then
            xbarrier <= '1';
        else 
            xbarrier <= '0';
        end if;
        
        if ( (my_pixel2 -98) <= xpos) and (xpos <= my_pixel2) then
            xbarrier2 <= '1';
        else 
            xbarrier2 <= '0';
        end if;
     end if;
end process;  

-- DETERMINE : is this pixel a barrier pixel (:3)
process( ybarrier , xbarrier , ok , xbarrier2)
begin
    if ok = '1' then
        if ((xbarrier = '1') or (xbarrier2 = '1')) and (ybarrier = '1') 
            then barrier <= '1';
        else 
            barrier <= '0';
        end if;
    end if;
end process;
    
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

end Behavioral;

