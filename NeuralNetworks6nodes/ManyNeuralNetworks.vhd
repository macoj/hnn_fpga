LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ieee_proposed;
USE ieee_proposed.fixed_pkg.all;

USE work.my_components.all;

ENTITY ManyNeuralNetworks IS 
GENERIC (	bits: 		INTEGER := 16;
			nodes:		INTEGER := 6;
			neurons: 	INTEGER := 6*(6 - 1)  );
PORT ( 	clk: IN STD_LOGIC;
		rst: IN STD_LOGIC;
		ya1: OUT bit;
		ya2: OUT bit;
		ya3: OUT bit;
		ya4: OUT bit;
		ya5: OUT bit;
		ya6: OUT bit;
		ya7: OUT bit;
		ya8: OUT bit;
		ya9: OUT bit;
		ya10: OUT bit;
		ya11: OUT bit;
		ya12: OUT bit;
		ya13: OUT bit;
		ya14: OUT bit;
		ya15: OUT bit;
		ya16: OUT bit;
		ya17: OUT bit;
		ya18: OUT bit;
		ya19: OUT bit;
		ya20: OUT bit;
		ya21: OUT bit;
		ya22: OUT bit;
		ya23: OUT bit;
		ya24: OUT bit;
		ya25: OUT bit;
		ya26: OUT bit;
		ya27: OUT bit;
		ya28: OUT bit;
		ya29: OUT bit;
		ya30: OUT bit
	 );
END ManyNeuralNetworks;

ARCHITECTURE manyNeural OF ManyNeuralNetworks IS 
			signal  state : 	bit_vector (2*neurons-1 DOWNTO 0);
			signal		y1:   	sfixed(bits downto -bits);
			signal		y2:   	sfixed(bits downto -bits);
			signal		y3:   	sfixed(bits downto -bits);
			signal		y4:   	sfixed(bits downto -bits);
			signal		y5:   	sfixed(bits downto -bits);
			signal		y6:   	sfixed(bits downto -bits);
			signal		y7:   	sfixed(bits downto -bits);
			signal		y8:   	sfixed(bits downto -bits);
			signal		y9:   	sfixed(bits downto -bits);
			signal		y10:   	sfixed(bits downto -bits);
			signal		y11:   	sfixed(bits downto -bits);
			signal		y12:   	sfixed(bits downto -bits);
			signal		y13:   	sfixed(bits downto -bits);
			signal		y14:   	sfixed(bits downto -bits);
			signal		y15:   	sfixed(bits downto -bits);
			signal		y16:   	sfixed(bits downto -bits);
			signal		y17:   	sfixed(bits downto -bits);
			signal		y18:   	sfixed(bits downto -bits);
			signal		y19:   	sfixed(bits downto -bits);
			signal		y20:   	sfixed(bits downto -bits);
			signal		y21:   	sfixed(bits downto -bits);
			signal		y22:   	sfixed(bits downto -bits);
			signal		y23:   	sfixed(bits downto -bits);
			signal		y24:   	sfixed(bits downto -bits);
			signal		y25:   	sfixed(bits downto -bits);
			signal		y26:   	sfixed(bits downto -bits);
			signal		y27:   	sfixed(bits downto -bits);
			signal		y28:   	sfixed(bits downto -bits);
			signal		y29:   	sfixed(bits downto -bits);
			signal		y30:   	sfixed(bits downto -bits);

			signal		yd1:   	sfixed(bits downto -bits);
			signal		yd2:   	sfixed(bits downto -bits);
			signal		yd3:   	sfixed(bits downto -bits);
			signal		yd4:   	sfixed(bits downto -bits);
			signal		yd5:   	sfixed(bits downto -bits);
			signal		yd6:   	sfixed(bits downto -bits);
			signal		yd7:   	sfixed(bits downto -bits);
			signal		yd8:   	sfixed(bits downto -bits);
			signal		yd9:   	sfixed(bits downto -bits);
			signal		yd10:   sfixed(bits downto -bits);
			signal		yd11:   sfixed(bits downto -bits);
			signal		yd12:   sfixed(bits downto -bits);
