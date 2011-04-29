----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:38:25 05/19/2010 
-- Design Name: 
-- Module Name:    barrebis - Behavioral 
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

entity barrebis is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           mvright : in  STD_LOGIC;
           mvleft : in  STD_LOGIC;
           position : out  STD_LOGIC);
end barrebis;

architecture Behavioral of barrebis is

begin


end Behavioral;

