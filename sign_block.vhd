library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity invertor is
    Port ( din : in STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (31 downto 0);
           en : in STD_LOGIC);
end invertor;
architecture Behavioral of invertor is
signal temp1:STD_LOGIC_VECTOR (31 downto 0):=(others=>'1');
signal temp2:STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin 
process(clk)
begin
temp2<=temp1 xor din;
end process;
dout<=temp2;
end Behavioral;