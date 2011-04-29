----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:35 04/05/2010 
-- Design Name: 
-- Module Name:    clkgen - Behavioral 
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


entity clkgen is
 generic(    N   : natural := 250000;
				 A   : natural := 50000
--				 M   : natural := 25000000
			); 
    Port ( input : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           output : out  STD_LOGIC;
           clk_1khz : out  STD_LOGIC;
           clk_100hz : out  STD_LOGIC
--           clk_1s : out  STD_LOGIC
			  );
end clkgen;

architecture k of clkgen is

signal clk_s : std_logic;

begin

process(input,reset)
	begin
	if (reset = '1') then
	clk_s <= '0';
	elsif rising_edge(input) then
	clk_s <= not (clk_s);
	end if;
end process;

process(input,reset)
      variable counter : natural range 0 to A-1;
		variable counter2 : natural range 0 to N-1;
--		variable counter3 : natural range 0 to M-1;
  begin
   if reset='1' then 			 
     counter := 0;
     clk_1khz <= '0';
	  counter2 := 0;
     clk_100hz <= '0';
--     counter3 := 0;
--     clk_1s <= '0';
	  
	elsif rising_edge(input) then 
		if counter = A-1 then  counter := 0;
		else
		  if counter < (A/2)-1 then  counter := counter+1; clk_1khz <= '1';	
		  else  counter := counter+1; clk_1khz <= '0';  
		  end if;  
	  end if;
	  
	  if counter2 = N-1 then  counter2 := 0;
		else
		  if counter2 < (N/2)-1 then  counter2 := counter2+1;	 clk_100hz <= '1';	
		  else  counter2 := counter2+1;	 clk_100hz <= '0';
		  end if;
	  end if;
--	  
--	  if counter3 = M-1 then  counter3 := 0;
--		else
--		  if counter3 < (M/2)-1 then counter3 := counter3+1; clk_1s <= '1';	
--		  else  counter3 := counter3+1; clk_1s <= '0';
--		  end if;
--	  end if;
	  
   end if;
end process;


output <= clk_s;

end k;

