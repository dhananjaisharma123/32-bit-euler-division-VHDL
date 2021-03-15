library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity divider is
    Port ( N : in STD_LOGIC_VECTOR (31 downto 0); --numerator!
           D : in STD_LOGIC_VECTOR (31 downto 0);  --denominator 
           VALID: in STD_LOGIC; --valid bit
           clk1: in STD_LOGIC; --clock signal 
           reset:in STD_LOGIC;
           READY : inout STD_LOGIC;
           remainder : out STD_LOGIC_VECTOR (31 downto 0);
           divisor_zero: out std_logic;
           quotient : out STD_LOGIC_VECTOR (31 downto 0));
end divider;

architecture Behavioral of divider is

--signals for R-register   The remainder will be loaded into this register ! Initially it has the value of N
signal r_reg_din,r_reg_dout: std_logic_vector(31 downto 0);
signal r_reg_enable,r_reg_reset:std_logic;

--signals for Q-register
signal q_reg_dout: std_logic_vector(31 downto 0);
signal q_reg_enable,q_reg_reset:std_logic;

--signal for adder 
signal adder_out:std_logic_vector(31 downto 0);
signal adder_enable: std_logic;

--signals for D-register
signal d_reg_dout: std_logic_vector(31 downto 0);
signal d_reg_enable,d_reg_reset,zero:std_logic;
--signal comparator
signal comp_out,comp_enable:std_logic;

--signal subtractor
signal sub_out:std_logic_vector(31 downto 0);
signal sub_enable:std_logic;

--signal mux
signal mux_selbit,mux_enable:STD_LOGIC;
signal mux_out:STD_LOGIC_VECTOR(31 downto 0);

--signal sign block
signal inv_enable1,inv_enable2:std_logic;
signal inv_out1,inv_out2:STD_LOGIC_VECTOR(31 downto 0);

--signal subtract by 1
signal sub_enable1,sub_enable2:std_logic;
signal sub_out1,sub_out2:STD_LOGIC_VECTOR(31 downto 0);

--Signal for N mux
signal muxn_enable:STD_LOGIC;
signal muxn_out:STD_LOGIC_VECTOR(31 downto 0);

--Signal for N mux
signal muxd_enable:STD_LOGIC;
signal muxd_out:STD_LOGIC_VECTOR(31 downto 0);

--Signals for output invertor!!
signal inv_quo_out:STD_LOGIC_VECTOR(31 downto 0);
signal inv_quo_enable:STD_LOGIC;

--Signals for output adder 
signal quo_add_out:STD_LOGIC_VECTOR(31 downto 0);
signal quo_add_en:STD_LOGIC;

--Signals for output mux
signal muxo_out:STD_LOGIC_VECTOR(31 downto 0);
signal mux_out_enable,out_selbit:STD_LOGIC;

--State type declaration
type statetype is(idle,init0,init1,c0,c1,c2,output1,output2);
signal state: statetype:=idle;


begin
--New Connections for unsigned!!!


--Input converting input from 2's complement
--(N,D)---->~(N-1)----->MUX_N and MUX_D---->(0)N(1)~(N-1) and (0)D-- (1)~(D-1) 
sub1:entity work.sub_1 port map(din=>N,clk=>clk1,enable=>sub_enable1,dout=>sub_out1); --To subtract one from the input value of N
sub2:entity work.sub_1 port map(din=>D,clk=>clk1,enable=>sub_enable2,dout=>sub_out2); --To subtract one from the input value of D
inv1: entity work.invertor port map(din=>sub_out1,clk=>clk1,dout=>inv_out1,en=>inv_enable1); --Inverting all the bits of the (N-1)
inv2: entity work.invertor port map(din=>sub_out2,clk=>clk1,dout=>inv_out2,en=>inv_enable2); --Inverting all the bits of the (D-1)
mux_N: entity work.mux port map(din0=>N,din1=>inv_out1,enable=>muxn_enable,selbit=>N(31),dout=>muxn_out,clk=>clk1); --depending upon the value of N(31) the mux will select which to route N or ~(N-1)
mux_D: entity work.mux port map(din0=>D,din1=>inv_out2,enable=>muxd_enable,selbit=>D(31),dout=>muxd_out,clk=>clk1); --depending upon the value of N(31) the mux will select which to route D or ~(D-1)

--Connections for giving the signed output  
--The output of the Q register is connected to a invertor followed by a 1-adder to give 2's complement number which is then followed by a mux_out(slection bit as D(31)xorN(31)) which selects either 2's complement of Q or Q
-- Q---->~Q---->(~Q+1),Q----->mux_out----> Q or (~Q+1)
inv_out:entity work.invertor port map(din=>q_reg_dout,clk=>clk1,dout=>inv_quo_out,en=>inv_quo_enable);
out_adder:entity work.Adder_one port map(din =>inv_quo_out,clk =>clk1, enable =>quo_add_en,dout=>quo_add_out);
mux_out1: entity work.mux port map(din0=>q_reg_dout,din1=>quo_add_out,enable=>mux_out_enable,selbit=>out_selbit,dout=>muxo_out,clk=>clk1);

