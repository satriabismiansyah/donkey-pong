----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:21:14 06/04/2010 
-- Design Name: 
-- Module Name:    sound - Behavioral 
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

entity sound is 
    Port (
           bump_sound, miss_sound : in  STD_LOGIC;
           speaker : out  STD_LOGIC_VECTOR(1 downto 0));
end sound;

architecture k of sound is

begin

speaker <=	"00" when bump_sound='1' else 
				"01" when miss_sound ='1' 
				else "11";


end k;