BEGIN 
    T1: Neuron PORT MAP (state,  y1,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya1, 4, 5, 0, 1,state(1  downto 0));
	T2: Neuron PORT MAP (state,  y2,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya2, 4, 5, 0, 2,state(3  downto 2));
	T3: Neuron PORT MAP (state,  y3,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya3, 4, 5, 0, 3,state(5  downto 4));
	T4: Neuron PORT MAP (state,  y4,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya4, 4, 5, 0, 4,state(7  downto 6));
	T5: Neuron PORT MAP (state,  y5,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya5, 4, 5, 0, 5,state(9  downto 8));
	T6: Neuron PORT MAP (state,  y6,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya6, 4, 5, 1, 0,state(11  downto 10));
	T7: Neuron PORT MAP (state,  y7,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya7, 4, 5, 1, 2,state(13  downto 12));
	T8: Neuron PORT MAP (state,  y8,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya8, 4, 5, 1, 3,state(15  downto 14));
	T9: Neuron PORT MAP (state,  y9,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst, ya9, 4, 5, 1, 4,state(17  downto 16));
   T10: Neuron PORT MAP (state,  y10, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya10, 4, 5, 1, 5,state(19  downto 18));	
   T11: Neuron PORT MAP (state,  y11, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya11, 4, 5, 2, 0,state(21  downto 20));
   T12: Neuron PORT MAP (state,  y12, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya12, 4, 5, 2, 1,state(23  downto 22));	
   T13: Neuron PORT MAP (state,  y13, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya13, 4, 5, 2, 3,state(25  downto 24));	
   T14: Neuron PORT MAP (state,  y14, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya14, 4, 5, 2, 4,state(27  downto 26));	
   T15: Neuron PORT MAP (state,  y15, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya15, 4, 5, 2, 5,state(29  downto 28));	
   T16: Neuron PORT MAP (state,  y16, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya16, 4, 5, 3, 0,state(31  downto 30));	
   T17: Neuron PORT MAP (state,  y17, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya17, 4, 5, 3, 1,state(33  downto 32));	
   T18: Neuron PORT MAP (state,  y18, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya18, 4, 5, 3, 2,state(35  downto 34));	
   T19: Neuron PORT MAP (state,  y19, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya19, 4, 5, 3, 4,state(37  downto 36));	
   T20: Neuron PORT MAP (state,  y20, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya20, 4, 5, 3, 5,state(39  downto 38));	
   T21: Neuron PORT MAP (state,  y21, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya21, 4, 5, 4, 0,state(41  downto 40));	
   T22: Neuron PORT MAP (state,  y22, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya22, 4, 5, 4, 1,state(43  downto 42));	
   T23: Neuron PORT MAP (state,  y23, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya23, 4, 5, 4, 2,state(45  downto 44));	
   T24: Neuron PORT MAP (state,  y24, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya24, 4, 5, 4, 3,state(47  downto 46));	
   T25: Neuron PORT MAP (state,  y25, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya25, 4, 5, 4, 5,state(49  downto 48));	
   T26: Neuron PORT MAP (state,  y26, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya26, 4, 5, 5, 0,state(51  downto 50));	
   T27: Neuron PORT MAP (state,  y27, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya27, 4, 5, 5, 1,state(53  downto 52));	
   T28: Neuron PORT MAP (state,  y28, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya28, 4, 5, 5, 2,state(55  downto 54));	
   T29: Neuron PORT MAP (state,  y29, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya29, 4, 5, 5, 3,state(57  downto 56));	
   T30: Neuron PORT MAP (state,  y30, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, clk, rst,ya30, 4, 5, 5, 4,state(59  downto 58));	
END manyNeural;