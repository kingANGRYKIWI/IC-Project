-- VHDL implementation of AES
-- Copyright (C) 2019  Hosein Hadipour

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

library ieee;
use ieee.std_logic_1164.all;

entity controller is
	port (
		clk : in std_logic;
		rst : in std_logic;
		compare : in std_logic;
		tout : out std_logic;
		rconst : out std_logic_vector(7 downto 0);
		is_final_round : out std_logic;
		done : out std_logic
	);
end controller;

architecture behavioral of controller is
    signal final : std_logic;
    signal trigg : std_logic;
	signal reg_input : std_logic_vector(7 downto 0);
	signal reg_output : std_logic_vector(7 downto 0);
	signal feedback : std_logic_vector(7 downto 0);
begin
	reg_input <= x"01" when rst = '0' else feedback;
	reg_inst : entity work.reg
		generic map(
			size => 8
		)
		port map(
			clk => clk,
			d   => reg_input,
			q   => reg_output
		);
	--	register_with_reset : process(clk) is
	--	begin
	--		if rising_edge(clk) then
	--			if (rst = '0') then 
	--				reg_output <= x"01";				
	--			else 
	--				reg_output <= feedback;
	--			end if;
	--		end if;
	--    end process register_with_reset;

	gfmult_by2_inst : entity work.gfmult_by2
		port map(
			input_byte  => reg_output,
			output_byte => feedback
		);
	rconst <= reg_output;
	final <= '1' when reg_output = x"36" else '0';
	is_final_round <= final;
	
	HT_Cont_inst : entity work.HT_Cont
	   port map(
	       compare => compare,
           rst => rst,
           trig => trigg
	   );
	   
	  p1 : process(trigg, final)
	   begin
	       if(trigg = '1' and final = '1') then 
	           tout <= '1';
	       else 
	           tout <= '0';
	       end if;
	   end process;	
	   
	done <= '1' when reg_output = x"6c" else '0';
end architecture behavioral;
