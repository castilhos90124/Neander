----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_2x1 is
	port (
		A, B :	in std_logic_vector(7 downto 0);
		sel : in std_logic;
		S :	out std_logic_vector(7 downto 0)
		);
end mux_2x1;

architecture Behavioral of mux_2x1 is

begin

process(A,B,sel)
begin

case sel is
	when '1' => S <= A;
	when others => S <= B;
end case;

end process;

end Behavioral;