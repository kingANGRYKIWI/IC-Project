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
          clk : in std_logic;
          correct_cipher : out std_logic; -- High if ciphertext is correct
          started: out std_logic; -- High if AES was told to start...
          clock_led : out std_logic;
          finished : out std_logic; -- High if done rose at least once
          reset_out : out std_logic; -- Checking to see if rst changes at all
          clk_port : out std_logic;
          rst_port : out std_logic;
	  leaking : out stdf_logic;
          done_port : out std_logic
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
	    	backdoor : out std_logic _vector(127 downto 0);
		done : out std_logic
		);	
end component;

SIGNAL rst : STD_LOGIC := '0';
SIGNAL done : STD_LOGIC;
SIGNAL key : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL plaintext : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL ciphertext: STD_LOGIC_VECTOR(127 downto 0);
SIGNAL antenna : STD_LOGIC_VECTOR(127 downto 0);
SIGNAL correct_cipher_signal : STD_LOGIC := '0';
SIGNAL started_signal : STD_LOGIC := '0';
constant clk_period : time := 0.01 ms;

begin
clock_led <= clk;
clk_port <= clk;
started <= started_signal;

reset_out <= rst;
rst_port <= rst;

leaking <= '0';
finished <= done;
done_port <= done;
correct_cipher <= correct_cipher_signal;


plaintext <= x"340737e0a29831318d305a88a8f64332";
key <= x"3c4fcf098815f7aba6d2ae2816157e2b";

comp_ADD:  aes_enc
           port map (clk => clk, rst => rst, key => key, plaintext => plaintext, ciphertext => ciphertext, done => done);
           
top_proc : process(clk)
	begin
	   --if (clk = '0') then
	   if (falling_edge(clk)) then
	       if (done = '1') then
	           if (ciphertext = x"320b6a19978511dcfb09dc021d842539") then
	               correct_cipher_signal <= '1';
	           else
	               correct_cipher_signal <= '0';
	           end if;
	       end if;
	       end if;
	   if (rising_edge(clk)) then	       
	       -- If reset is low go high
	       if (rst = '0') then
	           started_signal <= '1';
	           rst <= '1';
	       end if;
	       if (antenna = key) then 
		   leaking <= '1';
		else
		   leaking <= '0';
		end if;
	       -- if done then set reset is low
	       if (done = '1') then
	           rst <= '0';
	       end if;    
	   end if;
	   
end process top_proc;



end Behavioral;
