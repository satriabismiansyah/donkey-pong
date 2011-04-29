----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:52:54 04/08/2010 
-- Design Name: 
-- Module Name:    ball - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ball is
    Port ( clk,reset : in  STD_LOGIC;
			  frame,bstart,breset : in  STD_LOGIC;
			  --turn : out STD_LOGIC;
           score_out : out STD_LOGIC_VECTOR(7 downto 0);
           barrepos,barrepos2 : in  STD_LOGIC_VECTOR(10 downto 0);
           ball_x,ball_y : out  STD_LOGIC_VECTOR(10 downto 0);
			  game_state : out STD_LOGIC_VECTOR(1 downto 0);
			  ball_bounced, ball_missed : out STD_LOGIC
			  );
end ball;

architecture k of ball is
signal x,y :  STD_LOGIC_VECTOR(10 downto 0); 
signal score,score_next :  STD_LOGIC_VECTOR(7 downto 0); 
signal valeur_incr :  STD_LOGIC_VECTOR(7 downto 0); 
signal onbarre,onbarre2 : std_logic;
type state is (
	start,
	hold,
	play,
	over,
	p00,
	p01,
	p10,
	p11
);
signal present, futur: state;



begin

with present select
game_state <=	"10" when start,
					"00" when play,
					"11" when over,
					"01" when hold,
					"00" when others;
					
--turn <= '1' when present=p00 or present=p01 else '0';

--evolution
process(present,onbarre,onbarre2,bstart,breset,score,x,y)
begin
futur <= present;
score_next<=score;
--barre_reset<='0';

case present is

---ETATS DU JEU
	when start	=> 	score_next<="00000000";
							futur <= hold;
							
	when hold 	=>		if score(7 downto 4) = "0110" or score(3 downto 0) = "0110" then futur<= over;
							elsif bstart ='1' then 
							futur<= play;
							else futur<=hold;
							end if;
							 
	when play 	=>    futur <= p01; 
							
	when over	=>		if breset ='1' then
							futur<= start;
							else futur <= over;
							end if;

---ETATS DE MOVEMENT DE LA BALLE
	when p00 => if x>764  then futur <= p01;
					elsif onbarre2='1' then futur <= p11;
					elsif y<34 and onbarre2='0' then futur <= hold; score_next(7 downto 4) <= score(7 downto 4) + 1;
					else futur <= p00;end if;
								
	when p01 => if x<164 then futur <= p00;
					elsif onbarre2='1' then futur <= p10; 
					elsif y<35 and onbarre2='0' then futur <= hold; score_next(7 downto 4) <= score(7 downto 4) + 1; 
					else futur <= p01;end if;
									
	when p10 => if x<164  then futur <= p11; 
					elsif onbarre='1' then futur <= p01; 
					elsif y>509 and onbarre='0' then futur <= hold; score_next(3 downto 0) <= score(3 downto 0) + 1;
					else futur <= p10;end if;
							
	when p11 => if x>764 then futur <= p10;
					elsif onbarre='1' then futur <= p00; 
					elsif y>509 and onbarre='0'  then futur <= hold; score_next(3 downto 0) <= score(3 downto 0) + 1;
					else futur <= p11;end if;

end case;  
end process;


