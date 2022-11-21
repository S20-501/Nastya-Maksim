library ieee;
use ieee.std_logic_1164.all;

entity counter_reverse4d is
	port
	(
		clock		: in	std_logic;
		summing	: in	std_logic;
		reset		: in	std_logic;
		Q_out		: out	std_logic_vector(3 downto 0);
		overflow	: out	std_logic
	);
end counter_reverse4d;

architecture rtl of counter_reverse4d is

	component T_trig is
		port
		(
			T_in		: in  std_logic;
			reset		: in  std_logic;
			clock		: in	std_logic;
			Q_out		: out std_logic;
			nQ_out	: out std_logic
		);
	end component;
	
	signal T_trigs_out		:	std_logic_vector(3 downto 0);
	signal not_T_trigs_out	:	std_logic_vector(3 downto 0);
	signal T_trigs_in			:	std_logic_vector(3 downto 0);
	
	signal enable_inc		:	std_logic; -- Enable incrementing
	signal enable_dec		:	std_logic; -- Enable decrementing
	
	
	
	signal increment	:	std_logic;
	signal decrement	:	std_logic;

begin

	increment <= clock and summing;
	decrement <= clock and not summing;
	
	Q_out <= T_trigs_out;
	
	overflow <= not enable_inc or not enable_dec;
	
	triggers_logic_input(0) <= (enable_inc) or (enable_dec);
	triggers_logic_input(1) <= (T_trigs_out(0) and enable_inc) or (not_T_trigs_out(0) and enable_dec);
	triggers_logic_input(2) <= (T_trigs_out(0) and T_trigs_out(1) and enable_inc) or (not_T_trigs_out(0) and not_T_trigs_out(1) and enable_dec);
	triggers_logic_input(3) <= (T_trigs_out(0) and T_trigs_out(1) and T_trigs_out(2) and enable_inc) or (not_T_trigs_out(0) and not_T_trigs_out(1) and not_T_trigs_out(2) and enable_dec);
	
	enable_inc <= not (T_trigs_out(0) and T_trigs_out(1) and T_trigs_out(2) and T_trigs_out(3) and summing);
	enable_dec <= not (not_T_trigs_out(0) and not_T_trigs_out(1) and not_T_trigs_out(2) and not_T_trigs_out(3) and not summing);
	
	T_trig_0:T_trig port map
	(
		reset	=> reset,
		clock => clock,
		T_in	=> T_trigs_in(0),
		Q_out	=> T_trigs_out(0),
		nQ_out=> not_T_trigs_out(0)
	);
	
	T_trig_1:T_trig port map
	(
		reset	=> reset,
		clock => clock,
		T_in	=> T_trigs_in(1),
		Q_out	=> T_trigs_out(1),
		nQ_out=> not_T_trigs_out(1)
	);
	
	T_trig_2:T_trig port map
	(
		reset	=> reset,
		clock => clock,
		T_in	=> T_trigs_in(2),
		Q_out	=> T_trigs_out(2),
		nQ_out=> not_T_trigs_out(2)
	);
	
	T_trig_3:T_trig port map
	(
		reset	=> reset,
		clock => clock,
		T_in	=> T_trigs_in(3),
		Q_out	=> T_trigs_out(3),
		nQ_out=> not_T_trigs_out(3)
	);

end rtl;