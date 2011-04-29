--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:06:05 04/09/2010
-- Design Name:   
-- Module Name:   C:/Users/Ali/Desktop/prsq/sim.vhd
-- Project Name:  prsq
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: prsq
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY sim IS
END sim;
 
ARCHITECTURE behavior OF sim IS 


   --Inputs
   signal clk_50mhz : std_logic := '0';
   signal reset : std_logic := '1';
   signal padone : std_logic := '0';
   signal padtwo : std_logic := '0';
   signal padone2 : std_logic := '0';
   signal padtwo2 : std_logic := '0';
   signal padon : std_logic := '0';
   signal robot : std_logic := '0';
   signal ps2c : std_logic := '0';
   signal ps2d : std_logic := '0';

 	--Outputs
--   signal speaker : std_logic;
   signal clk_100hz_out : std_logic;
   signal clk_1s_out : std_logic;
   signal clk_out : std_logic;

--   signal clk_out : std_logic;
--   signal frame_out : std_logic;
--   signal video_out : std_logic;
--   signal h_sync_out : std_logic;
--   signal v_sync_out : std_logic;
--   signal r_out : std_logic_vector(2 downto 0);
--   signal g_out : std_logic_vector(2 downto 0);
--   signal b_out : std_logic_vector(2 downto 0);
--   signal hc_out : std_logic_vector(10 downto 0);
--   signal vc_out : std_logic_vector(10 downto 0);
--   signal position_out : std_logic_vector(10 downto 0);
--   signal ball_x_out : std_logic_vector(10 downto 0);
--   signal ball_y_out : std_logic_vector(10 downto 0);

   -- Clock period definitions
--   constant clk_50mhz_period : time := 1us;
--   constant clk_out_period : time := 1us;
-- 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.prsq PORT MAP (
          clk_50mhz => clk_50mhz,
			 clk_out => clk_out,
			 clk_1s_out => clk_1s_out,
			 clk_100hz_out => clk_100hz_out,
          reset => reset,
          padone => padone,
          padtwo => padtwo,
          padtwo2 => padtwo2,
          padone2 => padone2,
          padon => padon,
          robot => robot,          
			 ps2c => ps2c,
          ps2d => ps2d
--          frame_out => frame_out,
--				clk_out => clk_out,
				
				
--          video_out => video_out,
--          h_sync_out => h_sync_out,
--          v_sync_out => v_sync_out,
--          r_out => r_out,
--          g_out => g_out,
--          b_out => b_out,
--          hc_out => hc_out,
--          vc_out => vc_out,
--          position_out => position_out,
--			 ball_x_out => ball_x_out,
--			 ball_y_out => ball_y_out
        );

clk_50mhz <= not clk_50mhz after 20ns;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
		--reset <= '1';

    wait for 100us;	
		reset <= '0';
      -- insert stimulus here 
--
-- wait for 16ms;	
--		inone <= '1';
-- wait for 2ms;	
--		inone <= '0'; 
 
		
      wait;
   end process;

END;
