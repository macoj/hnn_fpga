LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

package fp_pkg is
	type fixsign is array (integer range <>) of std_logic;
	subtype fp8_3 is fixsign ( 8 downto -3);
end package;

package body fp_pkg is
	
	function fp2std_logic_vector (d : fixsign; top : integer; low : integer)
	return std_logic_vector is
		variable outval : std_logic_vector ( top-low downto 0 ) := (others => '0');
	begin
		for i in 0 to top-low loop
			outval(i) := d(i + low);
		end loop;
	return outval;
	end;

	function std_logic_vector2fp (d : std_logic_vector; top : integer; low : integer)
	return fixsign is
		variable outval : fixsign ( top downto low ) := (others => '0');
	begin
		for i in 0 to top-low loop
			outval(i + low) := d(i);
		end loop;
	return outval;
	end;

	function fp2real (d:fixsign; top:integer; low:integer)
	return real is
		variable outreal : real := 0.0;
		variable mult : real := 1.0;
		variable max : real := 1.0;
		variable debug : boolean := false;
	begin
		for i in 0 to top-1 loop
			if d(i) = '1' then
				outreal := outreal + mult;
				if debug then
					report " fp2real : " & integer'image(i);
				end if;
			end if;
			mult := mult * 2.0;
		end loop;
		if debug then
			REPORT " fp2real middle : " & real'image(outreal);
		end if;
		max := mult;
		mult := 0.5;
		for i in -1 downto low loop
			if d(i) = '1' then
				outreal := outreal + mult;
				if debug then
					report " fp2real : " & integer'image(i);
				end if;
			end if;
			mult := mult * 0.5;
		end loop;
		if debug then
			REPORT " fp2real : " & real'image(outreal);
		end if;
		if d(top) = '1' then
			outreal := outreal - max;
		end if;
		if debug then
			REPORT " fp2real FINAL VALUE : " & real'image(outreal);
		end if;
		
		return outreal;
	end;

end package body;