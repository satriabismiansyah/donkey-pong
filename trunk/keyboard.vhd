library  ieee; 
use  ieee.  std_logic_1164.  all ; 
use  ieee.  numeric_std.  all ; 
entity  kb_code  is 
generic (W_SIZE : integer :=2)  ;  -- 2 A  W-SIZE  words  in  FIFO 
port  ( 
	clk,  reset:  in  std_logic; 
	ps2d, ps2c:  in  std_logic; 
	rd_key_code  :  in  std_logic  ; 
	kb_buf_empty:  out  std_logic 
	key_code  :  out  std_logic_vector(7 downto 0); 
); 
end  kb_code; 


architecture  k  of  kb_code  is 
	constant  BRK:  std_logic_vector (7  downto  0)  :="11110000"; 
	-- FO  (break  code) 
	type  statetype  is  (wait_brk, get_code); 
	signal  state_reg ,  state_next  :  statetype; 
	signal  scan_done_tick  ,  got_code_tick: std_logic; 
	signal  scan_out , w_data:  std_logic_vector (7 downto  0); 
begin 




ps2_rx_unit  :  entity  work. ps2_rx  (k) 
port  map(clk=>clk,  reset=>reset  ,  rx_en=>’l’, 
ps2d=>ps2d,  ps2c=>ps2c, 
rx_done_tick=>scan_done_tick, 
dout=>scan_out) ; 


process  (clk  ,  reset) 
begin 
if  reset=’l’ then 
elsif  (clk’event  and  clk=’l’)  then 
state_reg  <=  wait_brk; 
state_reg  <=  state_next; 
end  if ; 
end  process; 
process (state_reg ,  scan_done_tick  , 
begin 
got_code_tick  <=’O’; 
state_next  <=  state_reg; 
	case  state_reg  is 
	when  wait_brk  =>  if  scan_done_tick=’l’  and 
				state_next  <=  get_code 
	end  if  ; 
	when  get_code  =>  -- get the 
	scan_out) 
	FO  of  break  code 
	scan_out=BRK  then 
	ollowing  scan  code 
	if  scan_done_tick=’l’  then 
	got_code_tick  <=  1  ’  ; 
	state_next  <=  wait_brk; 
	end  if ; 
	end  case; 
end  process; 
end  k; 