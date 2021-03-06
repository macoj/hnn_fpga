
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ieee_proposed;
USE ieee_proposed.fixed_pkg.all;

ENTITY Neuron IS 
GENERIC (  bits: 		INTEGER := 16;
			nodes:		INTEGER := 4;
			neurons: 	INTEGER := 4*(4-1) );
PORT ( 	state: 			INOUT 	bit_vector (2*neurons-1 downto 0);
		inputs: 		IN 		std_logic_vector(((2*bits+1)*neurons-1) downto 0);
		owninput:  		OUT 	std_logic_vector(2*bits downto 0);
		outputs: 		IN 		std_logic_vector(((2*bits+1)*neurons-1) downto 0);
		ownoutput:  	OUT 	std_logic_vector(2*bits downto 0);
		clk: 			IN 		STD_LOGIC;
		rst: 			IN 		STD_LOGIC;
	--	y:  			OUT 	sfixed(bits downto -bits);
		y:  			OUT 	bit;
		source: 		IN 		INTEGER;
		destination: 	IN 		INTEGER;
		i:  			IN 		INTEGER;
		j:  			IN 		INTEGER;
		nstate:  OUT bit_vector (1 downto 0)
	 );
END Neuron;

ARCHITECTURE Neuron OF Neuron IS 
	TYPE matrix 	IS ARRAY (1 TO nodes*nodes) OF sfixed(bits downto -bits);
	TYPE matrixBIT 	IS ARRAY (1 TO nodes*nodes) OF BIT;	
	TYPE sigLUT 	IS ARRAY (1 TO 25) OF sfixed(bits downto -bits);
	CONSTANT s0 : bit_vector(2*neurons-1 downto 0) := "000000000000000000000000";
	CONSTANT s1 : bit_vector(2*neurons-1 downto 0) := "010101010101010101010101";
	CONSTANT s2 : bit_vector(2*neurons-1 downto 0) := "101010101010101010101010";
	
	--CONSTANT s0 : bit_vector(2*neurons-1 downto 0) := "000000000000";
	--CONSTANT s1 : bit_vector(2*neurons-1 downto 0) := "010101010101";
	--CONSTANT s2 : bit_vector(2*neurons-1 downto 0) := "101010101010";
	           

--	CONSTANT sig : sigLUT ( to_sfixed (0, bits,-bits),
--							to_sfixed (0.002473, bits,-bits),
--							to_sfixed (0.006693, bits,-bits),
--							to_sfixed (0.017986, bits,-bits),
--							to_sfixed (0.047426, bits,-bits),
--							to_sfixed (0.119203, bits,-bits),
--							to_sfixed (0.268941, bits,-bits),
--							to_sfixed (0.500000, bits,-bits),
--							to_sfixed (0.731059, bits,-bits),
--							to_sfixed (0.880797, bits,-bits),
--							to_sfixed (0.952574, bits,-bits),
--							to_sfixed (0.982014, bits,-bits),						
--							to_sfixed (0.993307, bits,-bits),
--							to_sfixed (1.0, bits,-bits)
--							);
	
	CONSTANT threshold : sfixed(bits downto -bits) := to_sfixed (0.0001	,bits,-bits);

	CONSTANT cost : matrix := (  to_sfixed (0, bits,-bits),   to_sfixed (0.2, bits,-bits),  to_sfixed (0.3, bits,-bits), to_sfixed (0, bits,-bits),
								 to_sfixed (0.2, bits,-bits), to_sfixed (0, bits,-bits),    to_sfixed (0.1, bits,-bits), to_sfixed (0.3, bits,-bits),
								 to_sfixed (0.3, bits,-bits), to_sfixed (0.1, bits,-bits),  to_sfixed (0, bits,-bits),   to_sfixed (0.1, bits,-bits),
								 to_sfixed (0, bits,-bits),   to_sfixed (0.3, bits,-bits),  to_sfixed (0.1, bits,-bits), to_sfixed (0, bits,-bits)
								);
									
	--CONSTANT cost : matrix := (  to_sfixed (0, bits,-bits),   to_sfixed (0.2, bits,-bits),  to_sfixed (0.3, bits,-bits), 
--								 to_sfixed (0.2, bits,-bits), to_sfixed (0, bits,-bits),    to_sfixed (0.1, bits,-bits), 
--								 to_sfixed (0.3, bits,-bits), to_sfixed (0.1, bits,-bits),  to_sfixed (0, bits,-bits)
--								);
									
	CONSTANT arc : matrixBIT := ( '0', '1', '1', '0',
								  '1', '0', '1', '1',
								  '1', '1', '0', '1',
								  '0', '1', '1', '0' 
								  );
				 
