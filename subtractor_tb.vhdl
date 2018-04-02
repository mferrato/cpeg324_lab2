library ieee;
use ieee.std_logic_1164.all;

--  A testbench has no ports.
entity subtractor_tb is
end subtractor_tb;

architecture behav of subtractor_tb is
	--  Declaration of the component that will be instantiated.
	component subtractor
    Port(   sel: in std_logic;
            a, b: in std_logic_vector(3 downto 0);
            sum: out std_logic_vector(3 downto 0);
            overflow: out std_logic);
	end component;

	--  Specifies which entity is bound with the component.
	--  testing numbers
	signal a1, b1: std_logic_vector(3 downto 0);
	signal over, sel: std_logic;
	signal sum1: std_logic_vector(3 downto 0);

	begin
	--  Component instantiation.
		subtractor0: subtractor port map (a => a1, b => b1, overflow => over, sel => sel, sum => sum1);

	--  This process does the real job.
	process
		type pattern_type is record
		--  The inputs of the adder/.
		a1, b1: std_logic_vector (3 downto 0);
		sel, over: std_logic;
		--  The expected outputs of the adder.
		sum1: std_logic_vector (3 downto 0);
		end record;

	--  The patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns: pattern_array :=
		(("0001", "0001", '0', '0', "0010"),
		 ("0010", "0001", '1', '0', "0001"),
		("1111", "1111",'0', '1', "0000"));

		begin
			--  Check each pattern.
			for n in patterns'range loop

			--  Set the inputs.
			a1 <= patterns(n).a1;
			b1 <= patterns(n).b1;

			--  Wait for the results.
			wait for 1 ns;

			--  Check the outputs.
			assert over = patterns(n).over
			report "bad output value" severity error;
			assert sum1 = patterns(n).sum1
			report "bad output value" severity error;
			end loop;

		report "end of test" severity note;
		--  Wait forever; this will finish the simulation.
		wait;
	end process;
end behav;
