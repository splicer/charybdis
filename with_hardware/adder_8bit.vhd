
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_8bit is
      generic (length : natural := 8);
  
      port ( op_1         : in  std_logic_vector(length-1 downto 0);
             op_2         : in  std_logic_vector(length-1 downto 0);
             sum         : out  std_logic_vector(length-1 downto 0)
         );
end adder_8bit;

architecture behaviour of adder_8bit is ---------------------------------------------

begin

    sum <= std_logic_vector(unsigned(op_1) + unsigned(op_2));

end architecture behaviour;