--	CONSTANT arc : matrixBIT := ( '0', '1', '1', 
--								  '1', '0', '1', 
--								  '1', '1', '0' 
--								  );
				 
	CONSTANT A   : sfixed(bits downto -bits) := to_sfixed (0.001	,bits,-bits);
	CONSTANT B   : sfixed(bits downto -bits) := to_sfixed (0.001	,bits,-bits);
	CONSTANT C   : sfixed(bits downto -bits) := to_sfixed (0.001	,bits,-bits);
	CONSTANT mi1 : sfixed(bits downto -bits) := to_sfixed (950.0	,bits,-bits);
	CONSTANT mi2 : sfixed(bits downto -bits) := to_sfixed (2500.0	,bits,-bits);
	CONSTANT mi3 : sfixed(bits downto -bits) := to_sfixed (2500.0	,bits,-bits);
	CONSTANT mi4 : sfixed(bits downto -bits) := to_sfixed (475.0	,bits,-bits);
	CONSTANT mi5 : sfixed(bits downto -bits) := to_sfixed (2500.0	,bits,-bits);
	
BEGIN
			--- ######## LEMBRAR:
			------- tx, ty podem estar com problemas
	PROCESS (clk)
		-- ### FUNCOES ###pe
		-- pesos gerados on demand ############################ problema de sinais?
		FUNCTION weight(i, j, k, l: INTEGER) RETURN sfixed IS
			VARIABLE acc : sfixed(bits+1 downto -bits);
		BEGIN
			acc := (OTHERS => '0');
			
			-- mi4 * (i==k) * (j==l) - mi3 2500.0 * (i==k) - mi3 * (j==l) + mi3 * (l==i) + mi3 * (j==k);
			IF (i = k AND j = l) THEN
				acc := resize(acc, bits, -bits) + mi4;
			END IF;
			
			IF (i = k) THEN
				acc := resize(acc, bits, -bits) - mi3;
			END IF;
			
			IF (j = l) THEN
				acc := resize(acc, bits, -bits) - mi3;
			END IF;
			
			IF (i = l) THEN
				acc := resize(acc, bits, -bits) + mi3;
			END IF;
			
			IF (j = k) THEN
				acc := resize(acc, bits, -bits) + mi3;
			END IF;
			
			RETURN resize(acc, bits, -bits);
		END weight;
		-- valor do input baseado no std_logic_vector
		FUNCTION neuronInput(index: INTEGER; neuronsInput: std_logic_vector(((2*bits+1)*neurons-1) downto 0)) RETURN sfixed IS
				VARIABLE inputSTD : std_logic_vector(2*bits downto 0);
				VARIABLE inputSFIXED: sfixed(bits downto -bits);
				VARIABLE n : INTEGER;
		BEGIN
				n := 0;
--				IF (index = 1) THEN
--					n := 1;
--				ELSIF (index = 2)  THEN
--					n := 2;
--				ELSIF (index = 3)  THEN
--					n := 3;
--				ELSIF (index = 4)  THEN
--					n := 4;
--				ELSIF (index = 5)  THEN
--					n := 5;
--				ELSIF (index = 6)  THEN
--					n := 6;
--				ELSIF (index = 7)  THEN
--					n := 7;
--				ELSIF (index = 8)  THEN
--					n := 8;
--				ELSIF (index = 9)  THEN
--					n := 9;
--				ELSIF (index = 10)  THEN
--					n := 10;
--				ELSIF (index = 11)  THEN
--					n := 11;
--				ELSIF (index = 12)  THEN
--					n := 12;
--					
--				END IF;
		
				inputSTD := neuronsInput (((n+1)*(2*bits+1) - 1) DOWNTO ((n+1)*(2*bits+1) - (2*bits + 1)));
				inputSFIXED := to_sfixed(inputSTD, bits*2, 0);
			RETURN inputSFIXED;
		END neuronInput;	
		-- transforma valor (i,j) em um indice
		FUNCTION index(i,j: INTEGER) return INTEGER IS
		BEGIN
			RETURN (i*nodes + j);
		END index;
		-- calculate sum 
		-- sigmoid1
		FUNCTION sigmoid(input : sfixed) RETURN sfixed IS
			VARIABLE acc   : sfixed(bits+1 downto -bits);
			VARIABLE prod  : sfixed(2*bits+1   downto -bits*2);
		BEGIN
		    --RETURN to_sfixed (0.50, bits,-bits);
			IF (input < to_sfixed (-6, bits,-bits)) THEN
				RETURN to_sfixed (0, bits,-bits);
			ELSIF (input < to_sfixed (-5, bits,-bits)) THEN	
				RETURN to_sfixed (0.00, bits,-bits);
			ELSIF (input < to_sfixed (-4, bits,-bits)) THEN	
				RETURN to_sfixed (0.00, bits,-bits);
			ELSIF (input < to_sfixed (-3, bits,-bits)) THEN	
				RETURN to_sfixed (0.01, bits,-bits);
			ELSIF (input < to_sfixed (-2, bits,-bits)) THEN	
				RETURN to_sfixed (0.04, bits,-bits);
			ELSIF (input < to_sfixed (-1, bits,-bits)) THEN	
				RETURN to_sfixed (0.11, bits,-bits);
			ELSIF (input < to_sfixed (0, bits,-bits)) THEN	
				RETURN to_sfixed (0.26, bits,-bits);
			ELSIF (input < to_sfixed (1, bits,-bits)) THEN	
				RETURN to_sfixed (0.50, bits,-bits);
			ELSIF (input < to_sfixed (2, bits,-bits)) THEN	
				RETURN to_sfixed (0.73, bits,-bits);
			ELSIF (input < to_sfixed (3, bits,-bits)) THEN	
				RETURN to_sfixed (0.88, bits,-bits);
			ELSIF (input < to_sfixed (4, bits,-bits)) THEN	
				RETURN to_sfixed (0.95, bits,-bits);
			ELSIF (input < to_sfixed (5, bits,-bits)) THEN	
				RETURN to_sfixed (0.98, bits,-bits);		
			ELSIF (input < to_sfixed (6, bits,-bits)) THEN					
				RETURN to_sfixed (0.99, bits,-bits);
			ELSE
				RETURN to_sfixed (1.0, bits,-bits);
			END IF;
