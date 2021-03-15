library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Adder_one is
    Port ( din : in std_logic_vector (31 downto 0);
              clk : in STD_LOGIC;
              enable : in STD_LOGIC;
              dout: out std_logic_vector(31 downto 0));
end Adder_one;

architecture Behavioral of Adder_one is
signal temp: std_logic_vector(31 downto 0);
begin
process(clk)
begin
    temp<=std_logic_vector(unsigned(din)+1);
end process;
dout<=temp;
end Behavioral;