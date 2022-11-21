library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DDS is
	port
	(
		-- Входные сигналы
		clk	: in std_logic;
		nRst	: in std_logic;
		
		-- Сигналы WISHBONE
		
		
		-- Выходные сигналы
		DataFlow_Clk	: out std_logic;
		ADC_Clk			: out std_logic
	);
end DDS;

architecture Behavioral of DDS is

	component ACC is
		port(
			clk		: in	std_logic;
			nRst		: in	std_logic;
			FTW		: in	unsigned(31 downto 0);
			ACC_in	: in	unsigned(31 downto 0);
			
			ACC_out	: out	unsigned(31 downto 0)
		);
	end component;
	
	component FGen is
		port(
			ACC_out		: in	unsigned(31 downto 0);
			
			fADC			: out	std_logic;
			fDataFlow	: out	std_logic
		);
	end component;
	
	signal ADC_FTW	: unsigned(31 downto 0);
	signal ACC_reg	: unsigned(31 downto 0);

begin

	ADC_FTW <= (28 => '1', others => '0');

	ACC_0:ACC port map(
		clk		=> clk,
		nRst		=> nRst,
		FTW		=> ADC_FTW,
		ACC_in	=> ACC_reg,
		
		ACC_out	=> ACC_reg
	);
	
	FGen_0:FGen port map(
		ACC_out		=> ACC_reg,
			
		fADC			=> ADC_Clk,
		fDataFlow	=> DataFlow_Clk
	);

end Behavioral;










