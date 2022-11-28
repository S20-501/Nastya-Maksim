library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WB is
	port
	(
		-- Wishbone сигналы
		WB_Addr		: in	std_logic_vector(15 downto 0);
--		WB_DataOut	: out	std_logic_vector(15 downto 0);
		WB_DataIn	: in	std_logic_vector(15 downto 0);
		WB_WE			: in	std_logic;
		WB_Sel		: in	std_logic_vector(1 downto 0);
		WB_STB		: in	std_logic;
		WB_Cyc		: in	std_logic;
		WB_Rst		: in	std_logic;
		WB_Ack		: out	std_logic;
		WB_CTI		: in	std_logic_vector(2 downto 0);
		
		-- Получаемые сигналы
		clear		: out std_logic;
		enable	: out std_logic;
		ADC_FTW	: out unsigned(31 downto 0)
	);
end WB;

architecture Behavioral of WB is

	signal inner_ADC_FTW	: unsigned(31 downto 0);
	signal inner_clear	: std_logic;
	signal inner_enable	: std_logic;

begin
		
		process(WB_Cyc)
		begin
			if (rising_edge(WB_Cyc)) then
				if (WB_Rst '0') then'
					clear <= '0';
					enable <= '0';
					ADC_FTW <= (others => '0')
				elseif ((WB_STB = '1') and (WB_Ack = '1')) then
					if (WB_Addr = '
				
				
				
			end if;
			
			
			
		end process;	
	

end Behavioral;










