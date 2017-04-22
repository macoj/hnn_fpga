LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ieee_proposed;
USE ieee_proposed.fixed_pkg.all;

USE work.my_components.all;

ENTITY ManyNeuralNetworks IS 
GENERIC (	bits: 		INTEGER := 16;
			nodes:		INTEGER := 4;
			neurons: 	INTEGER := 4*(4 - 1)  );
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
		ya12: OUT bit
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
    T1: Neuron PORT MAP (state,  y1,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya1, 0, 3, 0, 1, state(1  downto 0));
	T2: Neuron PORT MAP (state,  y2,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya2, 0, 3, 0, 2, state(3  downto 2));
	T3: Neuron PORT MAP (state,  y3,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya3, 0, 3, 0, 3, state(5  downto 4));
	
	T4: Neuron PORT MAP (state,  y4,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya4, 0, 3, 1, 0, state(7  downto 6));
	T5: Neuron PORT MAP (state,  y5,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya5, 0, 3, 1, 2, state(9  downto 8));
	T6: Neuron PORT MAP (state,  y6,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya6, 0, 3, 1, 3, state(11  downto 10));
	
	T7: Neuron PORT MAP (state,  y7,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya7, 0, 3, 2, 0, state(13  downto 12));
	T8: Neuron PORT MAP (state,  y8,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya8, 0, 3, 2, 1, state(15  downto 14));
	T9: Neuron PORT MAP (state,  y9,  y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst, ya9, 0, 3, 2, 3, state(17  downto 16));
	
   T10: Neuron PORT MAP (state,  y10, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst,ya10, 0, 3, 3, 0, state(19  downto 18));	
   T11: Neuron PORT MAP (state,  y11, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst,ya11, 0, 3, 3, 1, state(21  downto 20));
   T12: Neuron PORT MAP (state,  y12, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, clk, rst,ya12, 0, 3, 3, 2, state(23  downto 22));	
END manyNeural;
