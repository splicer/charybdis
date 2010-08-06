-------------------------------------------------------------------------------
-- 
-- 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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

architecture structure of converter is ---------------------------------------------

      component sync_rom_c1 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(y_length-1 downto 0)
        );
      end component;
  
      component sync_rom_c2 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(y_length-1 downto 0)
        );
      end component;
  
      component sync_rom_c3 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(y_length-1 downto 0)
        );
      end component;

      component sync_rom_c4 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(c_length-1 downto 0)
        );
      end component;

      component sync_rom_c5 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(c_length-1 downto 0)
        );
      end component;

      component sync_rom_c6 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(c_length-1 downto 0)
        );
      end component;

      component sync_rom_c7 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(c_length-1 downto 0)
        );
      end component;

      component sync_rom_c8 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(c_length-1 downto 0)
        );
      end component;

      component sync_rom_c9 is
      port ( clk          : in  std_logic;
             address      : in  std_logic_vector(in_length-1 downto 0);
             data_out     : out std_logic_vector(c_length-1 downto 0)
        );
      end component;

      component y_adder is
      port ( op_1         : in  std_logic_vector(y_length-1 downto 0);
             op_2         : in  std_logic_vector(y_length-1 downto 0);
             sum         : out  std_logic_vector(y_length-1 downto 0)
         );
      end component;

      component c_adder is
      port ( op_1         : in  std_logic_vector(c_length-1 downto 0);
             op_2         : in  std_logic_vector(c_length-1 downto 0);
             sum         : out  std_logic_vector(c_length-1 downto 0)
         );
      end component;

  
      signal y_c1 : std_logic_vector(y_length-1 downto 0);
      signal y_c2 : std_logic_vector(y_length-1 downto 0);
      signal y_c3 : std_logic_vector(y_length-1 downto 0);
      signal y_sum1 : std_logic_vector(y_length-1 downto 0);
      signal y_sum2 : std_logic_vector(y_length-1 downto 0);

      signal cb_c4 : std_logic_vector(c_length-1 downto 0);
      signal cb_c5 : std_logic_vector(c_length-1 downto 0);
      signal cb_c6 : std_logic_vector(c_length-1 downto 0);
      signal cb_sum1 : std_logic_vector(c_length-1 downto 0);
      signal cb_sum2 : std_logic_vector(c_length-1 downto 0);

      signal cr_c7 : std_logic_vector(c_length-1 downto 0);
      signal cr_c8 : std_logic_vector(c_length-1 downto 0);
      signal cr_c9 : std_logic_vector(c_length-1 downto 0);
      signal cr_sum1 : std_logic_vector(c_length-1 downto 0);
      signal cr_sum2 : std_logic_vector(c_length-1 downto 0);

begin
      mult1: sync_rom_c1 port map (clk, red, y_c1);
      mult2: sync_rom_c2 port map (clk, green, y_c2);
      mult3: sync_rom_c3 port map (clk, blue, y_c3);
      adder1: y_adder port map (y_c1, y_c2, y_sum1);
      adder2: y_adder port map (y_c3, b"00010000", y_sum2);
      adder3: y_adder port map (y_sum1, y_sum2, y);

      mult4: sync_rom_c4 port map (clk, red, cb_c4);
      mult5: sync_rom_c5 port map (clk, green, cb_c5);
      mult6: sync_rom_c6 port map (clk, blue, cb_c6);
      adder4: c_adder port map (cb_c4, cb_c5, cb_sum1);
      adder5: c_adder port map (cb_c6, b"010000000", cb_sum2);
      adder6: c_adder port map (cb_sum1, cb_sum2, cb);

      mult7: sync_rom_c7 port map (clk, red, cr_c7);
      mult8: sync_rom_c8 port map (clk, green, cr_c8);
      mult9: sync_rom_c9 port map (clk, blue, cr_c9);
      adder7: c_adder port map (cr_c7, cr_c8, cr_sum1);
      adder8: c_adder port map (cr_c9, b"010000000", cr_sum2);
      adder9: c_adder port map (cr_sum1, cr_sum2, cr);

end architecture structure;

