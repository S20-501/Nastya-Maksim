library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WB is
	port
	(
		-- Wishbone сигналы
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
		
		-- Получаемые сигналы
		clear		: out std_logic;
		enable	: out std_logic;
		ADC_FTW	: out unsigned(31 downto 0)
	);
end WB;

architecture Behavioral of WB is

begin

	

end Behavioral;










