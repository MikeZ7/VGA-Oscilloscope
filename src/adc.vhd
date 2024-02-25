----------------------------------------------------------------------------------
-- Author: Micha³ Zelek
-- Create Date:   12:27:42 02/07/2024 
-- Module Name:	ADC PMOD AD1 driver
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;


entity adc is
    Port ( CLK : in  STD_LOGIC;
           ADC_CS : out  STD_LOGIC;
           ADC_SCLK : out  STD_LOGIC;
           ADC_D0 : in  STD_LOGIC;
           DATA_OUT  : out  STD_LOGIC_VECTOR (7 downto 0);
			  ADDR : out STD_LOGIC_VECTOR (8 downto 0)
			  );
end adc;

architecture Behavioral of adc is

    signal cs : STD_LOGIC := '1'; -- ~chip select
    signal adc_clk : STD_LOGIC := '0'; --adc clk 1MHz
	 
	 --data buffer 4 start bits and 12 data bits
    signal adc_reading_buffer  : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
	 
	 -- auxiliary variables
	signal mod50 : integer range 0 to 49 := 0; 
	signal cs_counter : integer range 0 to 20 := 0;
	signal addr_counter : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');

begin

    ADC_SCLK <= adc_clk;
	 ADC_CS <= cs;
	 ADDR <= addr_counter;
	 
    sr_clock_divide : process(CLK)
        begin
             if (CLK'event and CLK = '1') then
                if(mod50 = 49) then
						  adc_clk <= not adc_clk;
                    mod50 <= 0;
                else
                    mod50 <= mod50 + 1;
                end if; 
            end if;
	  end process sr_clock_divide;
		  
		  
	 cs_toggle : process(adc_clk)
		 begin
			if (adc_clk'event and adc_clk = '1') then
				if(cs_counter = 19) then
					cs_counter <= 0;
				elsif(cs_counter > 15) then
					cs <= '1';
					cs_counter <= cs_counter + 1;
				else
					cs <= '0';
					cs_counter <= cs_counter + 1;
				end if;	
			end if;
	 end process cs_toggle;

        
    main : process (adc_clk, cs_counter)
        begin
				if (adc_clk'event and adc_clk = '1') then
					if(cs_counter = 0) then
							adc_reading_buffer <= (others=>'0');
					elsif(cs_counter < 16) then
							adc_reading_buffer <= adc_reading_buffer(adc_reading_buffer'high-1 downto 0) & ADC_D0;
					elsif(cs_counter = 16) then
						DATA_OUT <= adc_reading_buffer(11 downto 4);
					elsif(cs_counter = 19) then
							if(to_integer(unsigned(addr_counter)) = 479) then
								addr_counter <= (others => '0');
							else
								addr_counter <= addr_counter + 1;
							end if;			
					else
							adc_reading_buffer <= adc_reading_buffer;
					end if;
				end if;	
	  end process main;
		  
end Behavioral;