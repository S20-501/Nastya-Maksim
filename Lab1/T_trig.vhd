library ieee;
use ieee.std_logic_1164.all;

entity T_trig is
	port
	(
		T_in	: in  std_logic;
		clock	: in	std_logic;
		reset	: in  std_logic;
		Q_out	: out std_logic;
		nQ_out: out	std_logic
	);
end T_trig;

architecture rtl of T_trig is
	signal inner_value	:	std_logic;
begin
	Q_out <= inner_value;
	nQ_out<= not inner_value;
	
	process (T_in, clock, reset)
   begin
		if (reset = '1') then
			inner_value	<= '0';
		elsif(rising_edge(clock)) then
			inner_value	<= inner_value xor T_in;
		end if;
	end process;

end rtl;
