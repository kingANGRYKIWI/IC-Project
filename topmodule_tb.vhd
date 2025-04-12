----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2025 10:30:11 AM
-- Design Name: 
-- Module Name: topmodule_tb - Behavioral
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

entity topmodule_tb is
end topmodule_tb;

architecture Behavioral of topmodule_tb is
    component topmodule is
        Port ( 
              clk : in std_logic;
              correct_cipher : out std_logic; -- High if ciphertext is correct
              started: out std_logic; -- High if AES was told to start...
              clock_led : out std_logic;
              finished : out std_logic -- High if done rose at least once
               );
    end component topmodule;
        
    -- input signal
    signal clk : std_logic := '0';        
    
    -- output signals
    signal correct_cipher : std_logic; -- High if ciphertext is correct
    signal started: std_logic; -- High if AES was told to start...
    signal clock_led : std_logic;
    signal finished : std_logic; -- High if done rose at least once
    
    -- clock period?
    constant clk_period : time := 10 ns;    
begin
	
	-- Instantiating the topmodule
	top_mod : topmodule
	   port map(
	       clk=> clk,
	       correct_cipher => correct_cipher,
	       started => started,
	       clock_led => clock_led,
	       finished=> finished
	       );
	 -- clock process definitions
	clk_process : process is
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process clk_process;


end Behavioral;
