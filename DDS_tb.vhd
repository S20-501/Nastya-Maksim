library ieee;
use ieee.std_logic_1164.all;

entity DDS_tb is
end DDS_tb;

architecture sim of DDS_tb is

	constant clock_period	:	time	:= 10 ps;
	
	signal clk		: std_logic := '1';
	signal nRst		: std_logic := '0';
	
	-- out signals
	signal DataFlow_Clk : std_logic;
	signal ADC_Clk	: std_logic;

	signal WB_Addr			: std_logic_vector(15 downto 0);
	signal WB_DataOut		: std_logic_vector(15 downto 0);
	signal WB_DataIn		: std_logic_vector(15 downto 0);
	signal WB_WE			: std_logic;
	signal WB_Sel			: std_logic_vector(1 downto 0);
	signal WB_STB			: std_logic;
	signal WB_Cyc			: std_logic;
	signal WB_Ack			: std_logic;
	signal WB_CTI			: std_logic_vector(2 downto 0);

begin

	DDS_0:entity work.DDS(Behavioral) port map
	(
		-- Входные сигналы
		clk		=> clk,
		nRst		=> nRst,
		
		-- Сигналы WISHBONE
		WB_Addr		=> WB_Addr,
		WB_DataOut	=> WB_DataOut,
		WB_DataIn	=> WB_DataIn,
		WB_WE			=> WB_WE,
		WB_Sel		=> WB_Sel,
		WB_STB		=> WB_STB,
		WB_Cyc		=> WB_Cyc,
		WB_Ack		=> WB_Ack,
		WB_CTI		=> WB_CTI,
		
		
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