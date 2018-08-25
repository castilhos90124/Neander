----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decod is
	port (
		op_code		:	in std_logic_vector(3 downto 0);
		inst		:	out std_logic_vector(12 downto 0)
		);
end decod;

architecture Behavioral of decod is

begin

	process(op_code)
	
	begin
	
	inst <= (others => '0');
	
	case op_code is
		when "0000" => inst(0)	<= '1';     -- nop			= x0
		when "0001" => inst(1)	<= '1';     -- sta			= x1
		when "0010" => inst(2)	<= '1';     -- lda			= x2
		when "0011" => inst(3)	<= '1';     -- add			= x3
		when "0100" => inst(4)	<= '1';     -- or_inst		= x4
		when "0101" => inst(5)	<= '1';     -- and_inst		= x5
		when "0110" => inst(6)	<= '1';     -- not_inst		= x6
		when "0111" => inst(7)	<= '1';     -- jn				= x8
		when "1000" => inst(8)	<= '1';     -- sub			= x7
		when "1001" => inst(9)	<= '1';     -- jz				= x9
		when "1010" => inst(10) <= '1';    	-- jmp			= xA
		when "1011" => inst(11) <= '1';    	-- shift_r		= xB
		when others => inst(12) <= '1';    	-- hlt			= xF && xE && xD && xC
	end case;

	end process;

end Behavioral;