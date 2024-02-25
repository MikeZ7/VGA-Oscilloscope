library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;


entity bram is
    Port ( CLK : in  STD_LOGIC;
           ADDR : in  STD_LOGIC_VECTOR (8 downto 0);
			  W_EN : in STD_LOGIC;
           W_DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           R_DATA : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end bram;

architecture Behavioral of bram is

	signal clk50 : STD_LOGIC := '0';
	signal clk25 : STD_LOGIC := '0';
	type RAM_ARRAY is array (0 to 8) of STD_LOGIC_VECTOR (7 downto 0);
	signal RAM : RAM_ARRAY := (others => (others => '0'));
	
begin

	clk_div:process(CLK)
	begin
		if(CLK'event and CLK = '1')then
			clk50 <= not clk50;
		end if;
	end process;

	clk_div2:process(clk50)
	begin
		if(clk50'event and clk50 = '1')then
			clk25 <= not clk25;
		end if;	
	end process;

	process(clk25, W_EN, ADDR)
	begin
		if(clk25'event and clk25 = '1')then
			if(W_EN = '1')then
				RAM(to_integer(unsigned(ADDR))) <= W_DATA;
			end if;
		end if;		
	end process;

	R_DATA <= RAM(to_integer((unsigned(ADDR))));

end Behavioral;

