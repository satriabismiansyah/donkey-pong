----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:18:56 04/09/2010 
-- Design Name: 
-- Module Name:    speed - Behavioral 
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

entity speed is
    Port ( clk,reset,frame : in  STD_LOGIC;
           update : out  STD_LOGIC);
end speed;

architecture k of speed is
signal frame_in: std_logic;
begin

--frame_in <= frame+1 when rising_edge(clk) else frame;
update <= '1';-- when frame_in='1' else '0'; 


end k;

