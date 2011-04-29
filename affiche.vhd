----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:48:06 04/05/2010 
-- Design Name: 
-- Module Name:    affiche - Behavioral 
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
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity affiche is
 generic(    N   : natural := 1000000000	); 
	Port ( clk,reset,video_on,font_pixel : in  STD_LOGIC;
		hc,vc : in std_logic_vector(10 downto 0);
		rgb : out STD_LOGIC_VECTOR(8 downto 0);
		inone,intwo,inone2,intwo2,start,breset: in STD_LOGIC;
		frame: in STD_LOGIC;
		led_out : out std_logic_vector(7 downto 0);
		led_on : out std_logic_vector(3 downto 0);
		score_out : out STD_LOGIC_VECTOR(7 downto 0);
		game_state_out: out STD_LOGIC_VECTOR(1 downto 0);
		robot: in STD_LOGIC;
		img_pixel: in STD_LOGIC;
--		clk_1s: in STD_LOGIC;
		--home_over: in STD_LOGIC;
	--	turn : out STD_LOGIC;
		ball_bounced, ball_missed : out STD_LOGIC
	);
          
end affiche;

architecture k of affiche is
signal barrepos : std_logic_vector(10 downto 0);
signal barrepos2,barrepos2_int : std_logic_vector(10 downto 0);

signal ball_x,ball_y :  STD_LOGIC_VECTOR(10 downto 0); 
signal score :  STD_LOGIC_VECTOR(7 downto 0); 
signal barre_on,barre_on2,ball_on: std_logic;
signal game_state : STD_LOGIC_VECTOR(1 downto 0);

constant BALL_SIZE: integer:= 8; --half bal size
signal  ball_addr, ball_col:  unsigned(3  downto  0); 
signal  ball_data			 :  std_logic_vector(15  downto  0); 
signal  ball_bit,in_ball_on		 :  std_logic;  

constant BAR_SIZE: integer:= 64; -- half barre size
--signal  bar_addr,bar_addr2:  unsigned(2  downto  0); 
--signal  bar_col,bar_col2 :  unsigned(6  downto  0); 
--signal  bar_data,bar_data2			 :  std_logic_vector(127  downto  0); 
--signal  bar_bit,in_bar_on  :  std_logic; 
signal  middle_line  :  std_logic; 
signal  home_over  :  std_logic; 
--signal  background		 :  std_logic; 
--signal  traits		 :  std_logic; 
--signal  in_bar_on2,bar_bit2		 :  std_logic;  
 

begin

barrepos2 <= ball_x when robot='0' else barrepos2_int;



--COMPTEUR
process(clk,reset)
      variable counter : natural range 0 to N-1;
  begin
   if reset='1' then 			 
     counter := 0;	  
	elsif rising_edge(clk) then 
		if counter = N-1 then  counter := 0;
		else counter := counter+1;	
	   end if;
		
	if counter <= 300000000 then home_over<='1'; 
	else home_over<='0'; 
	end if;
	
   end if;
end process;
 

--AFFICHAGE 
process(clk)
	begin
	 	if rising_edge(clk) and  video_on = '1' then

			if home_over='1' then
			
				if img_pixel='1' and score ="00000000" and game_state ="01" then rgb<="111111111";	
				else	rgb<="000000000";	
				end if; 
				
			else 

				if barre_on='1' and game_state /="11"  then	rgb<="000111111";	
				elsif barre_on2='1' and game_state /="11" then	rgb<="111111000";		
				elsif ball_on='1' and game_state /="11" then	rgb<="111111111";				
				elsif font_pixel='1' then	rgb<="111111111";				
				elsif middle_line='1' then	rgb<="001001010";				
--				elsif img_pixel='1' then	rgb<="001001010";				
				else	rgb<="000000000";	
				end if;


			end if;
		end if;
end process;

--------------------------------------------------------------------------
--------------------------------------------------------------------------

