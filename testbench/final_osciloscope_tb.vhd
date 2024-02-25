--------------------------------------------------------------------------------
-- Project Name:  OSCYLOSKOP
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY final_osciloscope_tb IS
END final_osciloscope_tb;
 
ARCHITECTURE behavior OF final_osciloscope_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT final_osciloscope
    PORT(
         CLK : IN  std_logic;
         HSYNC : OUT  std_logic;
         VSYNC : OUT  std_logic;
         RGB : OUT  std_logic_vector(2 downto 0);
         ADC_CS : OUT  std_logic;
         ADC_SCLK : OUT  std_logic;
         ADC_D0 : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal ADC_D0 : std_logic := '0';

 	--Outputs
   signal HSYNC : std_logic;
   signal VSYNC : std_logic;
   signal RGB : std_logic_vector(2 downto 0);
   signal ADC_CS : std_logic;
   signal ADC_SCLK : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant ADC_SCLK_period : time := CLK_period*100;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: final_osciloscope PORT MAP (
          CLK => CLK,
          HSYNC => HSYNC,
          VSYNC => VSYNC,
          RGB => RGB,
          ADC_CS => ADC_CS,
          ADC_SCLK => ADC_SCLK,
          ADC_D0 => ADC_D0
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
      for i in 0 to 60 loop
		
			ADC_D0 <= '1';
			wait for 10*ADC_SCLK_period;
		
		end loop;

      -- insert stimulus here 

      wait;
   end process;

END;
