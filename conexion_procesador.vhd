----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:39 04/14/2017 
-- Design Name: 
-- Module Name:    conexion_procesador - arq_conexion_procesador 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conexion_procesador is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           resultado : out  STD_LOGIC_VECTOR (31 downto 0));
end conexion_procesador;

architecture arq_conexion_procesador of conexion_procesador is

	COMPONENT sumador
		PORT(
			operador1 : IN std_logic_vector(31 downto 0);
			operador2 : IN std_logic_vector(31 downto 0);          
			resultado_sum : OUT std_logic_vector(31 downto 0)
			);
	END COMPONENT;
	
	COMPONENT NPC
	PORT(
		direccion : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT unidadControl
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		salida : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT registerFile
	PORT(
		regFuente1 : IN std_logic_vector(5 downto 0);
		regFuente2 : IN std_logic_vector(5 downto 0);
		dataWrite : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		regDestino : IN std_logic_vector(5 downto 0);          
		contregFuente1 : OUT std_logic_vector(31 downto 0);
		contregFuente2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT Multiplexor
	PORT(
		dato_seu : IN std_logic_vector(31 downto 0);
		contrs2 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;
		rst : IN std_logic;          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT seu
	PORT(
		inmediato13bits : IN std_logic_vector(12 downto 0);
		salidaInmediato : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT alu
	PORT(
		operando1 : IN std_logic_vector(31 downto 0);
		operando2 : IN std_logic_vector(31 downto 0);
		alu_op : IN std_logic_vector(5 downto 0); 
		carry : IN std_logic; 
		salida_Alu : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT pse_Modifier
	PORT(
		rst : IN std_logic;
		in_crs1 : IN std_logic_vector(31 downto 0);
		in_mux : IN std_logic_vector(31 downto 0);
		in_aluresult : IN std_logic_vector(31 downto 0);
		in_aluop : IN std_logic_vector(5 downto 0);          
		salida_psrm : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSR
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		in_psrm : IN std_logic_vector(3 downto 0);
		in_windows_manager : in  STD_LOGIC;
		out_windows_manager : out  STD_LOGIC;
		salida_psr_con_acarreo : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT windows_manager
	PORT(
		in_rs1 : IN std_logic_vector(4 downto 0);
		in_rs2 : IN std_logic_vector(4 downto 0);
		in_rd : IN std_logic_vector(4 downto 0);
		in_op : IN std_logic_vector(1 downto 0);
		in_op3 : IN std_logic_vector(5 downto 0);
		in_cwp : IN std_logic;          
		out_ncwp : OUT std_logic;
		out_nrs1 : OUT std_logic_vector(5 downto 0);
		out_nrs2 : OUT std_logic_vector(5 downto 0);
		out_nrd : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	
	
	signal sumadorToNPC, npcTopc, pcToInstructionmemory, instruction_memoryTowm_Mux_seu, resultado_alu, registerfileToalu, registerfileToMultiplexor, seuToMultiplexor, multiplexorToalu: STD_LOGIC_VECTOR (31 downto 0);
	signal aluop1,windos_managerToRFrs1,windos_managerToRFrs2,windos_managerToRFd: STD_LOGIC_VECTOR (5 downto 0);
	signal psrmodifierTopsr: STD_LOGIC_VECTOR (3 downto 0);
	signal psrToalu, cwp,ncwp : STD_LOGIC;

begin

	Inst_sumador: sumador PORT MAP(
		operador1 => X"00000001",
		operador2 => pcToInstructionmemory,
		resultado_sum => sumadorToNPC
	);
	
	Inst_NPC: NPC PORT MAP(
		direccion => sumadorToNPC,
		rst => rst,
		clk => clk,
		salida => npcTopc
	);
	
	Inst_PC: NPC PORT MAP(
		direccion => npcTopc,
		rst => rst,
		clk => clk,
		salida => pcToInstructionmemory
	);
	
	Inst_instructionMemory: instructionMemory PORT MAP(
		address => pcToInstructionmemory,
		rst => rst,
		outInstruction => instruction_memoryTowm_Mux_seu
	);

	Inst_unidadControl: unidadControl PORT MAP(
		op => instruction_memoryTowm_Mux_seu(31 downto 30),
		op3 => instruction_memoryTowm_Mux_seu(24 downto 19),
		salida => aluop1
	);
	
	Inst_registerFile: registerFile PORT MAP(
		regFuente1 => windos_managerToRFrs1,
		regFuente2 => windos_managerToRFrs2,
		dataWrite => resultado_alu,
		rst => rst,
		regDestino => windos_managerToRFd,
		contregFuente1 => registerfileToalu,
		contregFuente2 => registerfileToMultiplexor
	);
	
	Inst_Multiplexor: Multiplexor PORT MAP(
		dato_seu => seuToMultiplexor,
		contrs2 => registerfileToMultiplexor,
		i => instruction_memoryTowm_Mux_seu(13),
		rst => rst,
		salida => multiplexorToalu
	);

	Inst_seu: seu PORT MAP(
		inmediato13bits => instruction_memoryTowm_Mux_seu(12 downto 0),
		salidaInmediato => seuToMultiplexor
	);
	
	Inst_alu: alu PORT MAP(
		operando1 => registerfileToalu,
		operando2 => multiplexorToalu,
		alu_op => aluop1,
		carry => psrToalu,
		salida_Alu => resultado_alu
	);
	
	Inst_pse_Modifier: pse_Modifier PORT MAP(
		rst => rst,
		in_crs1 => registerfileToalu,
		in_mux => multiplexorToalu,
		in_aluresult => resultado_alu,
		in_aluop => aluop1,
		salida_psrm => psrmodifierTopsr
	);
	
	Inst_PSR: PSR PORT MAP(
		clk => clk,
		rst => rst,
		in_psrm => psrmodifierTopsr,
		in_windows_manager => ncwp,
		out_windows_manager => cwp,
		salida_psr_con_acarreo => psrToalu
	);
	
	Inst_windows_manager: windows_manager PORT MAP(
		in_rs1 => instruction_memoryTowm_Mux_seu(18 downto 14),
		in_rs2 => instruction_memoryTowm_Mux_seu(4 downto 0),
		in_rd => instruction_memoryTowm_Mux_seu(29 downto 25),
		in_op => instruction_memoryTowm_Mux_seu(31 downto 30),
		in_op3 => instruction_memoryTowm_Mux_seu(24 downto 19),
		in_cwp => cwp,
		out_ncwp => ncwp,
		out_nrs1 => windos_managerToRFrs1,
		out_nrs2 => windos_managerToRFrs2,
		out_nrd => windos_managerToRFd
	);
	
	resultado <= resultado_alu;
end arq_conexion_procesador;