library ieee;
use ieee.std_logic_1164.all;

entity T_trig is
	port
	(
		T_in	: in  std_logic;
		reset	: in  std_logic;
		Q_out	: out std_logic
	);
end T_trig;

architecture Behavioral of T_trig is
	signal inner_value	:	std_logic;
begin
	Q_out <= inner_value;
	
	process (T_in, reset)
   begin
		if (reset = '1') then
			inner_value	<= '0';
		elsif(rising_edge(T_in)) then
			inner_value	<= not inner_value;
		end if;
	end process;

end Behavioral;
