----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neander is
	port (
		clk, rst 				: in std_logic;
		mem_addr					: in std_logic_vector(7 downto 0);
		mem_data					: out std_logic_vector(7 downto 0)	
		);
end neander;

architecture Behavioral of neander is

--COMPONENTS
COMPONENT memory
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

COMPONENT mux_2x1
	PORT(
		A, B 	:	in std_logic_vector(7 downto 0);
		sel 	: 	in std_logic;
		S 		:	out std_logic_vector(7 downto 0)
		);
END COMPONENT;

COMPONENT REG
	PORT(
		clk, load : in std_logic; 
		load_in 	: in std_logic_vector(7 downto 0);
		reg_out 	: out std_logic_vector(7 downto 0)
	);
END COMPONENT;

COMPONENT programCounter
PORT(
		clk, rst, cargaPC, incrementaPC : in std_logic;
		pcIn : in std_logic_vector(7 downto 0);
		pcOut : out std_logic_vector(7 downto 0)
	);
END COMPONENT;

COMPONENT ULA
PORT(
		x,y	: in std_logic_vector(7 downto 0);
		sel_ULA: in std_logic_vector(2 downto 0);
		N,Z: out std_logic;
		ula_out: inout std_logic_vector(7 downto 0) --made inout
	);
END COMPONENT;

COMPONENT decod
PORT(
	op_code	:	in std_logic_vector(3 downto 0);
	inst	:	out std_logic_vector(12 downto 0)
	);
END COMPONENT;

--registers associated with the memory and instructions
signal reg_inst	: std_logic_vector(7 downto 0);
signal reg_m_addr	: std_logic_vector(7 downto 0);
signal reg_m_data	: std_logic_vector(7 downto 0);
--signals connecting the modules
signal sig_ac		: std_logic_vector(7 downto 0);
signal sig_pc		: std_logic_vector(7 downto 0);
signal sig_ula		: std_logic_vector(7 downto 0);
signal sig_mem		: std_logic_vector(7 downto 0);
signal sig_inst	: std_logic_vector(12 downto 0);
signal sig_N		: std_logic;
signal sig_Z		: std_logic;
--control signals
signal control_ld_ac			:	std_logic;
signal control_ld_pc			: 	std_logic;
signal control_inc_pc		:	std_logic;
signal control_write_mem	:	std_logic_vector(0 downto 0); --"Because FUCK YOU" Design Suite, ISE
signal control_read_mem		:	std_logic;
signal control_sel_mux		:	std_logic;
signal control_sel_UlA		:	std_logic_vector(2 downto 0);

begin

	mux: mux_2x1
	PORT MAP(
		A => sig_pc, 
		B => reg_m_data,
		sel => control_sel_mux,
		S => reg_m_addr
	);

	ac: REG
	PORT MAP(
		clk => clk,
		load => control_ld_ac,			
		load_in => sig_ula,
		reg_out => sig_ac
	);
	
	pc: programCounter
	PORT MAP(
		clk => clk,
		rst => rst,
		cargaPC => control_ld_pc,
		incrementaPC => control_inc_pc,
		pcIn => sig_mem,
		pcOut => sig_pc
	);
	
	ula1: ULA
	PORT MAP(
		x => sig_ac,
		y => sig_mem,
		sel_ULA => control_sel_ULA,
		ula_out => sig_ula,
		N => sig_N,
		Z => sig_Z
	);
	
	decod1: decod
	PORT MAP(
		op_code => reg_inst(7 downto 4),
		inst => sig_inst
	);
	
	memory1: memory
	PORT MAP (
    --port A
	 clka => clk,
    wea => control_write_mem,
    addra => reg_m_addr,
    dina => sig_ac,
    douta => reg_m_data,
	 --port B
    clkb => clk,
    web => "0",
    addrb => mem_addr,
    dinb => (others => '0'),
    doutb => mem_data
	);
  
end Behavioral;