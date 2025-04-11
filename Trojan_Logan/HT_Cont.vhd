library ieee;
use ieee.std_logic_1164.all;

entity DFF is
    port (
        D, clk   : in std_logic;
        Q, QB: out std_logic
    );
end entity DFF;

architecture rtl of DFF is
begin
    p1 : process (clk)
    begin
        if (clk'EVENT and clk = '1') then
        Q<=D;
        QB <= NOT(D);
        end if;
    end process p1;
end architecture;

---
library ieee;
use ieee.std_logic_1164.all;

entity Trigger3 is
    port (
        rst   : in std_logic;
        op: out std_logic
    );
end entity;

architecture rtl of Trigger3 is

signal count_out : std_logic_vector(2 downto 0);
signal clock_out : std_logic_vector(3 downto 0);
signal done : std_logic;

begin
clock_out(0) <= rst; 
    gen_DFF : for I in 0 to 2 generate
        DFF_inst : entity work.DFF 
            port map(
                D => clock_out(I+1), 
                clk => clock_out(I),
                Q => count_out(I),
                QB => clock_out(I+1)
            );
    end generate;

count_out <= count_out(2) & count_out(1) & count_out(0);

    p1 : process (count_out)
    begin
        if (count_out = "111") then
            done <= '1';
        else
            done <= '0';
        end if;
    end process;
op <= done;
end architecture;

---
library ieee;
use ieee.std_logic_1164.all;

entity HT_Cont is
    port (
        compare : in std_logic;
        rst :in std_logic;
        trig : out std_logic
    );
end entity;

architecture rtl of HT_Cont is

signal T : std_logic_vector(2 downto 0);

begin
T(1) <= compare;
    Trigger3_inst : entity work.Trigger3
        port map(
            rst => rst,
            op => T(2)
        );
T(0) <= T(2) and T(1);
trig <= T(0);
end architecture;