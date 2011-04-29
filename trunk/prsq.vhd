----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:06:13 04/03/2010 
-- Design Name: 
-- Module Name:    prsq - Behavioral 
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



entity prsq is
    Port ( clk_50mhz : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  
			  --CONTROLLERS
			  padone,padtwo: in STD_LOGIC;
			  padone2,padtwo2: in STD_LOGIC;
			  robot : in STD_LOGIC;
			  padon : in STD_LOGIC;
			 -- start: in STD_LOGIC;
			  ps2d,ps2c: in STD_LOGIC;
			  
			  --SPEAKER
			  speaker_out : out STD_LOGIC;
			  
			  --VGA
			  h_sync_out,v_sync_out : out  STD_LOGIC;
			  rgb_out : out STD_LOGIC_VECTOR(8 downto 0);

			  --LED
			  led_out : out std_logic_vector(7 downto 0);
			  led_on : out std_logic_vector(3 downto 0);
					  
			  --DEBUGGING	
--			  speaker_tmp : out STD_LOGIC_VECTOR(1 downto 0);
	  --	   frame_out: out std_logic;
     --		position_out : out STD_LOGIC_VECTOR(10 downto 0);
     --     ball_x_out,ball_y_out : out STD_LOGIC_VECTOR(10 downto 0)
	  --	   clk_out: out STD_LOGIC;
	  --	   video_out: out STD_LOGIC;
	  --     hc_out,vc_out : out std_logic_vector(10 downto 0);
	  			clk_out : out STD_LOGIC;
	  			clk_100hz_out : out STD_LOGIC
--	  			clk_1s_out : out STD_LOGIC

			  );
end prsq;

architecture archi of prsq is


signal h, video_on : std_logic;
signal frame,font_pixel : std_logic;
signal hc_in,vc_in : std_logic_vector(10 downto 0);
signal ps2_out : std_logic_vector(7 downto 0);
signal inone,intwo : std_logic;
signal inone2,intwo2 : std_logic;
--signal launch : std_logic;
signal start,breset : std_logic;
signal score : STD_LOGIC_VECTOR(7 downto 0); 
signal game_state : STD_LOGIC_VECTOR(1 downto 0);
signal rx_done_tick : std_logic;
signal note1,note2 : std_logic;
--signal clk_1s : std_logic;
signal img_pixel : std_logic;
--signal home_over : std_logic;
signal speaker : STD_LOGIC_VECTOR(1 downto 0);

signal ball_bounced, ball_missed : std_logic;

begin

clk_gen: entity work.clkgen(k) 		port map (
													reset => reset, 
													input => clk_50mhz, 
													output => h,
													clk_1khz => note1,
													clk_100hz => note2
--													clk_1s => clk_1s
);


vga_sync: entity work.signalsync(k) port map (
													clk => h, reset =>reset, 
													h_sync => h_sync_out, v_sync => v_sync_out, 
													video_on => video_on, 
													hc_out=>hc_in, vc_out=>vc_in, 
													frame=>frame
);

rgb_mod: entity work.affiche(k)	  port map (
													clk => h,reset=>reset,
													frame=>frame,
													hc=>hc_in, vc=>vc_in,
													video_on=>video_on,
													rgb=>rgb_out,font_pixel=>font_pixel,
													inone=>inone,intwo=>intwo,inone2=>inone2,intwo2=>intwo2,
													start=>start,breset=>breset,
													led_out=>led_out, led_on=>led_on,
													score_out=>score,
													game_state_out=>game_state,
													img_pixel=>img_pixel,
													--clk_1s=>clk_1s,
													robot=>robot,
													ball_bounced =>ball_bounced,ball_missed=>ball_missed
												
);
text_mod: entity work.text(k)	   port map (
													hc=>hc_in, vc=>vc_in,
													font_pixel=>font_pixel,
													score=>score,
													game_state=>game_state
);
ps2_key: entity work.ps2_rx(k)	port map (
													clk => h,reset=>reset,frame=>frame,
													ps2d =>ps2d, ps2c =>ps2c,
													dout => ps2_out, rx_done_tick=>rx_done_tick
);

sound: entity work.sound(k)  port map(
													bump_sound => ball_bounced, miss_sound => ball_missed,
													speaker => speaker
);

home: entity work.home(k)  port map(   --clk=>clk_1s,reset=>reset,home_over=>home_over,
													hc=>hc_in, vc=>vc_in, img_pixel=>img_pixel
													--, launch=>launch
);
inone <= '1' when ps2_out="01110100" and rx_done_tick='1' and padon='0' else padone;  
intwo <= '1' when ps2_out="01101011" and rx_done_tick='1' and padon='0' else padtwo;

inone2 <= '1' when ps2_out="00010001" and rx_done_tick='1' and padon='0' else padone2;
intwo2 <= '1' when ps2_out="00010100" and rx_done_tick='1' and padon='0'  else padtwo2;

start <= '1' when ps2_out="00101001" and rx_done_tick='1' else '0';
breset <= '1' when ps2_out="01011010" and rx_done_tick='1' else '0';
--launch <= '1' when ps2_out="01110110" and rx_done_tick='1' else '0';


with speaker select
	speaker_out <=		note1 when "00",
							note2 when "01",
							'0' when others;


--debugaaaage
clk_out<=h;
clk_100hz_out<=note1;
--clk_1s_out<=clk_1s;


end archi;

