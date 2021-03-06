
LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ieee_proposed;
USE ieee_proposed.fixed_pkg.all;

ENTITY Reset IS 
PORT (	rst: IN STD_LOGIC; 	
		state: OUT bit
	  );
END Reset;

ARCHITECTURE Reset OF Reset IS 
BEGIN 
	PROCESS (rst)
	BEGIN 
		state <= '0';
	END PROCESS;
END Reset;
