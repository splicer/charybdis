-------------------------------------------------------------------------------
-- 
-- 
-- Based on code by M. Treseler available at:
-- http://mysite.ncnetwork.net/reszotzl/sync_rom.vhd
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.txt_util.all;

entity converter is
    generic (in_length : natural := 8;
             y_length  : natural := 8;
             c_length  : natural := 9);

    port ( clk          : in  std_logic;
           red          : in  std_logic_vector(in_length-1 downto 0);
           green        : in  std_logic_vector(in_length-1 downto 0);
           blue         : in  std_logic_vector(in_length-1 downto 0);
           y            : out std_logic_vector(y_length-1 downto 0);
           cb           : out std_logic_vector(c_length-1 downto 0);
           cr           : out std_logic_vector(c_length-1 downto 0)
       );
end converter;

architecture behaviour of converter is ---------------------------------------------

    component sync_rom_c1 is
    port ( clk          : in  std_logic;
           address      : in  std_logic_vector(in_length-1 downto 0);
           data_out     : out std_logic_vector(y_length-1 downto 0)
      );
    end component;

    signal myClk: std_logic;
    signal my_y1: std_logic_vector(in_length-1 downto 0);
    signal myDataOut1: std_logic_vector(y_length-1 downto 0);
    signal my_y2: std_logic_vector(in_length-1 downto 0);
    signal myDataOut2: std_logic_vector(y_length-1 downto 0);

begin
    mult1: sync_rom_c1 port map (myClk, my_y1, myDataOut1);
    mult2: sync_rom_c1 port map (myClk, my_y2, myDataOut2);

    process
        variable l : line;
        variable sum : std_logic_vector(y_length-1 downto 0);
    begin
        my_y1 <= x"0a";
        my_y2 <= x"2a";
        
        myClk <= '0';
        wait for 10 ns;
        myClk <= '1';
        wait for 10 ns;

        sum := std_logic_vector(unsigned(myDataOut1) + unsigned(myDataOut2));

        write (l, "Result:" & str(sum));
        writeline (output, l);
        wait;
    end process;

end architecture behaviour;

