library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ACC is
	port
	(
		clk		: in	std_logic;
		nRst		: in	std_logic;
		enable	: in 	std_logic;
		FTW		: in	unsigned(31 downto 0);
		ACC_in	: in	unsigned(31 downto 0);
		
		ACC_out	: out	unsigned(31 downto 0)
	);
end ACC;

architecture Behavioral of ACC is

begin

	process(clk, nRst, ACC_in, FTW, enable) 
	begin
		if(nRst = '0') then
			ACC_out <= (others => '0');
		elsif(rising_edge(clk) and not enable) then
			ACC_out <= ACC_in + FTW;
		end if;
	end process;

end Behavioral;