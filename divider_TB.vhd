library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.env;

entity divider_TB is
--  Port ( );
end divider_TB;

architecture Behavioral of divider_TB is
signal N_tb,D_tb,rem_tb,quo_tb:std_logic_vector(31 downto 0):=(others=>'0');
signal start_tb,clk_tb,reset_tb,ready_tb,zero_div_error:std_logic:='0';
signal i_count:unsigned(31 downto 0):=(others=>'0'); 
CONSTANT clk_period : time := 5 ns;
begin
UUT: entity work.divider port map(N=>N_tb,
           D=>D_tb,
           VALID=>start_tb,
           clk1=>clk_tb,
           reset=>reset_tb,
           READY=>ready_tb,
           remainder=>rem_tb,
           divisor_zero=> zero_div_error,
           quotient=>quo_tb);

--Clock generation with a time period of 5ns!!
Clock_Gen:process
begin
wait for clk_period;
clk_tb<=not clk_tb;
end process;

sig_gen:process
begin

    reset_tb<='1';   
    N_tb<=std_logic_vector(to_signed(-26,32));
    D_tb<=std_logic_vector(to_signed(-5,32));
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    --wait for clk_period;
    assert rem_tb = std_logic_vector(to_unsigned(1,32)) and quo_tb = std_logic_vector(to_unsigned(5,32)) report "Wrong output for the test case 1" severity error;
    report "result 1 ready";
    wait for clk_period;
    
    
    wait for clk_period;
    N_tb<=std_logic_vector(to_signed(-26,32));
    D_tb<=std_logic_vector(to_signed(5,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(1,32)) and quo_tb = std_logic_vector(to_signed(-5,32)) report "Wrong output for the test case 2" severity error;
    report "Result 2 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(-10005,32));
    D_tb<=std_logic_vector(to_signed(578,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(179,32)) and quo_tb = std_logic_vector(to_signed(-17,32)) report "Wrong output for the test case 3" severity error;
    report "Result 3 ready";
    wait for 5*clk_period;

 
    N_tb<=std_logic_vector(to_signed(-10005,32));
    D_tb<=std_logic_vector(to_signed(-578,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(179,32)) and quo_tb = std_logic_vector(to_signed(17,32)) report "Wrong output for the test case 4" severity error;
    report "Result 4 ready";
    wait for 5*clk_period;
    
    
    N_tb<=std_logic_vector(to_signed(-1000,32));
    D_tb<=std_logic_vector(to_signed(-999,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(1,32)) and quo_tb = std_logic_vector(to_signed(1,32)) report "Wrong output for the test case 5" severity error;
    report "Result 5 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(87550001,32));
    D_tb<=std_logic_vector(to_signed(10005578,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(7505377,32)) and quo_tb = std_logic_vector(to_signed(8,32)) report "Wrong output for the test case 6" severity error;
    report "Result 6 ready";
    wait for 5*clk_period;


    N_tb<=std_logic_vector(to_signed(-55785578,32));
    D_tb<=std_logic_vector(to_signed(-10001000,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(5780578,32)) and quo_tb = std_logic_vector(to_signed(5,32)) report "Wrong output for the test case 7" severity error;
    report "result 7 ready";
    wait for clk_period;
    
    N_tb<=std_logic_vector(to_signed(-26,32));
    D_tb<=std_logic_vector(to_signed(5,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(1,32)) and quo_tb = std_logic_vector(to_signed(-5,32)) report "Wrong output for the test case 8" severity error;
    report "Result 8 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(-11223344,32));
    D_tb<=std_logic_vector(to_signed(443322,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(140294,32)) and quo_tb = std_logic_vector(to_signed(-25,32)) report "Wrong output for the test case 9" severity error;
    report "Result 9 ready";
    wait for 5*clk_period;

 
    N_tb<=std_logic_vector(to_signed(-10005,32));
    D_tb<=std_logic_vector(to_signed(-578,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(179,32)) and quo_tb = std_logic_vector(to_signed(17,32)) report "Wrong output for the test case 10" severity error;
    report "Result 10 ready";
    wait for 5*clk_period;
    
    
    N_tb<=std_logic_vector(to_signed(-1000,32));
    D_tb<=std_logic_vector(to_signed(-5578,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(1000,32)) and quo_tb = std_logic_vector(to_signed(0,32)) report "Wrong output for the test case 11" severity error;
    report "Result 11 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(8701,32));
    D_tb<=std_logic_vector(to_signed(57,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(37,32)) and quo_tb = std_logic_vector(to_signed(152,32)) report "Wrong output for the test case 12" severity error;
    report "Result 12 ready";
    wait for 5*clk_period;
    
    
        N_tb<=std_logic_vector(to_signed(-102201,32));
    D_tb<=std_logic_vector(to_signed(222,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(81,32)) and quo_tb = std_logic_vector(to_signed(-460,32)) report "Wrong output for the test case 13" severity error;
    report "result 13 ready";
    wait for clk_period;
    
       N_tb<=std_logic_vector(to_signed(-1729,32));
    D_tb<=std_logic_vector(to_signed(12,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(1,32)) and quo_tb = std_logic_vector(to_signed(-144,32)) report "Wrong output for the test case 14" severity error;
    report "Result 14 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(-1057,32));
    D_tb<=std_logic_vector(to_signed(57,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(31,32)) and quo_tb = std_logic_vector(to_signed(-18,32)) report "Wrong output for the test case 15" severity error;
    report "Result 15 ready";
    wait for 5*clk_period;

 
    N_tb<=std_logic_vector(to_signed(-101010,32));
    D_tb<=std_logic_vector(to_signed(1010,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(10,32)) and quo_tb = std_logic_vector(to_signed(-100,32)) report "Wrong output for the test case 16" severity error;
    report "Result 16 ready";
    wait for 5*clk_period;
    
    
    N_tb<=std_logic_vector(to_signed(7654321,32));
    D_tb<=std_logic_vector(to_signed(1234567,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(246919,32)) and quo_tb = std_logic_vector(to_signed(6,32)) report "Wrong output for the test case 17" severity error;
    report "Result 17 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(10005578,32));
    D_tb<=std_logic_vector(to_signed(10005578,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(0,32)) and quo_tb = std_logic_vector(to_signed(1,32)) report "Wrong output for the test case 18" severity error;
    report "Result 18 ready";
    wait for 5*clk_period;
    
    
     N_tb<=std_logic_vector(to_signed(112358,32));
    D_tb<=std_logic_vector(to_signed(1321,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(73,32)) and quo_tb = std_logic_vector(to_signed(85,32)) report "Wrong output for the test case 19" severity error;
    report "result 19 ready";
    wait for clk_period;
    
      N_tb<=std_logic_vector(to_signed(-1048576,32));
    D_tb<=std_logic_vector(to_signed(1024,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(0,32)) and quo_tb = std_logic_vector(to_signed(-1024,32)) report "Wrong output for the test case 20" severity error;
    report "Result 20 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(111111,32));
    D_tb<=std_logic_vector(to_signed(1111,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(11,32)) and quo_tb = std_logic_vector(to_signed(100,32)) report "Wrong output for the test case 21" severity error;
    report "Result 21 ready";
    wait for 5*clk_period;

 
    N_tb<=std_logic_vector(to_signed(-8755,32));
    D_tb<=std_logic_vector(to_signed(1000,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(755,32)) and quo_tb = std_logic_vector(to_signed(-8,32)) report "Wrong output for the test case 22" severity error;
    report "Result 22 ready";
    wait for 5*clk_period;
    
        
    N_tb<=x"000FFFFF";
    D_tb<=x"000000FF";
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(0,32)) and quo_tb = x"000FFFFF" report "Wrong output for the test case 23" severity error;
    report "Result 23 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(8701,32));
    D_tb<=std_logic_vector(to_signed(-5500,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert rem_tb = std_logic_vector(to_signed(3201,32)) and quo_tb = std_logic_vector(to_signed(-1,32)) report "Wrong output for the test case 24" severity error;
    report "Result 24 ready";
    wait for 5*clk_period;
    
    N_tb<=std_logic_vector(to_signed(55000,32));
    D_tb<=std_logic_vector(to_signed(0,32));
    reset_tb<='1';
    wait for clk_period;
    reset_tb<='0';
    start_tb<='1';
    wait until ready_tb='1';
    assert zero_div_error='1' report "Divison by zero not detected" severity error;
    report "Result 25 ready";
    wait for 5*clk_period;
    env.finish;  
  

end process;

    
end Behavioral;


