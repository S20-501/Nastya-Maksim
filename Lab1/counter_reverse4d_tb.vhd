library ieee;
use ieee.std_logic_1164.all;

entity counter_reverse4d_tb is
end counter_reverse4d_tb;

architecture sim of counter_reverse4d_tb is

	constant clock_period	:	time	:= 10 ms;
	
	signal clock	: std_logic := '1';
	signal summing	: std_logic := '1';
	signal reset	: std_logic := '1';
	signal Q_out	: std_logic_vector(3 downto 0);

begin

	counter:entity work.counter_reverse4d(rtl) port map
	(
		clock		=> clock,
		summing	=> summing,
		reset		=> reset,
		Q_out		=> Q_out
	);

	clock <= not clock after clock_period / 2;
	
	process is
	begin
		wait for 20 ms;
		reset <= '0';
		
		wait for 200 ms;
		summing <= '0';
		wait for 200 ms;
		
		reset <= '1';
		
		wait;
	end process;
end sim;