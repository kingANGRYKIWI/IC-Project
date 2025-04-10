----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2025 12:40:28 PM
-- Design Name: 
-- Module Name: d_flip_flop - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-- I know at the start that when rst='0' AND clck='0' AND done='0' that it is the first run
-- Right now might change done to inout so that I can use that as the reset
entity d_flip_flop is
    Port ( Clock : in STD_LOGIC;
           D : in STD_LOGIC;
           Reset: in STD_LOGIC;
           Q : out STD_LOGIC);
end d_flip_flop;

architecture Behavioral of d_flip_flop is
begin
process (Clock,Reset) begin
if Reset'event and Reset='0' then Q <= '0';
elsif rising_edge(Clock) then Q<=D; end if;
--if Clock'event and Clock = '1' then Q <= D; end if; -- Note may want to change Clock'event and Clock = '1' to if rising_edge(Clock) then Q <= D;
end process;
end Behavioral;
