----------------------------------------------------------------------------------
-- Author: Micha³ Zelek
-- Create Date:   12:27:42 02/07/2024 
-- Project Name:	VGA Oscilloscope
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity final_osciloscope is

	Port(		CLK : in  STD_LOGIC;
			  --vga
           HSYNC : out  STD_LOGIC;
           VSYNC : out  STD_LOGIC;
           RGB : out  STD_LOGIC_VECTOR (2 downto 0);
			  --adc
			  ADC_CS : out  STD_LOGIC;
           ADC_SCLK : out  STD_LOGIC;
           ADC_D0 : in  STD_LOGIC
	);

end final_osciloscope;


architecture top_arch of final_osciloscope is

	component new_vga_driver is
		Port (  CLK : in  STD_LOGIC;
				  COLUMN_PIX : in STD_LOGIC_VECTOR (7 downto 0);
				  HSYNC : out  STD_LOGIC;
				  VSYNC : out  STD_LOGIC;
				  RGB : out  STD_LOGIC_VECTOR (2 downto 0)
				  );
	end component;

	component bram is
		 Port ( CLK : in  STD_LOGIC;
				  ADDR : in  STD_LOGIC_VECTOR (8 downto 0);
				  W_EN : in  STD_LOGIC;
				  W_DATA : in  STD_LOGIC_VECTOR (7 downto 0);
				  R_DATA : out  STD_LOGIC_VECTOR (7 downto 0)
				  );
	end component;

	component adc is
		 Port ( CLK : in  STD_LOGIC;
				  ADC_CS : out  STD_LOGIC;
				  ADC_SCLK : out  STD_LOGIC;
				  ADC_D0 : in  STD_LOGIC;
				  DATA_OUT  : out  STD_LOGIC_VECTOR (7 downto 0);
				  ADDR : out STD_LOGIC_VECTOR (8 downto 0)
				  );
	end component;

--components connection signals
signal data_output : STD_LOGIC_VECTOR (7 downto 0);
signal data_adc : STD_LOGIC_VECTOR (7 downto 0);
signal address : STD_LOGIC_VECTOR (8 downto 0);

begin

adc_1 : adc port map(CLK, ADC_CS, ADC_SCLK, ADC_D0, data_adc, address);
memory_1: bram port map(CLK, address, '1', data_adc, data_output);
vga1: new_vga_driver port map(CLK, data_output, HSYNC, VSYNC, RGB);

end top_arch;

