library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FGen is
	port(
		ACC_out		: in	unsigned(31 downto 0);
		enable		: in	std_logic;
		
		fADC			: out	std_logic;
		fDataFlow	: out	std_logic
	);
end FGen;

architecture Behavioral of FGen is

	

begin
	
	fADC <= ACC_out(31) and enable;
	fDataFlow <= ACC_out(30) and enable;

end Behavioral;
