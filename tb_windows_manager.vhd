--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:31:21 05/04/2017
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/Procesador 3/tb_windows_manager.vhd
-- Project Name:  Procesador
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: windows_manager
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_windows_manager IS
END tb_windows_manager;
 
ARCHITECTURE behavior OF tb_windows_manager IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT windows_manager
    PORT(
         in_rs1 : IN  std_logic_vector(4 downto 0);
         in_rs2 : IN  std_logic_vector(4 downto 0);
         in_rd : IN  std_logic_vector(4 downto 0);
         in_op : IN  std_logic_vector(1 downto 0);
         in_op3 : IN  std_logic_vector(5 downto 0);
         in_cwp : IN  std_logic;
         out_ncwp : OUT  std_logic;
         out_nrs1 : OUT  std_logic_vector(5 downto 0);
         out_nrs2 : OUT  std_logic_vector(5 downto 0);
         out_nrd : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal in_rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal in_rd : std_logic_vector(4 downto 0) := (others => '0');
   signal in_op : std_logic_vector(1 downto 0) := (others => '0');
   signal in_op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal in_cwp : std_logic := '0';

 	--Outputs
   signal out_ncwp : std_logic;
   signal out_nrs1 : std_logic_vector(5 downto 0);
   signal out_nrs2 : std_logic_vector(5 downto 0);
   signal out_nrd : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: windows_manager PORT MAP (
          in_rs1 => in_rs1,
          in_rs2 => in_rs2,
          in_rd => in_rd,
          in_op => in_op,
          in_op3 => in_op3,
          in_cwp => in_cwp,
          out_ncwp => out_ncwp,
          out_nrs1 => out_nrs1,
          out_nrs2 => out_nrs2,
          out_nrd => out_nrd
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      in_rs1 <="00111";
		in_rs2 <="01010";
		in_rd <="01101";
		in_op <="10";
		in_op3 <="111100";
		in_cwp <='1';


      wait;
   end process;

END;
