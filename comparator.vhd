library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity comparator is
    Port ( din1 : in std_logic_vector(31 downto 0);
              din2 : in std_logic_vector(31 downto 0);
              clk: in STD_LOGIC;
              dout : out STD_LOGIC;
              enable : in STD_LOGIC);
end comparator;

architecture Behavioral of comparator is
signal comp_temp: std_logic;
begin
process(clk)
begin
if(rising_edge(clk)) then
    if(enable ='1') then
        if(unsigned(din1)>=unsigned(din2)) then
            comp_temp<='1';
        elsif(unsigned(din1)<unsigned(din2)) then
            comp_temp<='0';
       end if;
    end if;
end if;
end process;
dout<=comp_temp;
end Behavioral;