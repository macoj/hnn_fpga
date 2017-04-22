
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ieee_proposed;
USE ieee_proposed.fixed_pkg.all;

ENTITY Neuron IS 
GENERIC (  bits: 			INTEGER := 16;
			nodes:			INTEGER := 5;
			neurons: 		INTEGER := 5*(5-1) );
PORT ( 	state: 				INOUT 	bit_vector (2*neurons-1 DOWNTO 0);
			yout:  			OUT 	sfixed(bits DOWNTO -bits);
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
			clk:			IN 		STD_LOGIC;
			rst: 			IN 		STD_LOGIC;
			y:  			OUT 	bit;
			source: 		IN 		INTEGER;
			destination: 	IN 		INTEGER;
			tx:  			IN 		INTEGER;
			ty:  			IN 		INTEGER;
			nstate: 		INOUT bit_vector (1 DOWNTO 0)
	 );
END Neuron;

ARCHITECTURE Neuron OF Neuron IS 
	TYPE matrix 	IS ARRAY (0 TO nodes*nodes-1) OF sfixed(bits DOWNTO -bits);
	TYPE matrixBIT 	IS ARRAY (0 TO nodes*nodes-1) OF BIT;	

	CONSTANT s0 : bit_vector(2*neurons-1 DOWNTO 0) := "0000000000000000000000000000000000000000";
	CONSTANT s1 : bit_vector(2*neurons-1 DOWNTO 0) := "0101010101010101010101010101010101010101";
	CONSTANT s2 : bit_vector(2*neurons-1 DOWNTO 0) := "1010101010101010101010101010101010101010";
	CONSTANT s3 : bit_vector(2*neurons-1 DOWNTO 0) := "1111111111111111111111111111111111111111";
	
	CONSTANT threshold : sfixed(bits DOWNTO -bits) := to_sfixed (0.00010, bits,-bits);

	CONSTANT cost : matrix := (  
	to_sfixed (0, bits,-bits), to_sfixed (0.35, bits,-bits),  to_sfixed (0.4, bits,-bits), to_sfixed (0, bits,-bits), to_sfixed (0, bits,-bits), 
	to_sfixed (0.35, bits,-bits), to_sfixed (0, bits,-bits),  to_sfixed (0.6, bits,-bits), to_sfixed (0.8, bits,-bits), to_sfixed (0.9, bits,-bits),
	to_sfixed (0.4, bits,-bits), to_sfixed (0.6, bits,-bits),  to_sfixed (0, bits,-bits), to_sfixed (0.5, bits,-bits), to_sfixed (0.85, bits,-bits),
	to_sfixed (0, bits,-bits), to_sfixed (0.8, bits,-bits),  to_sfixed (0.5, bits,-bits), to_sfixed (0, bits,-bits), to_sfixed (0.3, bits,-bits), 
	to_sfixed (0, bits,-bits), to_sfixed (0.9, bits,-bits),  to_sfixed (0.85, bits,-bits), to_sfixed (0.3, bits,-bits), to_sfixed (0, bits,-bits)
	);
								
	CONSTANT arc : matrixBIT := ( '0', '1', '1', '0', '0', 
								  '1', '0', '1', '1', '1', 
								  '1', '1', '0', '1', '1', 
								  '0', '1', '1', '0', '1', 
								  '0', '1', '1', '1', '0'
								  );
							
	CONSTANT A   : sfixed(bits DOWNTO -bits) := to_sfixed (0.001	,bits,-bits);
	CONSTANT B   : sfixed(bits DOWNTO -bits) := to_sfixed (0.001	,bits,-bits);
	CONSTANT C   : sfixed(bits DOWNTO -bits) := to_sfixed (0.001	,bits,-bits);
	
	CONSTANT mi1 : sfixed(bits DOWNTO -bits) := to_sfixed (950.0	,bits,-bits);
	CONSTANT mi1d2 : sfixed(bits DOWNTO -bits) := to_sfixed (475.0	,bits,-bits);
	
	CONSTANT mi2 : sfixed(bits DOWNTO -bits) := to_sfixed (2500.0	,bits,-bits);
	CONSTANT mi2d2 : sfixed(bits DOWNTO -bits) := to_sfixed (1250.0	,bits,-bits);
	
	CONSTANT mi3 : sfixed(bits DOWNTO -bits) := to_sfixed (2500.0	,bits,-bits);
	
	CONSTANT mi4 : sfixed(bits DOWNTO -bits) := to_sfixed (475.0	,bits,-bits);
	CONSTANT mi4d2 : sfixed(bits DOWNTO -bits) := to_sfixed (237.5	,bits,-bits);
	
	CONSTANT mi5 : sfixed(bits DOWNTO -bits) := to_sfixed (2500.0	,bits,-bits);
	CONSTANT mi5d2 : sfixed(bits DOWNTO -bits) := to_sfixed (1250.0	,bits,-bits);	
	
	
	
	
