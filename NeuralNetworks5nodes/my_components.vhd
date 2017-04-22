LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ieee_proposed;
USE ieee_proposed.fixed_pkg.all;

PACKAGE my_components IS
	COMPONENT NeuralNetworks IS
		PORT ( 	x1: IN sfixed(8 downto -8);
				x2: IN sfixed(8 downto -8);
				x3: IN sfixed(8 downto -8);
				clk: IN STD_LOGIC;
				y1: OUT sfixed(2*8+1+1 downto -8*2);
				y2: OUT sfixed(2*8+1+1 downto -8*2);
				y3: OUT sfixed(2*8+1+1 downto -8*2)
			);	
	END COMPONENT;
	
	COMPONENT Neuron IS
	    GENERIC ( 	bits: 		INTEGER := 16; 
					nodes:		INTEGER := 5;
					neurons: 	INTEGER := 5*(5-1)
				    );
		PORT ( 	
					state: 		INOUT 	bit_vector (2*neurons-1 downto 0);
					yout:  		OUT 	sfixed(bits downto -bits);
					y1:   		IN  	sfixed(bits downto -bits);
					y2:   		IN  	sfixed(bits downto -bits);
					y3:   		IN  	sfixed(bits downto -bits);
					y4:   		IN  	sfixed(bits downto -bits);
					y5:   		IN  	sfixed(bits downto -bits);
					y6:   		IN  	sfixed(bits downto -bits);
					y7:   		IN  	sfixed(bits downto -bits);
					y8:   		IN  	sfixed(bits downto -bits);
					y9:   		IN  	sfixed(bits downto -bits);
					y10:   		IN  	sfixed(bits downto -bits);
					y11:   		IN  	sfixed(bits downto -bits);
					y12:   		IN  	sfixed(bits downto -bits);
					y13:   		IN  	sfixed(bits downto -bits);
					y14:   		IN  	sfixed(bits downto -bits);
					y15:   		IN  	sfixed(bits downto -bits);
					y16:   		IN  	sfixed(bits downto -bits);
					y17:   		IN  	sfixed(bits downto -bits);
					y18:   		IN  	sfixed(bits downto -bits);
					y19:   		IN  	sfixed(bits downto -bits);
					y20:   		IN  	sfixed(bits downto -bits);
					clk: 		IN 		STD_LOGIC;
					rst: 		IN 		STD_LOGIC;
					y:   		OUT 	bit;
					source: 	IN 		INTEGER;
					destination:IN 		INTEGER;
					tx:  		IN 		INTEGER;
					ty:  		IN 		INTEGER;
					nstate:  	INOUT 	bit_vector (1 downto 0)
			 );
	END COMPONENT;
END my_components;