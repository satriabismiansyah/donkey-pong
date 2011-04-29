----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:13:56 06/10/2010 
-- Design Name: 
-- Module Name:    home - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity home is
    Port ( --clk,reset : in std_logic;
				hc,vc : in  std_logic_vector(10 downto 0);
--			  launch : in std_logic;
			  img_pixel : out  STD_LOGIC
			  --home_over : out std_logic
			  );
end home;

architecture k of home is
constant IMG_SIZE: integer:= 64; --half bal size
signal  img_addr:  unsigned(4  downto  0); 
signal  img_col:  unsigned(6  downto  0); 
signal  img_data :  std_logic_vector(127  downto  0); 
signal  img_bit,in_img_on :  std_logic;  
--signal  count,count_in : unsigned(10 downto 0);
--signal font_addr: std_logic_vector(8 downto 0);
--signal font_data: std_logic_vector(0 to 7);
--signal message_on : std_logic_vector(0 to 1);
--signal welcome_font_addr,donkey_font_addr: std_logic_vector(8 downto 0);
--signal font_pixel : std_logic;
begin


img_pixel  <= '1' when  in_img_on='1' and img_bit='1'   else '0'; 
in_img_on  <= '1' when 	unsigned(hc) >= 405 and  
								unsigned(hc) <= 518 and 
								unsigned(vc) <= 240+31 and 
								unsigned(vc) >= 238 
								else '0'; 
								
img_addr  <=  unsigned(vc(4  downto  0)-16); 
img_col   <=  unsigned(hc(6  downto  0)); 
img_bit   <=  img_data(to_integer(img_col)); 

--
--    message_on <= 
--	 "01" when unsigned(vc) <= 175+80  and unsigned(vc) > 175  and unsigned(hc) >= 405
--	 else 
--	 "10" when unsigned(vc) <= 350+80  and unsigned(vc) > 350  and unsigned(hc) >= 405
--	 else "00";
--	 font_addr <= vc(2 downto 0)  + welcome_font_addr when message_on = "01" else
--					  vc(2 downto 0)  + donkey_font_addr when message_on = "10" else 
--					 (others => '0');
--    font_pixel <= font_data(conv_integer(hc(2 downto 0)));
--
--
--
--	with hc(10 downto 3) select
--	welcome_font_addr <= "110111000" when "00110010", -- W -
--							"100101000" when    "00110011", -- E -
--						   "101100000" when "00110100", -- L -
--						   "100011000" when "00110101", -- C
--						   "101111000" when "00110110", -- O
--						   "101101000" when "00110111", -- M
--						   "100101000" when "00111000", -- E
--						   "000000000" when "00111001", --   -- colone 465
--						   "110100000" when "00111010", -- T
--						   "101111000" when "00111011", -- O 
--						   "000000000" when others;
--
--	with hc(10 downto 3) select
--	donkey_font_addr <= "100100000" when "00110010", -- D -
--							"101111000" when "00110011", -- O 
--						   "101110000" when "00110100", -- N 
--						   "101011000" when "00110101", -- K 
--						   "100101000" when "00110110", -- E
--						   "111001000" when "00110111", -- Y
--						   "000000000" when "00111000", --   -- colone 465
--						   "110000000" when "00111001", -- P
--						   "101111000" when "00111010", -- O
--						   "101110000" when "00111011", -- N
--						   "100111000" when "00111100", -- G 
--						   "000000000" when others;


image: entity work.image(content) port map(addr => img_addr, data => img_data);
--font_unit: entity work.codepage_rom(content) port map(addr => font_addr, data => font_data);
end k;