----BARRE1
--barre_on  <= '1'  when  in_bar_on='1'  and bar_bit='1'  else '0'; 
--in_bar_on  <= '1' when 
--					unsigned(hc) >= unsigned(barrepos)-BAR_SIZE  and 
--					unsigned(hc) <= unsigned(barrepos)+BAR_SIZE-1 and 
--					unsigned(vc) >= 504  and 
--					unsigned(vc) <= 512 
--			   else '0'; 
----  map  current  pixel  location  to  ROM  addr/col 
--bar_addr  <=  unsigned(vc(2  downto  0)); 
--bar_col   <=  unsigned(hc(6  downto  0)) - unsigned(barrepos(6 downto 0)-BAR_SIZE); 
--bar_bit   <=  bar_data(to_integer(not bar_col)); 
--
--
--
--
----BARRE2
--barre_on2  <= '1'  when  in_bar_on2='1'  and bar_bit2='1'  else '0'; 
--in_bar_on2  <= '1' when 
--					unsigned(hc) >= unsigned(barrepos2)-BAR_SIZE  and 
--					unsigned(hc) <= unsigned(barrepos2)+BAR_SIZE-1 and 
--					unsigned(vc) >= 33  and 
--					unsigned(vc) <= 40 
--			   else '0'; 
----  map  current  pixel  location  to  ROM  addr/col 
--bar_addr2  <=  unsigned(vc(2  downto  0)); 
--bar_col2   <=  unsigned(hc(6  downto  0)) - unsigned(barrepos2(6 downto 0)-BAR_SIZE); 
--bar_bit2   <=  bar_data2(to_integer(not bar_col2)); 
--
--

barre_on  <= '1' when 
					unsigned(hc) >= unsigned(barrepos)-BAR_SIZE  and 
					unsigned(hc) <= unsigned(barrepos)+BAR_SIZE-1 and 
					unsigned(vc) >= 504  and 
					unsigned(vc) <= 512 
			   else '0'; 
barre_on2  <= '1' when 
					unsigned(hc) >= unsigned(barrepos2)-BAR_SIZE  and 
					unsigned(hc) <= unsigned(barrepos2)+BAR_SIZE-1 and 
					unsigned(vc) >= 33  and 
					unsigned(vc) <= 40 
			   else '0'; 
--BALL
ball_on  <= '1'  when  in_ball_on='1'  and ball_bit='1'  else '0'; 
in_ball_on  <= '1' when 
					unsigned(hc) >= unsigned(ball_x)-BALL_SIZE  and 
					unsigned(hc) <= unsigned(ball_x)+BALL_SIZE-1 and 
					unsigned(vc) >= unsigned(ball_y)-BALL_SIZE  and 
					unsigned(vc) <= unsigned(ball_y)+BALL_SIZE-1 
			   else '0'; 
ball_addr  <=  unsigned(vc(3  downto  0)) - unsigned(ball_y(3 downto 0)-BALL_SIZE ); 
ball_col   <=  unsigned(hc(3  downto  0)) - unsigned(ball_x(3 downto 0)-BALL_SIZE ); 
ball_bit   <=  ball_data(to_integer(ball_col)); 



--MIDDLE LINE
middle_line<= '1' when unsigned(vc)=264 and hc(3)='1' else '0';

--background<= '1' when unsigned(vc)>=32 and unsigned(vc)<=512 and hc(3)='1' else '0';

--traits<= '1' when (unsigned(hc)>=104 and unsigned(hc)<=144+4) OR 	(unsigned(hc)>=135+640 and unsigned(hc)<=150+4+640)			else '0';

--------------------------------------------------------------------------
--------------------------------------------------------------------------

--BARRE
barre: entity work.barre(k) port map (
												clk => clk, reset =>reset, 
												mvright=>inone,mvleft=>intwo,
												position=>barrepos,
												mvright2=>inone2,mvleft2=>intwo2,
												position2=>barrepos2_int,
												game_state=>game_state,
												frame=>frame
												--,robot=>robot
												);
												
--BALL
ball: entity work.ball(k) port map (
												clk => clk, reset =>reset, 
												frame=>frame,score_out=>score,
												ball_x => ball_x, ball_y=> ball_y,
												barrepos=>barrepos,barrepos2=>barrepos2,bstart=>start,breset=>breset,
												game_state=>game_state,
												--turn=>turn,
												ball_bounced => ball_bounced, ball_missed=>ball_missed
												);

--LED
led: entity work.led(k) port map (
												score=>score(3 downto 0), 
												led_out=>led_out, 
												led_on=>led_on
												);

--ROM												
ball_unit: entity work.ball_rom(content) port map(addr => ball_addr, data => ball_data);
--bar_unit: entity work.bar_rom(content) port map(clk => clk, addr => bar_addr, data => bar_data, addr2 => bar_addr2, data2 => bar_data2);



--------------------------------------------------------------------------
--------------------------------------------------------------------------

game_state_out<=game_state;
score_out<=score;

end k;

