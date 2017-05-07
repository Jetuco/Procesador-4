
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;



entity windows_manager is
    Port ( in_rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           in_rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           in_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           in_op : in  STD_LOGIC_VECTOR (1 downto 0);
           in_op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           in_cwp : in  STD_LOGIC;
           out_ncwp : out  STD_LOGIC;
           out_nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           out_nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           out_nrd : out  STD_LOGIC_VECTOR (5 downto 0));
end windows_manager;

architecture arq_windows_manager of windows_manager is

signal rs1Integer,rs2Integer,rdInteger: integer range 0 to 39:=0;

begin
	process (in_rs1,in_rs2,in_rd,in_op, in_op3, in_cwp)
		begin
			--			  save		
			if (in_op3 = "111100" and in_op = "10")  then -- Valida que sea formato 3 con el op y que sea SAVE con op3
				out_ncwp <= '1'; 									
			--				restore
			else 
				if (in_op3 = "111101" and in_op = "10") then
					out_ncwp <= '0';
				else
					out_ncwp <= in_cwp;
				end if;
				
			end if;	
			
			
			if (in_rs1 >= "00000" and in_rs1 <= "00111")	then
				rs1Integer <= conv_integer(in_rs1);
			else	
			--					24						31
				if (in_rs1 >= "11000" and in_rs1 <= "11111")	then
				--												16	
					rs1Integer <= conv_integer(in_rs1)-(conv_integer(in_cwp)*16);
				--							16						    23
				else 
					if (in_rs1 >= "10000" and in_rs1 <= "10111")	then
							rs1Integer <= conv_integer(in_rs1)+(conv_integer(in_cwp)*16);
				--							 8						    15
					else 
						if (in_rs1 >= "01000" and in_rs1 <= "01111")	then
							rs1Integer <= conv_integer(in_rs1)+(conv_integer(in_cwp)*16);
						end if;
					end if;
				end if;
			end if;
			
			if (in_rs2 >= "00000" and in_rs2 <= "00111")	then
				rs1Integer <= conv_integer(in_rs2);
			else
				--					24						31
				if (in_rs2 >= "11000" and in_rs2 <= "11111")	then
				--												16	
					rs2Integer <= conv_integer(in_rs2)-(conv_integer(in_cwp)*16);
				--							16						23
				else 
					if (in_rs2 >= "10000" and in_rs2 <= "10111")	then
						rs2Integer <= conv_integer(in_rs2)+(conv_integer(in_cwp)*16);
				--							8						15
					else 
						if (in_rs2 >= "01000" and in_rs1 <= "01111")	then
							rs2Integer <= conv_integer(in_rs2)+(conv_integer(in_cwp)*16);
						end if;
					end if;
				end if;
			end if;
			
			if (in_rd >= "00000" and in_rd <= "00111")	then
				rdInteger <= conv_integer(in_rd);
			else
				--					     24						  31
				if (in_rd >= "11000" and in_rd <= "11111")	then
					rdInteger <= conv_integer(in_rd)-(conv_integer(in_cwp)*16);
				--							16						23
				else 
					if (in_rd >= "10000" and in_rd <= "10111")	then
						rdInteger<= conv_integer(in_rd)+(conv_integer(in_cwp)*16);
				--							8						15
					else
						if (in_rd >= "01000" and in_rd <= "01111")	then
							rdInteger <= conv_integer(in_rd)+(conv_integer(in_cwp)*16);
						end if;
					end if;
				end if;
			end if;	
	end process;
	out_nrs1 <= CONV_STD_LOGIC_VECTOR(rs1Integer, 6);
   out_nrs2 <= CONV_STD_LOGIC_VECTOR(rs2Integer, 6);
   out_nrd  <= CONV_STD_LOGIC_VECTOR(rdInteger, 6);
end arq_windows_manager;