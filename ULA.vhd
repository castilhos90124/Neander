library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ula is
	port (
		x,y	: in std_logic_vector(7 downto 0);
		sel_ULA	: in std_logic_vector(2 downto 0);
		N,Z: out std_logic;
		ula_out	: inout std_logic_vector(7 downto 0) --made inout
		);
end ula;

architecture Behavioral of ula is

begin

process(x, y, sel_ULA)
begin 

case sel_ULA is 
	when "000" => ula_out <= x + y;
	when "001" => ula_out <= x and y;
	when "010" => ula_out <= x or y;
	when "011" => ula_out <= not x;
	when "100" => ula_out <= y;
	when "101" => ula_out <= x - y;
	when others => ula_out <= '0' & x(7 downto 1);
	
end case;

	if ula_out < 0 then
		N <= '1';
	else
		N <= '0';
	end if;
			
	if ula_out = "00000000" then
		Z <= '1';
	else
		Z <= '0';
	end if;

end process;

end Behavioral;