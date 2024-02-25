--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:39:23 02/13/2024
-- Design Name:   
-- Module Name:   C:/Workspace/OSCYLOSKOP/adc_tb.vhd
-- Project Name:  OSCYLOSKOP
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adc
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
 
ENTITY adc_tb IS
END adc_tb;
 
ARCHITECTURE behavior OF adc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adc
    PORT(
         CLK : IN  std_logic;
         ADC_CS : OUT  std_logic;
         ADC_SCLK : OUT  std_logic;
         ADC_D0 : IN  std_logic;
         DATA_OUT : OUT  std_logic_vector(7 downto 0);
         ADDR : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal ADC_D0 : std_logic := '0';

 	--Outputs
   signal ADC_CS : std_logic;
   signal ADC_SCLK : std_logic;
   signal DATA_OUT : std_logic_vector(7 downto 0);
   signal ADDR : std_logic_vector(8 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant ADC_SCLK_period : time := CLK_period*100;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adc PORT MAP (
          CLK => CLK,
          ADC_CS => ADC_CS,
          ADC_SCLK => ADC_SCLK,
          ADC_D0 => ADC_D0,
          DATA_OUT => DATA_OUT,
          ADDR => ADDR
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
      wait for 100 ns;	
		for i in 0 to 20 loop
			ADC_D0 <= '0';
			wait for ADC_SCLK_period;
			ADC_D0 <= '0';
			wait for ADC_SCLK_period;
			ADC_D0 <= '1';
			wait for ADC_SCLK_period;
			ADC_D0 <= '1';
			wait for ADC_SCLK_period;
			ADC_D0 <= '1';
			wait for ADC_SCLK_period;
			ADC_D0 <= '0';
			wait for ADC_SCLK_period;
		end loop;
      

      

      wait for 1000 us;
   end process;

END;
