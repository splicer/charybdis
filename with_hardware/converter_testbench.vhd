
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
               register_in  : in  std_logic_vector(31 downto 0);
               register_out : out std_logic_vector(31 downto 0)
           );
    end component;

    signal myClk        : std_logic;
    signal register_in  : std_logic_vector(31 downto 0);
    signal register_out : std_logic_vector(31 downto 0);

    -- slices of input/output registers
    signal red      : std_logic_vector(in_length-1 downto 0);
    signal green    : std_logic_vector(in_length-1 downto 0);
    signal blue     : std_logic_vector(in_length-1 downto 0);
    signal y        : std_logic_vector(y_length-1 downto 0);
    signal cb       : std_logic_vector(c_length-1 downto 0);
    signal cr       : std_logic_vector(c_length-1 downto 0);


begin
    test_converter: converter port map (myClk, register_in, register_out); 

    process
        variable l : line;
    begin
        red     <= x"ff";
        green   <= x"ff";
        blue    <= x"ff";
        
        -- Pack test values into input register 
        -- (waits are required to avoid problems with buggy ghdl implementation)
        register_in <= x"00000000";
        wait for 10 ns;
        register_in(7 downto 0)   <= red(7 downto 0);
        wait for 10 ns;
        register_in(15 downto 8)  <= green;
        wait for 10 ns;
        register_in(23 downto 16) <= blue;
       
        -- Simulate clock-pulse
        myClk <= '0';
        wait for 100 ns;
        myClk <= '1';
        wait for 100 ns;

        -- Unpack results from output register
        y   <= register_out(7 downto 0);
        cb  <= register_out(16 downto 8);
        cr  <= register_out(25 downto 17);

        wait for 10 ns;

        write (l, "Red:   " & str(red));
        writeline (output, l);
        write (l, "Green: " & str(green));
        writeline (output, l);
        write (l, "Blue:  " & str(blue));
        writeline (output, l);
        write (l, "Y:     " & str(y));
        writeline (output, l);
        write (l, "Cb:    " & str(cb));
        writeline (output, l);
        write (l, "Cr:    " & str(cr));
        writeline (output, l);
        wait;
    end process;

end architecture behaviour;

