
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity PSR is
    Port ( clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           in_psrm : in  STD_LOGIC_VECTOR (3 downto 0);
			  in_windows_manager : in  STD_LOGIC;
			  out_windows_manager : out  STD_LOGIC;
           salida_psr_con_acarreo : out  STD_LOGIC);
end PSR;

architecture arq_PSR of PSR is

begin
	
	process(rst, clk, in_psrm,in_windows_manager)
		begin
		
			if (rst = '1') then 		
				 salida_psr_con_acarreo <= '0';
				 out_windows_manager <='0';
			else
				if (rising_edge(clk)) then
					salida_psr_con_acarreo <= in_psrm(0);
					out_windows_manager<= in_windows_manager;
				end if;
			end if;
	end process;

end arq_PSR;

