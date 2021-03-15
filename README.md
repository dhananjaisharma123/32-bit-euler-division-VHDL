# 32-bit-euler-division-VHDL
The Euclidean algorithm is used for implementing the divider system as the operation is very
intuitive.
The design strategy used develop the system :-
1) Identified the required inputs and outputs
2) Identified any additional I/Os that might be needed(division by zero is added)
3) Choose the algorithm (Euclidean as the implementation is very intuitive)
4) Unravelling the loop and identifying the basic operations (compare and subtract)
5) Identifying the modules necessary to implement the algorithm like adder, subtractor,
invertor etc
6) Deciding the IOs of the modules and then building a FSM to control the operation of
these modules.
7) Testing the system with help of testbenches!
The selected testbench is used in order to cover the following cases :-
1) –(numerator) / (denominator)
2) –(numerator) / -(denominator)
3) (numerator) / -(denominator)
4) (numerator) / (denominator)
5) 0 / (denominator)
6) (numerator) / 0 (Error signal generated!!)
Problem with the Euclidean division is that it takes a lot of time to complete if numerator>>denominator!
For ex. If xEFFFFFFF is divided by x00000001 , with the present design the number of cycles to execute the operation is very high!!(Thus removed for testing the system) even though the system will calculate the answer but the time taken for the computation is fairly high!!

The system gets three inputs i.e. N(32 bit), D(32 bit) and a VALID bit and the system outputs 4 signals i.e. rem(Remainder), Quo(Quotient) ,READY(1-bit) and Div_zero(1-bit).
Description of signals
1) N ------INPUT(32-bit)------ the numerator
2) D ------INPUT(32-bit)------ the denominator
3) VALID ------INPUT(1-bit)------ the input(N and D) is valid(Evaluation starts at
VALID=’1’)
4) rem ------OUTPUT(32-bit)------ the evaluated remainder
5) Quo ------OUTPUT(32-bit)------ the evaluated quotient
6) Div_zero ------OUTPUT(1-bit)------ error signal when division by zero
(D=x”00000000”)
7) READY------OUTPUT(1-bit)------ The values of reminder and quotient are available
on o/p line (rem and Quo)
