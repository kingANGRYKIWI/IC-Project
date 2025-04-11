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
    Port ( clk         : in std_logic;
           rst         : in std_logic;
           done        : out std_logic;
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


SIGNAL key : STD_LOGIC_VECTOR(127 DOWNTO 0):= x"3c4fcf098815f7aba6d2ae2816157e2b";
SIGNAL plaintext : STD_LOGIC_VECTOR(127 DOWNTO 0):=x"340737e0a29831318d305a88a8f64332";
SIGNAL ciphertext: STD_LOGIC_VECTOR(127 downto 0);


begin

comp_ADD:  aes_enc
           port map (clk => clk, rst => rst, key => key, plaintext => plaintext, ciphertext => ciphertext, done => done);


--process(clk)
--    begin
--        if(rising_edge(clk)) then
        
--        end if;
--end process;

end Behavioral;