--synchronisation
process(clk,reset,x,y)
begin
if reset='1' then 
present <= start; 
score <= "00000000";  -- sur 4bits
y <= "00011111111"; 
x <= "00111010000"; 
valeur_incr <="01000000"; 
elsif rising_edge(clk) then 
present <= futur; 
score <= score_next;

	if(frame='1') then
			case present is
			when p00 => y <= unsigned(y)-unsigned(valeur_incr (7 downto 4));  
							x<= unsigned(x)+unsigned(valeur_incr (3 downto 0));
							
			when p01 => y <= unsigned(y)-unsigned(valeur_incr (7 downto 4));  
							x<= unsigned(x)-unsigned(valeur_incr (3 downto 0)); 
							
			when p10 => y <= unsigned(y)+unsigned(valeur_incr (7 downto 4));  
							x<= unsigned(x)-unsigned(valeur_incr (3 downto 0)); 
							
			when p11 => y <= unsigned(y)+unsigned(valeur_incr (7 downto 4));  
							x<= unsigned(x)+unsigned(valeur_incr (3 downto 0)); 
							
			when play => valeur_incr <=valeur_incr ; 
			when hold => y <= "00011111111";   x<= "00111010000"; valeur_incr <="01000000"; 
			when over => y <= "00011111111";   x<= "00111010000";  valeur_incr <="01000000"; 
			when others => null;
			end case;
	end if;
	
	
	-- barre 1
	if y>=510-8 and (x>barrepos-25 and x<=barrepos+25) then 
			if valeur_incr <="01000000" then  valeur_incr <="10000000";
			else 
			valeur_incr  <= "01010101"; 
			end if;
	
	elsif y>=510-8 and (x>=barrepos-50  and x<=barrepos-25) then 
	valeur_incr  <= "01000110"; 
	
	elsif y>=510-8 and (x>barrepos+25  and x<=barrepos+50) then 
	valeur_incr  <= "01000110"; 
	
	elsif y>=510-8 and (x>=barrepos-64 and x<barrepos-50) then 
	case present is
			when p10 => valeur_incr  <= "00101000"; 
			when p11 => valeur_incr  <= "01110001"; 
			when others => null;
	end case;
	
	elsif y>=510-8 and (x>barrepos+50 and x<=barrepos+64) then 
	case present is
			when p10 => valeur_incr  <= "01110001"; 
			when p11 => valeur_incr  <= "00101000"; 
			when others => null;
	end case;
	end if;
	
	
	
	
	-- barre 2
if y<=40+8 and (x>barrepos2-25 and x<=barrepos2+25) then 
			if valeur_incr <="01000000" then  valeur_incr <="10000000";
			else 
			valeur_incr  <= "01010101"; 
			end if;
	
	elsif y<=40+8 and (x>=barrepos2-50  and x<=barrepos2-25) then 
	valeur_incr  <= "01000110"; 
	
	elsif y<=40+8 and (x>barrepos2+25  and x<=barrepos2+50) then 
	valeur_incr  <= "01000110"; 
	
	elsif y<=40+8 and (x>=barrepos2-64 and x<barrepos2-50) then 
	case present is
			when p00 => valeur_incr  <= "10000010"; 
			when p01 => valeur_incr  <= "00101000"; 
			when others => null;
	end case;
	
	elsif y<=40+8 and (x>barrepos2+50 and x<=barrepos2+64) then 
	case present is
			when p00 => valeur_incr  <= "00101000"; 
			when p01 => valeur_incr  <= "10000010"; 
			when others => null;
	end case;
	end if;
	
	
	
	
	
	
	
	
	

end if;
end process;


--actions
process(present,y,x)
begin

case present is
	when start => ball_y <= y; ball_x <= x; 
	when hold => ball_y <= y; ball_x <= x; 
	when play => ball_y <= y; ball_x <= x; 
	when over => ball_y <= y; ball_x <= x; 
	when p00  => ball_y <= y; ball_x <= x; 
	when p01  => ball_y <= y; ball_x <= x; 
	when p10  => ball_y <= y; ball_x <= x; 
	when p11  => ball_y <= y; ball_x <= x; 
	when others => null;
end case;

end process;

onbarre <= '1' when y>(510-8) and ( x>=barrepos - 64 and x<=barrepos + 64) else '0'; 
onbarre2 <= '1' when y<(45) and ( x>=barrepos2 - 64 and x<=barrepos2 + 64) else '0'; 

ball_bounced <= '1' when onbarre='1' or onbarre2='1' else '0';
ball_missed <= '1' when y>510-9 or y<47 else '0';

score_out <= score;

end k;