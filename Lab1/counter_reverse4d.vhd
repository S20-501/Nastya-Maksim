library ieee;
use ieee.std_logic_1164.all;

entity counter_reverse4d is
	port
	(
		clock		: in	std_logic;
		summing	: in	std_logic;
		reset		: in	std_logic;
		Q_out		: out	std_logic_vector(3 downto 0)
	);
end counter_reverse4d;

architecture rtl of counter_reverse4d is

	component T_trig is
		port
		(
			T_in		: in  std_logic;
			reset		: in  std_logic;
			Q_out		: out std_logic
		);
	end component;
	
	signal T_trigs_out	:	std_logic_vector(3 downto 0);
	signal T_trigs_in		:	std_logic_vector(3 downto 0);
	
	signal ands_plus		:	std_logic_vector(3 downto 0);
	signal ands_minus		:	std_logic_vector(3 downto 0);
	
	signal enable_inc		:	std_logic; -- Enable incrementing
	signal enable_dec		:	std_logic; -- Enable decrementing
	
	signal increment	:	std_logic;
	signal decrement	:	std_logic;

begin

	increment <= clock and summing;
	decrement <= clock and not summing;
	
	Q_out <= T_trigs_out;
	
	T_trigs_in(0) <= ands_plus(0) or ands_minus(0);
	T_trigs_in(1) <= ands_plus(1) or ands_minus(1);
	T_trigs_in(2) <= ands_plus(2) or ands_minus(2);
	T_trigs_in(3) <= ands_plus(3) or ands_minus(3);
	
	enable_inc <= not (T_trigs_out(0) and T_trigs_out(1) and T_trigs_out(2) and T_trigs_out(3) and summing);
	enable_dec <= not (not T_trigs_out(0) and not T_trigs_out(1) and not T_trigs_out(2) and not T_trigs_out(3) and not summing);
	
	T_trig_0:T_trig port map
	(
		reset	=> reset,
		T_in	=> T_trigs_in(0),
		Q_out	=> T_trigs_out(0)     
	);
	
	T_trig_1:T_trig port map
	(
		reset	=> reset,
		T_in	=> T_trigs_in(1),
		Q_out	=> T_trigs_out(1)      
	);
	
	T_trig_2:T_trig port map
	(
		reset	=> reset,
		T_in	=> T_trigs_in(2),
		Q_out	=> T_trigs_out(2)
	);
	
	T_trig_3:T_trig port map
	(
		reset	=> reset,
		T_in	=> T_trigs_in(3),
		Q_out	=> T_trigs_out(3)      
	);
	
	process(increment)
	begin
		if(enable_inc = '1') then		
			ands_plus(0) <= increment;
			ands_plus(1) <= T_trigs_out(0) and increment;
			ands_plus(2) <= T_trigs_out(0) and T_trigs_out(1) and increment;
			ands_plus(3) <= T_trigs_out(0) and T_trigs_out(1) and T_trigs_out(2) and increment;
		end if;
	end process;
	
	process(decrement)
	begin
		if(enable_dec = '1') then
			ands_minus(0) <= decrement;
			ands_minus(1) <= not T_trigs_out(0) and decrement;
			ands_minus(2) <= not T_trigs_out(0) and not T_trigs_out(1) and decrement;
			ands_minus(3) <= not T_trigs_out(0) and not T_trigs_out(1) and not T_trigs_out(2) and decrement;
		end if;
	end process;

end rtl;