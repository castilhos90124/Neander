library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Reg is 
	port (
		clk, load : in std_logic; 
		load_in : in std_logic_vector(7 downto 0);
		reg_out : out std_logic_vector(7 downto 0)
	);
end Reg;

architecture Behavioral of Reg is

signal reg : std_logic_vector(7 downto 0);

begin

process(clk, load)
begin

	if RISING_EDGE(clk) then
		if load = '1' then
			reg <= load_in;
		else
			reg <= reg;
		end if;
	end if;

end process;

reg_out <=  reg;

end Behavioral;