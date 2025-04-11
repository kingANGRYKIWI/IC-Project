----------------------------------------------------------------------------------
-- Company:
-- Engineer: Instructor
--
-- Create Date: 
-- Design Name:
-- Module Name: topmodule - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topmodule is
    Port ( 
          correct_cipher : out std_logic
           );
end topmodule;

architecture Behavioral of topmodule is

component aes_enc
    Port (
        clk : in std_logic;
		rst : in std_logic;
		key : in std_logic_vector(127 downto 0);
		plaintext : in std_logic_vector(127 downto 0);
		ciphertext : out std_logic_vector(127 downto 0);
		done : out std_logic
		);	
end component;

SIGNAL clk,rst,done : STD_LOGIC;
SIGNAL key : STD_LOGIC_VECTOR(127 DOWNTO 0):= x"3c4fcf098815f7aba6d2ae2816157e2b";
SIGNAL plaintext : STD_LOGIC_VECTOR(127 DOWNTO 0):=x"340737e0a29831318d305a88a8f64332";
SIGNAL ciphertext: STD_LOGIC_VECTOR(127 downto 0);

constant clk_period : time := 10 ns;

begin

clk_process : process is
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process clk_process;

comp_ADD:  aes_enc
           port map (clk => clk, rst => rst, key => key, plaintext => plaintext, ciphertext => ciphertext, done => done);
           
top_proc : process is
	begin
        plaintext <= x"340737e0a29831318d305a88a8f64332";
        key <= x"3c4fcf098815f7aba6d2ae2816157e2b";
        rst <= '0';
		  -- Hold reset state for one cycle		
		wait for clk_period * 1;
		rst <= '1';
		wait until done = '1';
		wait for clk_period/2;
		if (ciphertext = x"320b6a19978511dcfb09dc021d842539") then
			correct_cipher <= '1';
		else
			correct_cipher <= '0';
		end if;
end process top_proc;

end Behavioral;
