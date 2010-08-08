-------------------------------------------------------------------------------
-- Signed 9-bit adder for chrominance values. 
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity c_adder is
      generic (length : natural := 9);
  
      port ( op_1         : in  std_logic_vector(length-1 downto 0);
             op_2         : in  std_logic_vector(length-1 downto 0);
             sum         : out  std_logic_vector(length-1 downto 0)
         );
end c_adder;

architecture behaviour of c_adder is ---------------------------------------------

begin

    sum <= std_logic_vector(signed(op_1) + signed(op_2));

end architecture behaviour;

