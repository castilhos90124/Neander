----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
	port (
		N, Z		:	in std_logic;
		inst		:	in std_logic_vector(12 downto 0);
		
		--control signals for the memory
		write_mem	:	out std_logic;
		
		--control signals for the other components
		sel_ULA		:	out std_logic;
		ld_pc 		:	out std_logic;
		inc_pc 		:	out std_logic;
		ld_ac 		:	out std_logic;
		sel_mux		:	out std_logic
		
		);
end control_unit;

architecture Behavioral of control_unit is

begin

--	process(input, sel)
	
--	begin

--end process;

end Behavioral;