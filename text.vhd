----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:06:23 04/24/2010 
-- Design Name: 
-- Module Name:    text - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity text is
    Port ( 
           hc,vc : in  std_logic_vector(10 downto 0);
           font_pixel : out  STD_LOGIC;
			  score : in STD_LOGIC_VECTOR(7 downto 0);
			  game_state : in STD_LOGIC_VECTOR(1 downto 0)
			  );
end text;

architecture k of text is
    signal font_addr: std_logic_vector(8 downto 0);
    signal font_data: std_logic_vector(0 to 7);
	 signal message_on : std_logic_vector(0 to 2);
	 signal message_score: std_logic_vector(8 downto 0);
	 signal message_font_addr: std_logic_vector(8 downto 0);
	 signal youwin_font_addr,youlose_font_addr: std_logic_vector(8 downto 0);
	 signal hold_font_addr: std_logic_vector(8 downto 0);
	 signal score1,score2: std_logic_vector(8 downto 0);
	  
begin


    message_on <= 
	 "111" when ( unsigned(vc) <= 175+8  and unsigned(vc) > 175  and unsigned(hc) >= 144+100 and ( game_state="11" or game_state="01") )
	 else 
	 "110" when ( unsigned(vc) <= 350+8  and unsigned(vc) > 350  and unsigned(hc) >= 144+100 and ( game_state="11" or game_state="01") )
	 else
	 "001" when  (unsigned(vc) <= 271+20 and unsigned(vc) > 271-32 and unsigned(hc) >= 144+7 and unsigned(hc) <= 151+7   and   game_state /="11") OR (unsigned(vc) <= 223+8  and unsigned(vc) > 223    and unsigned(hc) >= 144+100 and ( game_state="11" or game_state="01") ) 
    else 
	 "010" when (unsigned(vc) <= 271+25 and unsigned(vc) > 271-20 and  unsigned(hc) >= 144+16+7 and unsigned(hc) <= 144+22+7 and unsigned(hc) > 144+16  and game_state /="11")
    
	 else "000";

	with score(3 downto 0) select
	score1 <=			"010001000" when "0001",
							"010010000" when "0010",
							"010011000" when "0011",
							"010100000" when "0100",
							"010101000" when "0101",
							"010000000" when others;

	with score(7 downto 4) select
	score2 <=			"010001000" when "0001",
							"010010000" when "0010",
							"010011000" when "0011",
							"010100000" when "0100",
							"010101000" when "0101",
							"010000000" when others;

	with vc(8 downto 3) select
   message_font_addr <= "110011000" when "011110", -- S
	 						   "100011000" when "011111", -- C
							   "101111000" when "100000", -- O
							   "110010000" when "100001", -- R
							   "100101000" when "100010", -- E
							 	"000000000" when others;
										
	with vc(8 downto 3) select
   message_score <=   score1 when "100000", -- score
						  	 score2 when "100001", -- score
						 	 "000000000" when others;								
										
	with hc(10 downto 3)&game_state select
	 youwin_font_addr <=   "111001000" when "0011011011", -- Y -
								  "101111000" when "0011011111", -- O -
								  "110101000" when "0011100011", -- U -
								  "000000000" when "0011100111", --   -- colone 464
								  "110111000" when "0011101011", -- W -
								  "101001000" when "0011101111", -- I -
								  "101110000" when "0011110011", -- N -
								  "000000000" when others;
								  
	with hc(10 downto 3)&game_state select
	 youlose_font_addr <=  "111001000" when "0011011011", -- Y -
								  "101111000" when "0011011111", -- O -
								  "110101000" when "0011100011", -- U -
								  "000000000" when "0011100111", --   -- colone 464
								  "101100000" when "0011101011", -- L -
								  "101111000" when "0011101111", -- O -
								  "110011000" when "0011110011", -- S -
								  "100101000" when "0011110111", -- E -
								  "000000000" when others;								  
									  
	with hc(10 downto 3)&game_state select
	hold_font_addr <= "110000000" when "0011011001", -- P -
							"110010000" when "0011011101", -- R -
						   "100101000" when "0011100001", -- E -
						   "110011000" when "0011100101", -- S
						   "110011000" when "0011101001", -- S
						   "000000000" when "0011101101", --   -- colone 465
						   "110011000" when "0011110001", -- S 
						   "110100000" when "0011110101", -- T 
						   "100001000" when "0011111001", -- A -
						   "110010000" when "0011111101", -- R -
						   "110100000" when "0100000001", -- T 
						   "000000000" when others;


    -- font address mutltiplexer
	 
    font_addr <= vc(2 downto 0)  + message_font_addr + hold_font_addr when message_on = "001" else
					  vc(2 downto 0)  + message_score when message_on = "010" else 
					  
					  vc(2 downto 0)  + youlose_font_addr when message_on = "111"  and score(7 downto 4)="0110" else 
					  vc(2 downto 0)  + youwin_font_addr  when message_on = "110"  and score(7 downto 4)="0110" else					  
					  
					  vc(2 downto 0)  + youlose_font_addr when message_on = "110"  and score(3 downto 0)="0110" else 
					  vc(2 downto 0)  + youwin_font_addr  when message_on = "111"  and score(3 downto 0)="0110" 
					  else (others => '0');
    font_pixel <= font_data(conv_integer(hc(2 downto 0)));






font_unit:
        entity work.codepage_rom(content)
        port map(addr => font_addr, data => font_data);
end k;

