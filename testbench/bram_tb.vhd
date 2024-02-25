--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:42:27 02/07/2024
-- Design Name:   
-- Module Name:   C:/Workspace/OSCYLOSKOP/bram_tb.vhd
-- Project Name:  OSCYLOSKOP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bram
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY bram_tb IS
END bram_tb;
 
ARCHITECTURE behavior OF bram_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bram
    PORT(
         CLK : IN  std_logic;
         ADDR : IN  std_logic_vector(19 downto 0);
         W_DATA : IN  std_logic;
         R_DATA : OUT  std_logic;
         W_EN : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal ADDR : std_logic_vector(19 downto 0) := (others => '0');
   signal W_DATA : std_logic := '0';
   signal W_EN : std_logic := '0';

 	--Outputs
   signal R_DATA : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
	constant ADC_SCLK_period : time := CLK_period*100;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bram PORT MAP (
          CLK => CLK,
          ADDR => ADDR,
          W_DATA => W_DATA,
          R_DATA => R_DATA,
          W_EN => W_EN
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		ADDR <= "00000000";
      W_DATA <= "10000000";
      wait for ADC_SCLK_period;
		
		ADDR <= "00000001";
      W_DATA <= "11000011";
      wait for ADC_SCLK_period;

      -- insert stimulus here 

      wait;
   end process;

END;