--		    prod := input(bits downto -bits)*to_sfixed(0.5,bits,-bits);
--		    acc  :=  1 +  prod(bits downto -bits);
--		    prod := to_sfixed(0.5,bits,-bits) * acc(bits downto -bits);
--			IF (prod > to_sfixed(1.0,bits,-bits)) THEN 
--				RETURN to_sfixed(0.5,bits,-bits);
--			ELSIF (prod < to_sfixed(0,bits,-bits)) THEN
--				RETURN to_sfixed(0,bits,-bits);
--			ELSE
				--RETURN prod(bits downto -bits);
--			END IF;
		END sigmoid;
		-- calcula o bias
		FUNCTION bias(i, j, source, destination: INTEGER) RETURN sfixed IS
			VARIABLE acc   : sfixed(bits+1 downto -bits);
			VARIABLE prod  : sfixed(2*bits+1   downto -bits*2);
		BEGIN
			acc := (OTHERS => '0');
			
			-- - mi1/2*custo - mi2*arco
			IF (not (j = destination AND i = source)) THEN
				-- - mi1/2*custo
				prod := mi1*to_sfixed(0.5,bits,-bits);
				prod := prod(bits downto -bits)*cost(index(i,j));
				acc := resize(acc, bits, -bits) - prod(bits downto -bits) ;
				-- - mi1/2*arcos
				IF (cost(index(i,j)) /= to_sfixed(0,bits,-bits)) THEN
					prod := mi2*to_sfixed(0.5,bits,-bits);
					acc := resize(acc, bits, -bits) - prod(bits downto -bits) ;
				END IF;
			END IF;

			-- - mi4/2
			prod := mi4*to_sfixed(0.5,bits,-bits);
			acc := resize(acc, bits, -bits) - prod(bits downto -bits);
			
			-- -mi5/2
			IF (j = destination AND i = source) THEN
				prod := mi5*to_sfixed(0.5,bits,-bits);
				acc := resize(acc, bits, -bits) + prod(bits downto -bits);		
			END IF;
			
			RETURN acc (bits DOWNTO -bits);
		END bias;
		
		-- ### VARIAVEIS LOCAIS ###
		VARIABLE input : sfixed(bits downto -bits);
		VARIABLE output: sfixed(bits downto -bits);
		
		VARIABLE inputOLD: sfixed(bits downto -bits);
		VARIABLE outputOLD: sfixed(bits downto -bits);
		
		VARIABLE sum : sfixed(bits downto -bits);
		VARIABLE biasv : sfixed(bits downto -bits);

		VARIABLE prod  : sfixed(2*bits+1   downto -bits*2);
		VARIABLE prod2  : sfixed(2*bits+1   downto -bits*2);
		VARIABLE acc   : sfixed(bits+1 downto -bits);
		
		VARIABLE temp  : std_logic_vector(2*bits downto 0);
		VARIABLE teste : sfixed(bits+1 downto -bits);
		VARIABLE teste2: sfixed(bits downto -bits);
		
		VARIABLE csum   : sfixed(2*bits+1+1 downto -bits*2);
		
		VARIABLE calcsum: INTEGER;
		
		VARIABLE itera : INTEGER;
	BEGIN 		
		IF (clk'EVENT AND clk = '1')	THEN
			-- RESET
			IF (rst = '1') THEN
				nstate <= "00";
				input := to_sfixed (0.5	,bits,-bits); -- valor inicial de um neuronio eh 0.5
				owninput <= to_std_logic_vector(input);
				inputOLD := input;
				
				-- calcula a saida inicial
				--output := sigmoid(-input);
				output := to_sfixed (0.5	,bits,-bits);
				ownoutput <= to_std_logic_vector(output);
				
				-- calcula o bias
				biasv := bias(i, j, source, destination);
				
				acc := (OTHERS => '0');				
				csum := (OTHERS => '0');	
				calcsum := 0;
				itera := 0;
			ELSIF (state = s0) THEN		
				-- ESTADO s0: calcula o novo input do neuronio

				IF (calcsum < nodes) THEN
					-- calcula o somatorio
					IF (calcsum /= j) THEN			
						--prod := weight(j, i, j, calcsum) * neuronInput(index(j, calcsum), outputs);
						prod := to_sfixed(0.2,bits,-bits)* neuronInput(index(j, calcsum), outputs);
						csum  := prod + csum(2*bits+1 downto -bits*2);						
						IF (calcsum /= i) THEN
							--prod := weight(j, i, calcsum, i) * neuronInput(index(calcsum, i), outputs);
						--	prod := to_sfixed(0.1,bits,-bits)* neuronInput(index(j, calcsum), outputs);
							csum  := prod + csum(2*bits+1 downto -bits*2);
							--prod := weight(j, i, calcsum, j) * neuronInput(index(calcsum, j), outputs);
						--	prod := to_sfixed(0.3,bits,-bits)* neuronInput(index(j, calcsum), outputs);
							csum  := prod + csum(2*bits+1 downto -bits*2);
						END IF;
					END IF;
					IF (calcsum /= i) THEN
						--prod := weight(j, i, i, calcsum) * neuronInput(index(i, calcsum), outputs);
--						prod := to_sfixed(0.5,bits,-bits)* neuronInput(index(j, calcsum), outputs);
						--prod := to_sfixed(0.782,bits,-bits)*to_sfixed(0.3,bits,-bits);
						csum  := prod + csum(2*bits+1 downto -bits*2);
					END IF;
					
					calcsum := calcsum + 1;
					
				ELSE
					
					calcsum := 0;
					sum := csum(bits DOWNTO -bits);		
					csum := (OTHERS => '0');		
								
					-- atualiza o input (local) -- input[index] = input[index] - A*inputOld2[index] + B*sum + C*bias[index];
					acc := (OTHERS => '0');
					
					acc := resize(acc, bits, -bits) + input;
					prod := A*inputOLD;
					acc := resize(acc, bits, -bits) - prod(bits downto -bits);
					prod := B*sum;
					acc := resize(acc, bits, -bits) + prod(bits downto -bits);
					prod := C*biasv;
					acc := resize(acc, bits, -bits) + prod(bits downto -bits);
					
					-- atualiza o passado
					inputOLD := input; --neuronInput(index(i, j), inputs);
					-- atualiza o input
					input := acc(bits downto -bits);
					
					-- muda de estado
					nstate <= "01";
				END IF;
			ELSIF (state = s1) THEN	
				-- ESTADO s1: atualiza a saida do neuronio e checa se alcancou a convergencia		
				-- atualiza todos inputs agora
				owninput <= to_std_logic_vector(input);

				-- calcula a saida		
				--  output[index] = (1.0f/(1.0f + exp(-lambda*input[index])));
				outputOLD := output;
				output := sigmoid(-input);
				
				-- faz a diferenca da saida calculada e a saida atual
				acc := outputOLD - output;
				
				-- threshold alcancado
				IF (acc(bits downto -bits) > threshold) THEN
					--nstate <= "11";	
				ELSE
					nstate <= "10"; -- 101010 s2
				END IF;
				nstate <= "10"; 
				
			ELSIF (state = s2) THEN
				-- ESTADO s2: todos os neuronios convergiram
				IF (output > to_sfixed (0.5	,bits,-bits)) THEN
					y <= '0';
				ELSE
					y <= '1';
				END IF;
				--nstate <= "00";									
			ELSE 
				-- ESTADO s3: nem todos os neuronios nao convergiram
				-- realimenta 
				--owninput <= to_std_logic_vector(output);
				--y <= output;
				--ownoutput <= to_std_logic_vector(output);
				nstate <= "10";							
			END IF;	
		END IF;
	END PROCESS;
END Neuron;
