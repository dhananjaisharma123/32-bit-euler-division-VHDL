library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity subtractor is
    Port ( din1 : in unsigned (31 downto 0);
           din2 : in unsigned (31 downto 0);
           clk: in STD_LOGIC;
           dout : out unsigned (31 downto 0);
           enable : in STD_LOGIC);
end subtractor;

architecture Behavioral of subtractor is
signal temp: unsigned (31 downto 0);
begin 
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(enable='1') then
                temp<=din1-din2;
            end if;
        end if;
    end process;
    dout<=temp;
end Behavioral;
