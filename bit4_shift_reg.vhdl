library ieee;
use ieee.std_logic_1164.all;

entity bit4_shift_reg is
port(	I:	in std_logic_vector (3 downto 0);
		I_SHIFT_IN: in std_logic;
		sel:        in std_logic_vector(1 downto 0); -- 00:hold; 01: shift left; 10: shift right; 11: load
		clock:		in std_logic; -- positive level triggering in problem 3
		enable:		in std_logic; -- 0: don't do anything; 1: shift_reg is enabled
		O:	out std_logic_vector(3 downto 0)
);
end bit4_shift_reg;

architecture behavior of bit4_shift_reg is
signal temp: std_logic_vector(3 downto 0):= "0000";
begin 
bit4_shift_reg1: process (enable, clock, sel, I_SHIFT_IN)
	begin
	if(enable ='1') then
		if(clock == 1) then
			if(sel = "00") then
				O <= temp; -- HOLD logic, keeps the same output value
			elsif(sel = "01") then
				temp <= (I(2 downto 0) & I_SHIFT_IN); -- Stores result in temp
				O <= (I(2 downto 0) & I_SHIFT_IN); -- SHIFT logic, 
			elsif(sel = "10") then
				temp <= (I_SHIFT_IN & I(3 downto 1)); -- Stores result in temp
				O <= (I_SHIFT_IN & I(3 downto 1)); -- SHIFT logic, 
			else
				temp <= I; -- Stores input in temp
				O <= I; -- LOAD logic, sets the output to input
			end if;
		else
			O <= temp; -- if no rising edge, then keep output value the same
		end if;
	else
		O <= "0000"; -- if not enable, reset temp
	end if;
	end process bit4_shift_reg1;
end behavior;

