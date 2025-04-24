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
        if(selec = '1') then 
        MUX_OUT <= A1;
        else 
        MUX_OUT <= A0;
        end if;
    end process; 
end rtl;
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity HT_Pay is
    port (
        tin : in std_logic;
        input : in std_logic_vector(127 downto 0);
        back : out std_logic_vector(127 downto 0)
    );
end HT_Pay;

architecture rtl of HT_Pay is
    signal impedence : std_logic_vector(127 downto 0) := (others => 'Z');
    signal latch : std_logic;
    
begin
    process(tin)
    begin
        if(tin = '1') then 
        latch <= '1';
        else
        latch <= '0';
        end if;
    end process;
    
    Mux_inst : entity work.Mux 
        port map(
            selec => latch,
            A1 => input,
            A0 => impedence,
            MUX_OUT => back
        );

end rtl;