--Connections !!
--Euclidean algo for finding the divison !!! 
R_reg:entity work.reg port map(din =>mux_out,dout =>r_reg_dout,load=>r_reg_enable,clk =>clk1,reset=>r_reg_reset);
Q_reg:entity work.reg port map(din =>adder_out,dout =>q_reg_dout,load=>q_reg_enable,clk =>clk1,reset=>q_reg_reset);
D_reg:entity work.reg port map(din =>muxd_out,dout =>d_reg_dout,load=>d_reg_enable,clk =>clk1,zero=>zero,reset=>d_reg_reset);
adder:entity work.Adder_one port map(din =>q_reg_dout,clk =>clk1, enable =>adder_enable,dout=>adder_out);
sub: entity work.subtractor port map(din1=>unsigned(r_reg_dout),din2=>unsigned(d_reg_dout),clk=>clk1,std_logic_vector(dout)=>sub_out,enable =>sub_enable);
comm: entity work.comparator port map(din1=>r_reg_dout,din2=>d_reg_dout,clk=>clk1,dout=>comp_out,enable=>comp_enable);
muxx: entity work.mux port map(din0=>muxn_out,din1=>sub_out,enable=>mux_enable,selbit=>mux_selbit,dout=>mux_out,clk=>clk1);

FSM:process(clk1,reset)
begin 
    if(reset='1') then 
        state<= idle;
    else
        if(rising_edge(clk1)) then 
            case state is 
                when idle =>
                if(VALID ='1') then 
                    state<=init0;  --Stays in this init state until the VALID bit is turned on!!!
                else
                    state<=idle;
                end if;
                when init0=>
                    state <=init1;        ---2's  complement is figured out !
                when init1=>
                    state <=c0;       --Valid inputs are loaded into the register!
                when c0=>
                    if zero ='1' then 
                        state<= output2;     ---calculation of Q and R begins in C0 and ends in C2 and if there is a division by 0 then the FSM is sent directly to the output state! 
                    else
                        state<=c1;
                    end if;
                    
                when c1=>
                    if(comp_out='1') then
                        state<=c2;
                    else
                        state<=output1;
                    end if;
                
                when c2=>
                    state<=c0;
                   
                when output1=>
                        state<=output2;               --- 2's complement is computed 
                when output2=>
                    if(READY='1') then    ---If o/p is ready than the FSM transitions to idle!!
                        state<=idle;
                    end if;
              end case;
           end if;
    end if;
end process;

CTRL:process(state)
begin

q_reg_reset<='0';
r_reg_reset<='0';
d_reg_reset<='0';
d_reg_enable<='0';
r_reg_enable<='0';
q_reg_enable<='0';
comp_enable<='0';
READY<='0';
mux_enable<='0';
adder_enable<='0';
sub_enable<='0';
sub_enable1<='1';
sub_enable2<='0';
inv_enable1<='0';
inv_enable2<='0';
muxn_enable<='0';
muxd_enable<='0';
inv_quo_enable<='0';
quo_add_en<='0';
muxd_enable<='0';
        
case state is 
    when idle =>                        --In the idle state all the register values are cleared !
        r_reg_reset<='1';   
        q_reg_reset<='1';
        d_reg_reset<='1';
    
    when init0=>                                        ---When the valid bit is 1 the FSM transitions into the INIT 0 state where the reverse 2's complement is calculated
        sub_enable1<='1';
        sub_enable2<='1';
        inv_enable1<='1';
        inv_enable2<='1';
        muxn_enable<='1';
        muxd_enable<='1';
        
    when init1=>                                        ---Value of N,Q(0) and D are loaded in the R and D registers respectively 
        mux_selbit<='0';
        mux_enable<='1';
        r_reg_enable<='1';
        q_reg_reset<='1';
        d_reg_enable<='1';
        
   when c0 =>
        comp_enable<='1';
        
   when c1=>
        adder_enable<='1';
        sub_enable<='1';
        
   when c2=>
        mux_enable<='1';
        mux_selbit<='1';
        r_reg_enable<='1';
        q_reg_enable<='1';
    
    when output1=>
        inv_quo_enable<='1';
        quo_add_en<='1';
        muxd_enable<='1';
        out_selbit<= N(31) xor D(31);
        
    when output2=>
         if(zero='1') then 
            r_reg_reset<='1';
            divisor_zero<='1';
            READY<='1';
         else 
            divisor_zero<='0';   
        end if;
        remainder<=r_reg_dout;
        quotient<=muxo_out;
        READY<='1';
end case;
end process;
end Behavioral; 