
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ieee_proposed;
USE ieee_proposed.fixed_pkg.all;
--USE ieee_proposed.standard_textio_additions.all;

ENTITY NeuralNetworks IS 
GENERIC ( 	n: INTEGER := 3;
			m: INTEGER := 3;
			b: INTEGER := 8);
PORT ( 	x1: IN sfixed(8 downto -8);
		x2: IN sfixed(8 downto -8);
		x3: IN sfixed(8 downto -8);
		clk: IN STD_LOGIC;
		y1: OUT sfixed(2*8+1+1 downto -8*2);
		y2: OUT sfixed(2*8+1+1 downto -8*2);
		y3: OUT sfixed(2*8+1+1 downto -8*2)
	 );
END NeuralNetworks;

ARCHITECTURE NeuralNetworks OF NeuralNetworks IS 
	TYPE weights IS ARRAY (1 TO n*m) OF sfixed(8 downto -8);
	TYPE inputs  IS ARRAY (1 TO  m ) OF sfixed(8 downto -8);
	TYPE outputs IS ARRAY (1 TO  m ) OF sfixed(2*8+1+1 downto -8*2);
	CONSTANT memory : weights := (  "00000000010000000",
									"00000000010000000",
									"00000000010000000",
									
									"00000010010000000",
									"00000010010000000",
									"00000010000000000",
									
									"00000000110000000",
									"00000000100000000",
									"00000000110000000");
BEGIN 
	PROCESS (clk, x1, x2, x3)
		VARIABLE weight: weights;
		VARIABLE input: inputs;
		VARIABLE output: outputs;
		VARIABLE prod, t: sfixed(2*8+1 downto -8*2);
		VARIABLE acc, acc2: sfixed(2*8+1+1 downto -8*2);
		VARIABLE sign: STD_LOGIC;
	BEGIN 
		IF (clk'EVENT AND clk='1') THEN
			weight := memory (1 TO n*m);
		END IF;
		input(1) := x1;
		input(2) := x2;
		input(3) := x3;
		L1: FOR i IN 1 TO n LOOP
			acc := (OTHERS => '0');
			L2: FOR j IN 1 TO m LOOP
				prod := input(j)*weight(m*(i-1) + j);
				sign := acc(acc'LEFT);
				--acc2 := ('0' & prod);
				acc := prod + acc(2*8+1 downto -8*2);
				--IF (sign=prod(prod'LEFT)) AND (acc(acc'LEFT) /= sign) THEN 
				--	acc := (acc'LEFT => sign, OTHERS => NOT sign);
				--END IF;
			END LOOP L2;
			output(i) := acc;
		--	report "Result was " & real'image(to_real(acc));
		END LOOP L1;
		y1 <= output (1);
		y2 <= output (2);
		y3 <= output (3);
	END PROCESS;
END NeuralNetworks;