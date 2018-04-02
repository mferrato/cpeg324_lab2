library ieee;
use ieee.std_logic_1164.all;

entity mux_4_to_1 is
  	generic (INPUT_SIZE: natural); --inf range
    	port( I1, I2, I3, I4: in  std_logic_vector (INPUT_SIZE - 1 downto 0); --4 different inputs
          	SEL: in  std_logic_vector (1 downto 0); --determines which input is output
          	O: out std_logic_vector (INPUT_SIZE - 1 downto 0)); --output
end mux_4_to_1;

architecture behavior of mux_4_to_1 is
	begin
   		mux: process(I1, I2, I3, I4, sel)
 	 		begin
    				if  (SEL = "00") then --if sel is 0 then output input1
     					O <= I1;
    				elsif (SEL = "01") then --if sel is 1 then output input2
					O <= I2;
				elsif (SEL = "10") then --if sel is 2 then output input3
      					O <= I3;
    				else --if sel is 3 then output input4
      					O <= I4;
    				end if;
 		 end process mux;
end behavior;
  
