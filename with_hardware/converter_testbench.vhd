
-------------------------------------------------------------------------------
-- 
-- 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.txt_util.all;

entity converter_testbench is

    generic (in_length : natural := 8;
             y_length  : natural := 8;
             c_length  : natural := 9);

end converter_testbench;

architecture behaviour of converter_testbench is ---------------------------------------------

    component converter is

        port ( clk          : in  std_logic;
               red          : in  std_logic_vector(in_length-1 downto 0);
               green        : in  std_logic_vector(in_length-1 downto 0);
               blue         : in  std_logic_vector(in_length-1 downto 0);
               y            : out std_logic_vector(y_length-1 downto 0);
               cb           : out std_logic_vector(c_length-1 downto 0);
               cr           : out std_logic_vector(c_length-1 downto 0)
           );
    end component;

    signal myClk: std_logic;
    signal test_r: std_logic_vector(in_length-1 downto 0);
    signal test_g: std_logic_vector(in_length-1 downto 0);
    signal test_b: std_logic_vector(in_length-1 downto 0);
    signal test_y: std_logic_vector(y_length-1 downto 0);
    signal test_cb: std_logic_vector(c_length-1 downto 0);
    signal test_cr: std_logic_vector(c_length-1 downto 0);

begin
    test_converter: converter port map (myClk, test_r, test_g, test_b, test_y, test_cb, test_cr);

    process
        variable l : line;
    begin
        test_r <= x"ff";
        test_b <= x"ff";
        test_g <= x"ff";
        
        myClk <= '0';
        wait for 100 ns;
        myClk <= '1';
        wait for 100 ns;

        write (l, "Red:   " & str(test_r));
        writeline (output, l);
        write (l, "Green: " & str(test_g));
        writeline (output, l);
        write (l, "Blue:  " & str(test_b));
        writeline (output, l);
        write (l, "Y:     " & str(test_y));
        writeline (output, l);
        write (l, "Cb:    " & str(test_cb));
        writeline (output, l);
        write (l, "Cr:    " & str(test_cr));
        writeline (output, l);
        wait;
    end process;

end architecture behaviour;