BEGIN

	PROCESS (clk)
		-- ### FUNCOES ###pe
		-- pesos gerados on demand 
		FUNCTION weight(i, j, k, l: INTEGER) RETURN sfixed IS
			VARIABLE acc : sfixed(bits+1 DOWNTO -bits);
			VARIABLE A : sfixed(bits DOWNTO -bits);
			VARIABLE B : sfixed(bits DOWNTO -bits);
		BEGIN
			acc := (OTHERS => '0');
			
			IF (i = k AND j = l) THEN			-- OK
				acc := acc(bits DOWNTO -bits) + mi4;
			END IF;
			
			IF (i = k) THEN						-- OK
				acc := acc(bits DOWNTO -bits) - mi3;
			END IF;
			
			IF (j = l) THEN						-- OK
				acc := acc(bits DOWNTO -bits) - mi3;
			END IF;
			
			IF (i = l) THEN						-- OK
				acc := acc(bits DOWNTO -bits) + mi3;
			END IF;

			IF (j = k) THEN						-- OK
				acc := acc(bits DOWNTO -bits) + mi3;
			END IF;
			
			RETURN acc(bits DOWNTO -bits);
		END weight;

		-- transforma valor (i,j) em um indice
		FUNCTION index(i,j: INTEGER) return INTEGER IS
		BEGIN
			RETURN (i*nodes + j);
		END index;
		
		-- sigmoid1
		FUNCTION sigmoid(input : sfixed) RETURN sfixed IS
			VARIABLE acc   : sfixed(bits+1 DOWNTO -bits);
			VARIABLE Ax   : sfixed(bits DOWNTO -bits);
			VARIABLE Bx   : sfixed(bits DOWNTO -bits);
			VARIABLE prod  : sfixed(2*bits+1   DOWNTO -bits*2);
		BEGIN
