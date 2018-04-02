library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity mux_4_to_1_tb is
end mux_4_to_1_tb;

architecture behav of mux_4_to_1_tb is
	--  Declaration of the component that will be instantiated.
	component mux_4_to_1
		generic (INPUT_SIZE: natural); --inf range
		port( I1, I2, I3, I4: in  std_logic_vector (INPUT_SIZE - 1 downto 0); 	--4 different inputs
          		SEL: in  std_logic_vector (1 downto 0); --determines which input is output
          		O: out std_logic_vector (INPUT_SIZE - 1 downto 0)); --output

	end component;

	--  Specifies which entity is bound with the component.
	--  testing numbers
	signal i1, i2, i3, i4: std_logic_vector(3 downto 0);
	signal sel: std_logic_vector(1 downto 0);
	signal o: std_logic_vector(3 downto 0);

	begin
	--  Component instantiation.
		mux: mux_4_to_1 generic map(4) port map (I1 => i1, I2 => i2, I3 => i3, I4 => i4, SEL => sel, O => o);

	--  This process does the real job.
	process
		type pattern_type is record
		--  The inputs of the mux.
		i1, i2, i3, i4: std_logic_vector (3 downto 0);
		sel: std_logic_vector(1 downto 0);
		--  The expected outputs of the mux.
		o: std_logic_vector (3 downto 0);
		end record;

	--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns: pattern_array :=
		(("1111", "0000", "1000", "1010", "00", "1111"),
		("1111", "0000", "1000", "1010", "01", "0000"),
		("1111", "0000", "1000", "1010", "10", "1000"),
		("1111", "0000", "1000", "1010", "11", "1010"));

		begin
			--  Check each pattern.
			for n in patterns'range loop

			--  Set the inputs.
			i1 <= patterns(n).i1;
			i2 <= patterns(n).i2;
			i3 <= patterns(n).i3;
			i4 <= patterns(n).i4;
			sel <= patterns(n).sel;

			--  Wait for the results.
			wait for 1 ns;

			--  Check the outputs.
			assert o = patterns(n).o

			report "bad output value" severity error;
			end loop;

		report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;
end behav;
