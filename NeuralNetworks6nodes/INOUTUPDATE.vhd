
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ieee_proposed;
USE ieee_proposed.fixed_pkg.all;

ENTITY INOUTUPDATE IS 
PORT (	clk: IN STD_LOGIC; 	
		state: IN bit;
		x:   IN sfixed(2*8+1+1 downto -8*2);
		y:	 OUT sfixed(2*8+1+1 downto -8*2)
	  );
END INOUTUPDATE;

ARCHITECTURE INOUTUPDATE OF INOUTUPDATE IS 
BEGIN 
	PROCESS (clk)
	BEGIN 
		IF (state = '1') THEN
			--y <= x;
		END IF;
	END PROCESS;
END INOUTUPDATE;
