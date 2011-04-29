----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:30:15 04/28/2010 
-- Design Name: 
-- Module Name:    ps2_rx - Behavioral 
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
library  ieee; 
use  ieee.std_logic_1164.all; 
use  ieee.numeric_std.all; 

entity  ps2_rx  is 
port  ( 
	clk, reset:  in  std_logic; 
	ps2d, ps2c:  in  std_logic;  -- key  data,  key  clock 
	frame:  in  std_logic;  
	dout:  out  std_logic_vector (7  downto  0);
	rx_done_tick : out std_logic
); 
end  ps2_rx; 
architecture  k  of  ps2_rx  is 

	signal  filter_reg  ,  filter_next  : std_logic_vector  (7 downto  0) ;
	signal  f_ps2c_reg,  f_ps2c_next :  std_logic  ; 
	signal  fall_edge  :  std_logic  ;  
	signal  b_reg1, b_reg2 :  std_logic_vector (10  downto  0)  ; 

begin 
----------------------------------------------------------
-- filter  and  falling  edge  tick  generation  for  ps2c 
----------------------------------------------------------
filter_next  <=  ps2c&filter_reg(7 downto 1); 
f_ps2c_next  <=  '1'  when  filter_reg="11111111"  else 
					  '0'  when  filter_reg="00000000"  else 
					  f_ps2c_reg; 
fall_edge  <=  f_ps2c_reg  and  (not  f_ps2c_next); 


process (fall_edge,ps2d,reset,clk) 
begin 

 if (reset = '1') then 
--filtre
filter_reg  <=  (others=>'0'); 
f_ps2c_reg  <=  '0'; 
  b_reg1 <= (others => '0'); 
  b_reg2 <= (others => '0'); 
 elsif rising_edge(clk) then
 --filtre
 filter_reg  <=  filter_next; 
 f_ps2c_reg  <=  f_ps2c_next; 
 
	 if fall_edge='1' then 
		  b_reg1 <= ps2d & b_reg1(10 downto 1); 
		  b_reg2 <= b_reg1(0) & b_reg2(10 downto 1); 
	 end if; 
	 
 end if;

end  process; 


--output
	with b_reg2(8  downto  0)&b_reg1(8  downto  0) select
       dout <= 				  "01110100" when "011001100011001100", 
                             "01101011" when "010110100010110100", 
                             "00010001" when "000100100000100100", 
                             "00010100" when "000101000000101000", 
                             "00101001" when "001010010001010010", 
                             "01011010" when "010110010010110010", 
                             "00000000" when others;
									  
 rx_done_tick <='1' when frame='1' else '0';


end  k; 







