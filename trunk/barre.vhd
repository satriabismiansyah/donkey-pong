---------------------------------- ------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:26:56 04/08/2010 
-- Design Name: 
-- Module Name:    barre - Behavioral 
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

entity barre is 
    Port ( clk,reset : in  STD_LOGIC;
           mvright,mvleft : in  STD_LOGIC;
			  mvright2,mvleft2 : in  STD_LOGIC;
           frame : in  STD_LOGIC;
           position : out  STD_LOGIC_vector(10 downto 0);
			  position2 : out  STD_LOGIC_vector(10 downto 0);
			  game_state : in  STD_LOGIC_vector(1 downto 0)
			  );
end barre;

architecture k of barre is
signal pos :  STD_LOGIC_vector(10 downto 0);
signal pos2 :  STD_LOGIC_vector(10 downto 0);
constant barre_incr: integer:= 7; -- half barre size
constant HMIN: integer:= 144+68; -- half barre size
constant HMAX: integer:= 784-68; -- half barre size

begin

process (clk, reset,game_state)
begin
if (reset='1' or game_state="01") then pos<= "00111010000";		else 

if ( rising_edge(clk)) and frame='1'  then 
	if ( mvright='1' and mvleft='0' and pos<HMAX ) -- 744 = 144+640 -40
			then	pos<= pos + barre_incr; 
	elsif (mvright='0' and mvleft='1' and pos>HMIN ) -- 184 = 144 +40
			then	pos<= pos - barre_incr; 
	else pos<= pos;
	end if;
end if;

end if;
end process ;



process (clk, reset,game_state)
begin
if (reset='1' or game_state="01") then pos2<= "00111010000";		else 

if ( rising_edge(clk)) and frame='1' then
	if ( mvright2='1' and mvleft2='0' and pos2<HMAX ) -- 744 = 144+640 -40
			then	pos2<= pos2 + barre_incr; 
	elsif (mvright2='0' and mvleft2='1' and pos2>HMIN ) -- 184 = 144 +40
			then	pos2<= pos2 - barre_incr; 
	else pos2<= pos2;
	end if;
end if;

end if;
end process ;


position <=  pos;
position2 <= pos2;


end k;

