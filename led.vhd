----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:38:08 04/11/2010 
-- Design Name: 
-- Module Name:    led - Behavioral 
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



entity led is
    Port ( 
			  score : in std_logic_vector(3 downto 0);
			  led_out : out std_logic_vector(7 downto 0);
			  led_on: out std_logic_vector(3 downto 0)
			  );
          
end led;

architecture k of led is

begin

--AFFICHAGE DE LA RAQUETTE


	with score select
	led_out <=	"00000011" when "0000",
					"10011111" when "0001",
					"00100101" when "0010",
					"00001101" when "0011",
					"10011001" when "0100",
					"01001001" when "0101",
					"01000001" when "0110",
					"00011111" when "0111",
					"00000001" when "1000",
					"00001001" when "1001",
					"11100011" when others;
			

led_on <= "0111";

end k;

