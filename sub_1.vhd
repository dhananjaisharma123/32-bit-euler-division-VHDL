library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sub_1 is
    Port ( din : in STD_LOGIC_VECTOR (31 downto 0);
              clk: in STD_LOGIC;
           enable : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end sub_1;

architecture Behavioral of sub_1 is
signal temp:unsigned( 31 downto 0):=(others=>'0');
begin
process(clk)
begin
if(enable='1') then 
temp<=unsigned(din)-1;
end if;
end process;
dout<=std_logic_vector(temp);
end Behavioral;