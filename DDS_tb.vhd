library ieee;
use ieee.std_logic_1164.all;

entity DDS_tb is
end DDS_tb;

architecture sim of DDS_tb is

	constant clock_period	:	time	:= 10 ps;
	
	signal clk	: std_logic := '1';
	signal nRst	: std_logic := '0';
	
	-- out signals
	signal DataFlow_Clk : std_logic;
	signal ADC_Clk	: std_logic;

begin

	DDS_0:entity work.DDS(Behavioral) port map
	(
		-- Входные сигналы
		clk		=> clk,
		nRst		=> nRst,
		
		-- Сигналы WISHBONE
		
		
		-- Выходные сигналы
		DataFlow_Clk	=>	DataFlow_Clk,
		ADC_Clk			=>	ADC_Clk
	);

	clk <= not clk after clock_period / 2;
	
	process is
	begin
		nRst <= '0';
		wait for 20 ps;
		nRst <= '1';
		
		wait for 10 ns;
		
		wait;
	end process;
end sim;