--			IF (input < to_sfixed (-4.000000, bits,-bits)) THEN
--				RETURN to_sfixed (0.0, bits,-bits);
--			 ELSIF (input < to_sfixed (-3.500000, bits,-bits)) THEN
--				RETURN to_sfixed (0.029312, bits,-bits);
--			 ELSIF (input < to_sfixed (-3.000000, bits,-bits)) THEN
--				RETURN to_sfixed (0.047426, bits,-bits);
--			 ELSIF (input < to_sfixed (-2.500000, bits,-bits)) THEN
--				RETURN to_sfixed (0.075858, bits,-bits);
--			 ELSIF (input < to_sfixed (-2.000000, bits,-bits)) THEN
--				RETURN to_sfixed (0.119203, bits,-bits);
--			 ELSIF (input < to_sfixed (-1.500000, bits,-bits)) THEN
--				RETURN to_sfixed (0.182426, bits,-bits);
--			 ELSIF (input < to_sfixed (-1.000000, bits,-bits)) THEN
--				RETURN to_sfixed (0.268941, bits,-bits);
--			 ELSIF (input < to_sfixed (-0.500000, bits,-bits)) THEN
--				RETURN to_sfixed (0.377541, bits,-bits);
--			 ELSIF (input < to_sfixed (0.000000, bits,-bits)) THEN
--				RETURN to_sfixed (0.500000, bits,-bits);
--			 ELSIF (input < to_sfixed (0.500000, bits,-bits)) THEN
--				RETURN to_sfixed (0.622459, bits,-bits);
--			 ELSIF (input < to_sfixed (1.000000, bits,-bits)) THEN
--				RETURN to_sfixed (0.731059, bits,-bits);
--			 ELSIF (input < to_sfixed (1.500000, bits,-bits)) THEN
--				RETURN to_sfixed (0.817575, bits,-bits);
--			 ELSIF (input < to_sfixed (2.000000, bits,-bits)) THEN
--				RETURN to_sfixed (0.880797, bits,-bits);
--			 ELSIF (input < to_sfixed (2.500000, bits,-bits)) THEN
--				RETURN to_sfixed (0.924142, bits,-bits);
--			 ELSIF (input < to_sfixed (3.000000, bits,-bits)) THEN
--				RETURN to_sfixed (0.952574, bits,-bits);
--			 ELSIF (input < to_sfixed (3.500000, bits,-bits)) THEN
--				RETURN to_sfixed (0.970688, bits,-bits);
--			 ELSE
--				RETURN to_sfixed (1.0, bits,-bits);
--			END IF;	
			
			IF (input >= to_sfixed (5.000000, bits,-bits)) THEN
				RETURN to_sfixed (1, bits,-bits);
			 ELSIF (input >= to_sfixed (2.375000, bits,-bits)) THEN
				Ax := to_sfixed (0.03125, bits,-bits);
				Bx := to_sfixed (0.84375, bits,-bits);
			 ELSIF (input >= to_sfixed (1.000000, bits,-bits)) THEN
				Ax := to_sfixed (0.125, bits,-bits);
				Bx := to_sfixed (0.625, bits,-bits);
			 ELSIF (input > to_sfixed (-1.00000, bits,-bits)) THEN
				Ax := to_sfixed (0.25, bits,-bits);
				Bx := to_sfixed (0.5, bits,-bits);
			 ELSIF (input >= to_sfixed (-2.375000, bits,-bits)) THEN
				Ax := to_sfixed (0.125, bits,-bits);
				Bx := to_sfixed (0.375, bits,-bits);
			 ELSIF (input >= to_sfixed (-5.00000, bits,-bits)) THEN
				Ax := to_sfixed (0.03125, bits,-bits);
				Bx := to_sfixed (0.15625, bits,-bits);
			ELSE
				RETURN to_sfixed (0, bits,-bits);
			END IF;
			
			prod := input*Ax;
			acc := prod(bits DOWNTO -bits) + Bx;
			
			RETURN acc(bits DOWNTO -bits);
		END sigmoid;
		
		-- calcula o bias
		FUNCTION bias(x, y, source, destination: INTEGER) RETURN sfixed IS
			VARIABLE acc   : sfixed(bits+1 DOWNTO -bits);
			VARIABLE prod  : sfixed(2*bits+1   DOWNTO -bits*2);
			VARIABLE idx : INTEGER;
		BEGIN
			acc := (OTHERS => '0');
			idx := index(y, x); 

			IF (not (y = destination AND x = source)) THEN
				IF (arc(idx) = '1') THEN
					prod := mi1d2*cost(idx);
					acc := acc(bits DOWNTO -bits) - prod(bits DOWNTO -bits);
				ELSE
					acc := acc(bits DOWNTO -bits) - mi2d2 ;
				END IF;	
			END IF;

			acc := acc(bits DOWNTO -bits) - mi4d2;
			
			IF (y = destination AND x = source) THEN
				acc := acc(bits DOWNTO -bits) + mi5d2;		
			END IF;

			RETURN acc(bits DOWNTO -bits);
		END bias;
		
		FUNCTION mux(index : INTEGER range 0 to nodes*(nodes); y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17,y18,y19,y20 : sfixed) RETURN sfixed IS
		BEGIN
			CASE index IS	
				WHEN 1 => RETURN y1;	-- (0,1)
				WHEN 2 => RETURN y2;	-- (0,2)
				WHEN 3 => RETURN y3;	-- (0,3)
				WHEN 4 => RETURN y4;	-- (0,4)
				WHEN 5 => RETURN y5;	-- (1,0)
				WHEN 7 => RETURN y6;	-- (1,2)
				WHEN 8 => RETURN y7;	-- (1,3)
				WHEN 9 => RETURN y8;	-- (1,4)
				WHEN 10=> RETURN y9;	-- (2,0)
				WHEN 11=> RETURN y10;	-- (2,1)
				WHEN 13=> RETURN y11;	-- (2,3)
				WHEN 14=> RETURN y12;	-- (2,4)
				WHEN 15=> RETURN y13;	-- (3,0)
				WHEN 16=> RETURN y14;	-- (3,1)
				WHEN 17=> RETURN y15;	-- (3,2)
				WHEN 19=> RETURN y16;	-- (3,4)
				WHEN 20=> RETURN y17;	-- (4,0)
				WHEN 21=> RETURN y18;	-- (4,1)
				WHEN 22=> RETURN y19;	-- (4,2)
				WHEN 23=> RETURN y20;	-- (4,3)			
				WHEN OTHERS => RETURN to_sfixed (0, bits, -bits);
			END CASE;
		END mux;
				
		-- ### VARIAVEIS LOCAIS ###
		VARIABLE input : sfixed(bits DOWNTO -bits);
		VARIABLE output: sfixed(bits DOWNTO -bits);
		
		VARIABLE inputOLD: sfixed(bits DOWNTO -bits);
		VARIABLE inputOLD2: sfixed(bits DOWNTO -bits);
		VARIABLE outputOLD: sfixed(bits DOWNTO -bits);
		
		VARIABLE sum : sfixed(bits DOWNTO -bits);
		VARIABLE biasv : sfixed(bits DOWNTO -bits);

		VARIABLE acc   : sfixed(bits+1 DOWNTO -bits);
		VARIABLE prod  : sfixed(2*bits+1   DOWNTO -bits*2);
	
		VARIABLE prodA: sfixed(bits DOWNTO -bits);
		VARIABLE prodB: sfixed(bits DOWNTO -bits);
		
		VARIABLE csum   : sfixed(2*bits+1+1 DOWNTO -bits*2);
		
		VARIABLE calcsum: INTEGER;	
		VARIABLE itera : INTEGER;
		VARIABLE etapa : INTEGER;

	BEGIN 		
		IF (clk'EVENT AND clk = '1')	THEN
			-- RESET
			IF (rst = '1') THEN			
				nstate <= "00";
				input := to_sfixed (0	,bits,-bits); 
				inputOLD := input;
				inputOLD2 := input;
						
				-- calcula a saida inicial
				output := to_sfixed (0.5	,bits,-bits);
				yout <= output;
				
				csum := (OTHERS => '0');	
				calcsum := 0;
				etapa := 0;
				y <= '0';
				--itera := 0;
			ELSIF (state = s0) THEN		
				-- ESTADO s0: calcula o novo input do neuronio
				IF (calcsum < nodes) THEN
					-- calcula o somatorio
					prodA := (OTHERS=>'0');
					prodB := (OTHERS=>'0');
					
					-- somatorio n
--					IF (etapa = 0) THEN
--						-- (ty!=l)*(weight(ty, tx, ty, l) * outputShared[ty*nodes + l]) 
--						IF (calcsum /= tx) THEN	
--							prodA :=  weight(tx, ty, tx, calcsum);
--							prodB := mux(index(tx,calcsum), y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,y16,y17,y18,y19,y20);
--						END IF;	
--						etapa := 1;
--					ELSIF (etapa = 1) THEN
--						-- (ty!=l)(tx!=l)*(weight(ty, tx, l, tx) * outputShared[l*nodes + tx])
--						IF ((calcsum /= tx) AND (calcsum /= ty)) THEN
--							prodA :=  weight(tx, ty, calcsum, ty);
--							prodB := mux(index(calcsum,ty), y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12,y13,y14,y15,y16,y17,y18,y19,y20);
--						END IF;
--						etapa := 2;
--					ELSIF (etapa = 2) THEN
--						-- (ty!=l)(tx!=l)*(weight(ty, tx, l, ty) * outputShared[l*nodes + ty])
--						IF ((calcsum /= tx) AND (calcsum /= ty)) THEN
--							prodA :=  weight(tx, ty, calcsum, tx);
--							prodB := mux(index(calcsum, tx), y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12,y13,y14,y15,y16,y17,y18,y19,y20);
--						END IF;
--						etapa := 3;
--					ELSE
--						-- (tx!=l)*weight(ty, tx, tx, l) * outputShared[tx*nodes + l];
--						IF (calcsum /= ty) THEN
--							prodA :=  weight(tx, ty, ty, calcsum);
--							prodB := mux(index(ty, calcsum), y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12,y13,y14,y15,y16,y17,y18,y19,y20);
--						END IF;
--						etapa := 0;
--					END IF;		
--					
--					IF (etapa = 0) THEN
--						calcsum := calcsum + 1;
--					END IF;
					--

					-- somatorio n*n
					IF (calcsum /= etapa) THEN 
						prodA := weight(tx, ty, calcsum, etapa);
						prodB := mux(index(calcsum, etapa), y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12,y13,y14,y15,y16,y17,y18,y19,y20);
					END IF;

					etapa := etapa + 1;
					
					IF (etapa = nodes) THEN
						calcsum := calcsum + 1;
						etapa := 0;
					END IF;
					--

					prod := prodA*prodB;
					csum := prod + csum(2*bits+1 DOWNTO -bits*2);	
				ELSE
					
					biasv := bias(ty, tx, source, destination);	
								
					calcsum := 0;
					sum := csum(bits DOWNTO -bits);
					csum := (OTHERS => '0');		
								
					-- atualiza o input (local) -- input[index] = input[index] - A*inputOld2[index] + B*sum + C*bias[index];
					acc := (OTHERS => '0');
					acc := acc(bits DOWNTO -bits) + input;
					
					prod := A*inputOLD2;
					acc := acc(bits DOWNTO -bits) - prod(bits DOWNTO -bits);
					
					prod := B*sum;
					acc := acc(bits DOWNTO -bits) + prod(bits DOWNTO -bits);
										
					prod := C*biasv;
					acc := acc(bits DOWNTO -bits) + prod(bits DOWNTO -bits);
										
					-- atualiza o passado
					inputOLD2 := inputOLD;
					inputOLD := input; 
								
					-- atualiza o input
					input := acc(bits DOWNTO -bits);
					
					-- muda de estado
					nstate <= "01";
				END IF;
			ELSIF (state = s1) THEN	
				-- ESTADO s1: atualiza a saida do neuronio e checa se alcancou a convergencia		
				-- calcula a saida		
				
				outputOLD := output;
				output := sigmoid(input);
				-- atualiza a saida
				yout <= output;

				-- faz a diferenca da saida calculada e a saida atual
				acc := outputOLD - output;
				IF (acc(bits DOWNTO -bits) > threshold) THEN
					nstate <= "11";	
				ELSE
					nstate <= "10"; -- 101010 s2
				END IF;				
			ELSIF (state = s2) THEN
				-- ESTADO s2: todos os neuronios convergiram
				IF (output >= sigmoid(to_sfixed (0,bits,-bits))) THEN
					y <= '1';
				ELSE
					y <= '0';
				END IF;
				nstate <= "00";		
			ELSIF (state = s3) THEN
				-- ESTADO s3: nenhum convergiu
				nstate <= "00";		
			ELSE
				-- estado indefinido de possivel estagnacao
				nstate <= "00";							
			END IF;	
		END IF;
	END PROCESS;
END Neuron;
