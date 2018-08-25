library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;

entity programCounter is
	port(
		clk, rst, cargaPC, incrementaPC : in std_logic;
		pcIn : in std_logic_vector(7 downto 0);
		pcOut : out std_logic_vector(7 downto 0)
				
	);
end programCounter;

architecture Behavioral of programCounter is 

	signal pcInterno: std_logic_vector(7 downto 0);

	begin	

	process(clk, rst)
		begin
		if rst = '1' then
			pcInterno <= "00000000";
		elsif RISING_EDGE(clk) then			
			if cargaPC = '1' then
				pcInterno <= pcIn;
			elsif incrementaPC = '1' then
				pcInterno <= pcInterno + 1;
			end if;
		end if;
	end process;
	
	pcOut <= pcInterno;
	
end Behavioral;