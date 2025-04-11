library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is
    port (
    selec : in std_logic;
    A1 : in std_logic_vector(127 downto 0);
    A0 : in std_logic_vector(127 downto 0);
    MUX_OUT : out std_logic_vector (127 downto 0)
    );
end Mux;

architecture rtl of Mux is
begin
    p1: process(selec)
    begin
        case (selec) is
        when '1' => 
            MUX_OUT <= A1;
        when '0' => 
            MUX_OUT <= A0;
        end case;
    end process; 
end rtl;
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HT_Pay is
    port (
        tin : in std_logic;
        input : in std_logic_vector(127 downto 0);
        back : out std_logic_vector(127 downto 0)
    );
end HT_Pay;

architecture rtl of HT_Pay is
    signal impedence : std_logic_vector(127 downto 0) := "Z";
    
begin
    Mux_inst : entity work.Mux 
        port map(
            selec => tin,
            A1 => input,
            A0 => impedence,
            MUX_OUT => back
        );
end rtl;
