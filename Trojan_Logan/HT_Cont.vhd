library ieee;
use ieee.std_logic_1164.all;

--entity DFF is
 --   port (
 --       D, clk, RESET : in std_logic;
 --       Q, QB: out std_logic
--    );
--end entity DFF;

--architecture rtl of DFF is
--begin
    --p1 : process (clk, RESET)
   -- begin
    --if Reset'event and Reset='0' then Q <= '0';
     --   elsif rising_edge(clk) then
    --    Q<=D;
    --    QB <= NOT(D);
    --    end if;
    --end process p1;
--end architecture;

---
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity Trigger3 is
    port (
        RESET, clk   : in std_logic;
        op: out std_logic_vector(2 downto 0)
    );
end entity;

architecture rtl of Trigger3 is

signal count : unsigned(2 downto 0);

begin

process(clk)
begin
    if(rising_edge(clk)) then
    count <= count + 1;
        if RESET = '1' then
        count <= (others => '0');
        end if;
    end if;
end process;
op <= std_logic_vector(count);

end architecture;

---
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HT_Cont is
    port (
        compare : in std_logic;
        rst :in std_logic;
        trig : out std_logic
    );
end entity;

architecture rtl of HT_Cont is

signal first : unsigned(0 downto 0);
signal RESET : std_logic;
signal T : std_logic_vector(2 downto 0);
signal cout : std_logic_vector(2 downto 0);

begin

process (rst)
begin
    if(first = "1") then
    RESET <= '0';
    else 
    RESET <= '1';
    first <= "1";
    end if;
end process;

T(1) <= compare;
    Trigger3_inst : entity work.Trigger3
        port map(
            RESET => RESET,
            clk => rst,
            op => cout
        );
process (cout)
begin
    if (cout(2 downto 0) = "010") then
        T(2) <= '1';
    else 
        T(2) <= '0';
    end if;
end process;

T(0) <= T(2) and T(1);
trig <= T(0);
end architecture;