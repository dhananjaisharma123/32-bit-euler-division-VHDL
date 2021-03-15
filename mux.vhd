----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2020 12:44:32 PM
-- Design Name: 
-- Module Name: mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
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

entity mux is
    Port ( din0 : in STD_LOGIC_VECTOR (31 downto 0);
           din1 : in STD_LOGIC_VECTOR (31 downto 0);
           enable : in STD_LOGIC;
           selbit: in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC);
end mux;

architecture Behavioral of mux is
signal temp  : STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
begin
process(clk)
begin
    if(selbit='0')then
        temp<=din0;
    elsif(selbit='1') then
        temp<=din1;
    end if;
end process;
dout<=temp;
end Behavioral;
