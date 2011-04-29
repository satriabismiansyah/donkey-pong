----------------------------------------------------------------------------------
-- Company: A3a
-- Engineer: Ali Alaoui
-- 
-- Create Date:    16:09:19 04/03/2010 
-- Design Name: 	 prototype 0.1
-- Module Name:    signalsync - Behavioral 
-- Project Name:   Squash
-- Target Devices: Spartan3E
-- Tool versions: 
-- Description:  Génère les signaux de synchornisation verticale et horizontale

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

entity signalsync is
    Port ( clk,reset : in  STD_LOGIC;
			  video_on,frame : out STD_LOGIC;	
           h_sync,v_sync : out STD_LOGIC;
			  hc_out,vc_out : out std_logic_vector(10 downto 0));
end signalsync;

architecture k of signalsync is
--PARAMETRE DE SYNCHRONISATION
constant HD: integer:= 640; -- horizontal display area
constant HL: integer:= 799; -- horizontal limit 
constant HF: integer:= 16; -- h. front porch
constant HB: integer:= 48;	-- h. back porch
constant HP: integer:= 96;	-- h. pulse width
constant VD: integer:= 480; -- vertical display area
constant VL: integer:= 520; -- vertical limit 
constant VF: integer:= 10;	-- v. front porch
constant VB: integer:= 29;	-- v. back porch
constant VP: integer:= 2;	-- v. pulse width

-- 
signal h_count,v_count,v_count_in,h_count_in : std_logic_vector(10 downto 0);
signal video_h_on,video_v_on : std_logic;
begin

--COMPTEUR HORIZONTALE
h_count <= (others=>'0') when reset='1' else h_count_in when rising_edge(clk);
h_count_in <= unsigned(h_count)+1 when unsigned(h_count)<HL else(others=>'0');

--COMPTEUR VERTICALE
v_count <= (others => '0') when reset='1' else v_count_in when rising_edge(clk);
v_count_in <= v_count when unsigned(h_count)<HL else (unsigned(v_count)+1) when unsigned(v_count)<VL else (others => '0');

frame <= '1' when unsigned(v_count) = VL and unsigned(h_count) = 0  else '0';

--SIGNAUX DE SYNCHRONISATION
h_sync <= '0' when unsigned(h_count)<HP else '1';
v_sync <= '0' when unsigned(v_count)<VP else '1';

--ACIVATION DE L'AFFICHAGE
video_on <=  video_h_on AND video_v_on;
video_h_on <= '1' when unsigned(h_count) >= HP+HB and unsigned(h_count) <= HP+HB+HD  else '0';
video_v_on <= '1' when unsigned(v_count) >= VP+VB and unsigned(v_count) <= VP+VB+VD  else '0';

---debbug
hc_out <= h_count;
vc_out <= v_count;

end k;

