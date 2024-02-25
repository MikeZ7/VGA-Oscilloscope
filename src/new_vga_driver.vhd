library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;


entity new_vga_driver is
    Port ( CLK : in  STD_LOGIC;
			  COLUMN_PIX : in STD_LOGIC_VECTOR (7 downto 0);
           HSYNC : out  STD_LOGIC;
           VSYNC : out  STD_LOGIC;
           RGB : out  STD_LOGIC_VECTOR (2 downto 0)
			  );
end new_vga_driver;

architecture Behavioral of new_vga_driver is

	-- 800x600 60Hz clk = 25MHz
	--Horizontal sync
	constant HD : integer := 640;
	constant HFP : integer := 16;
	constant HSP : integer := 96;
	constant HBP : integer := 48;
	--Vertical sync
	constant VD : integer := 480;
	constant VFP : integer := 10;
	constant VSP : integer := 2;
	constant VBP : integer := 33;
	--counters
	signal hPos : integer := 0;
	signal vPos : integer := 0;
	--clk divide
	signal clk50 : STD_LOGIC := '0';
	signal clk25 : STD_LOGIC := '0';
	--draw flag : if = 0 => FrontPorch, BackPorch or SyncPulse => RGB => 0
	signal videoOn : STD_LOGIC := '0';
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

	Hpos_counter:process(clk25)
	begin
		if(clk25'event and clk25 = '1')then
			if(hPos = HD + HFP + HSP + HBP)then
				hPos <= 0;
			else
				hPos <= hPos + 1;
			end if;
		end if;
	end process;


	Vpos_counter:process(clk25, hPos)
	begin
		if(clk25'event and clk25 = '1')then
			if(hPos = HD + HFP + HSP + HBP)then
				if(vPos = VD + VFP + VSP + VBP)then
					vPos <= 0;
				else
					vPos <= vPos + 1;
				end if;
			end if;
		end if;
	end process;

	H_sync:process(clk25, hPos)
	begin
		if(clk25'event and clk25 = '1')then
			if(hPos <= (HD + HFP) or (hPos > HD + HFP + HSP))then
				HSYNC <= '1';
			else
				HSYNC <= '0';
			end if;
		end if;
	end process;

	V_sync:process(clk25, vPos)
	begin
		if(clk25'event and clk25 = '1')then
			if(VPos <= (VD + VFP) or (vPos > VD + VFP + VSP))then
				VSYNC <= '1';
			else
				VSYNC <= '0';
			end if;
		end if;
	end process;

	video_on:process(clk25, hPos, vPos)
	begin
		if(clk25'event and clk25 = '1')then
			if(hPos <= HD and vPos <= VD)then
				videoOn <= '1';
			else
				videoOn   <= '0';
			end if;
		end if;
	end process;

	draw:process(clk25, hPos, vPos, videoOn, COLUMN_PIX)
	begin
		if(clk25'event and clk25 = '1')then
			if(videoOn = '1')then
				if(hPos = to_integer(unsigned(COLUMN_PIX) + 100))then
					RGB <= (others => '1');
				else
					RGB <= (others => '0');
				end if;
			else
				RGB <= (others => '0');
			end if;
		end if;
	end process;
	
end Behavioral;

