library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Reg_NZ is 
	port (
		clk, load,rst : in std_logic; 
		load_in : in std_logic_vector(1 downto 0);
		reg_out : out std_logic_vector(1 downto 0);
		Z:out std_logic;	-- 1:Zero		0:Não zero
		N:out std_logic;	-- 1:Negativo	0:Não negativo
	);
end Reg_NZ;

architecture Behavioral of Reg_NZ is

signal reg : std_logic_vector(1 downto 0);

begin

process(clk, load,rst)

	if rst ='1' then
		reg <= (others =>'0');
		N <= '0';
		Z<= '0';
	else
		if RISING_EDGE(clk) then
			if load = '1' then
				reg <= load_in;
			else
				reg<= reg;
				if 	reg < 0 then
					N <= '1';
				else
					N <= '0';
				end if;
				
				if reg = "00" then
					Z <= '1';
				else
					Z <= '0';
				end if;
			end if;
		end if;
	end if;

end process;

reg_out <=  reg;

end Behavioral;