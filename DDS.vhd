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
		WB_Addr		: in	std_logic_vector(15 downto 0);
		WB_DataOut	: out	std_logic_vector(15 downto 0);
		WB_DataIn_0	: in	std_logic_vector(15 downto 0);
		WB_DataIn_1	: in	std_logic_vector(15 downto 0);
		WB_DataIn_2	: in	std_logic_vector(15 downto 0);
		WB_DataIn_3	: in	std_logic_vector(15 downto 0);
		WB_WE			: in	std_logic;
		WB_Sel		: in	std_logic_vector(1 downto 0);
		WB_STB		: in	std_logic;
		WB_Cyc_0		: in	std_logic;
		WB_Cyc_1		: in	std_logic;
		WB_Cyc_2		: in	std_logic;
		WB_Cyc_3		: in	std_logic;
		WB_Ack		: out	std_logic;
		WB_CTI		: in	std_logic_vector(2 downto 0);
		
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
			enable		: in	std_logic;
			
			fADC			: out	std_logic;
			fDataFlow	: out	std_logic
		);
	end component;
	
	component WB is
		port(
			WB_Addr		: in	std_logic_vector(15 downto 0);
			WB_DataOut	: out	std_logic_vector(15 downto 0);
			WB_DataIn_0	: in	std_logic_vector(15 downto 0);
			WB_DataIn_1	: in	std_logic_vector(15 downto 0);
			WB_DataIn_2	: in	std_logic_vector(15 downto 0);
			WB_DataIn_3	: in	std_logic_vector(15 downto 0);
			WB_WE			: in	std_logic;
			WB_Sel		: in	std_logic_vector(1 downto 0);
			WB_STB		: in	std_logic;
			WB_Cyc_0		: in	std_logic;
			WB_Cyc_1		: in	std_logic;
			WB_Cyc_2		: in	std_logic;
			WB_Cyc_3		: in	std_logic;
			WB_Ack		: out	std_logic;
			WB_CTI		: in	std_logic_vector(2 downto 0);
			
			clear		: out std_logic;
			enable	: out std_logic;
			ADC_FTW	: out unsigned(31 downto 0)
		);
	end component;
	
	-- Register signals from wishbone
	signal ADC_FTW	: unsigned(31 downto 0);
	signal clear	: std_logic;
	signal enable	: std_logic;
	
	signal ACC_reg	: unsigned(31 downto 0);

begin

	WB_0:WB port map(
		-- Сигналы WISHBONE
		WB_Addr		=> WB_Addr,
		WB_DataOut	=> WB_DataOut,
		WB_DataIn_0	=> WB_DataIn_0,
		WB_DataIn_1	=> WB_DataIn_1,
		WB_DataIn_2	=> WB_DataIn_2,
		WB_DataIn_3	=> WB_DataIn_3,
		WB_WE			=> WB_WE,
		WB_Sel		=> WB_Sel,
		WB_STB		=> WB_STB,
		WB_Cyc_0		=> WB_Cyc_0,
		WB_Cyc_1		=> WB_Cyc_1,
		WB_Cyc_2		=> WB_Cyc_2,
		WB_Cyc_3		=> WB_Cyc_3,
		WB_Ack		=> WB_Ack,
		WB_CTI		=> WB_CTI,
		
		-- Получаемые сигналы
		ADC_FTW	=> ADC_FTW,
		clear		=> clear,
		enable	=> enable
	);

	ACC_0:ACC port map(
		clk		=> clk,
		nRst		=> nRst,
		FTW		=> ADC_FTW,
		ACC_in	=> ACC_reg,
		
		ACC_out	=> ACC_reg
	);
	
	FGen_0:FGen port map(
		ACC_out		=> ACC_reg,
		enable		=> enable,
			
		fADC			=> ADC_Clk,
		fDataFlow	=> DataFlow_Clk
	);

end Behavioral;










