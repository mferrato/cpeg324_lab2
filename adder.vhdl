library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    Port (  a, b: in std_logic;  
            sum, carry: out std_logic);
end half_adder;

architecture behavior of half_adder is
begin
    sum <= a xor b; -- adds the two inputs
    carry <= a and b; -- finds the carry 
end behavior;

----------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    Port(   a, b, carryin: in std_logic;
            sum, carryout: out std_logic);
end full_adder;

architecture behavior of full_adder is
component half_adder is -- uses the half adder implementation
    port(   a, b: in std_logic;
            sum, carry: out std_logic);
end component half_adder;

signal s1, s2, s3: std_logic;
begin
    ha1: half_adder port map (a, b, s1, s3); -- adds the two inputs and finds the first carry
    ha2: half_adder port map (s1, carryin, sum, s2); -- adds the previous sum and the first carry
    carryout <= s2 or s3; -- finds carry2
end behavior;

----------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity adder is
    Port( a, b: in std_logic_vector(3 downto 0);
            sum: out std_logic_vector(3 downto 0);
            overflow: out std_logic);
end adder;

architecture behavior of adder is
component full_adder is -- uses full adder implementation
    Port( a, b, carryin: in std_logic;
            sum, carryout: out std_logic);
end component full_adder;

signal carry0, carry1, carry2, carry3, sum3: std_logic;
begin

    fa0: full_adder port map(a(0), b(0), '0', sum(0), carry0);  --adds 4 bits
    fa1: full_adder port map(a(1), b(1), carry0, sum(1), carry1); 
    fa2: full_adder port map(a(2), b(2), carry1, sum(2), carry2); 
    fa3: full_adder port map(a(3), b(3), carry2, sum(3), carry3);
     
    -- checks for carry overflow (if the sum is bigger than 4 bits	
    overflow <= carry3;

end behavior;

----------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity subtractor is
    Port(   sel: in std_logic;
            a, b: in std_logic_vector(3 downto 0);
            sum: out std_logic_vector(3 downto 0);
            overflow: out std_logic);
end subtractor;

architecture behavior of subtractor is
component adder is -- uses 4bit adder implementation
    Port(   a, b: in std_logic_vector(3 downto 0);
            sum: out std_logic_vector(3 downto 0);
            overflow: out std_logic);
end component;

signal complements2, invert, negative: std_logic_vector(3 downto 0);
signal overflowtemp: std_logic;

begin
		invert <= not(b); -- first step of two's complement from positive to negative
		adder0: adder port map(invert, "0001", negative, open); -- second step of two's complements, stored in negative 
	process
		begin
		if(sel = '0') then
		complements2 <= b;
		else
		complements2 <= negative;
		end if;
	end process;
		-- substracts the number (adds the positive number to the negative one)
		adder1: adder port map(a, complements2, sum, overflowtemp); 
	
		-- checks for overflow
		overflow <= overflowtemp;
end behavior;
