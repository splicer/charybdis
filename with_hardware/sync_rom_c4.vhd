-------------------------------------------------------------------------------
-- Synthesizable syncronous 8-bit in 9-bit out ROM.
-- Outputs the input multiplied by c4 (as a signed integer).
-- 
-- Based on code by M. Treseler available at:
-- http://mysite.ncnetwork.net/reszotzl/sync_rom.vhd
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync_rom_c4 is
    generic (data_length : natural := 8;
             add_length  : natural := 8);

    port ( clk          : in  std_logic;
           address      : in  std_logic_vector(add_length-1 downto 0);
           data_out     : out std_logic_vector(data_length-1 downto 0)
       );
end sync_rom_c4;

architecture synth_c4 of sync_rom_c4 is ---------------------------------------------
    constant mem_size : natural := 2**add_length;
    type     mem_type is array (mem_size-1 downto 0) of
    std_logic_vector (data_length-1 downto 0);
    constant mem : mem_type := (
       0 => "000000000" ,
       1 => "000000000" ,
       2 => "111111111" ,
       3 => "111111111" ,
       4 => "111111111" ,
       5 => "111111111" ,
       6 => "111111110" ,
       7 => "111111110" ,
       8 => "111111110" ,
       9 => "111111101" ,
       10 => "111111101" ,
       11 => "111111101" ,
       12 => "111111100" ,
       13 => "111111100" ,
       14 => "111111100" ,
       15 => "111111100" ,
       16 => "111111011" ,
       17 => "111111011" ,
       18 => "111111011" ,
       19 => "111111010" ,
       20 => "111111010" ,
       21 => "111111010" ,
       22 => "111111001" ,
       23 => "111111001" ,
       24 => "111111001" ,
       25 => "111111001" ,
       26 => "111111000" ,
       27 => "111111000" ,
       28 => "111111000" ,
       29 => "111110111" ,
       30 => "111110111" ,
       31 => "111110111" ,
       32 => "111110111" ,
       33 => "111110110" ,
       34 => "111110110" ,
       35 => "111110110" ,
       36 => "111110101" ,
       37 => "111110101" ,
       38 => "111110101" ,
       39 => "111110100" ,
       40 => "111110100" ,
       41 => "111110100" ,
       42 => "111110100" ,
       43 => "111110011" ,
       44 => "111110011" ,
       45 => "111110011" ,
       46 => "111110010" ,
       47 => "111110010" ,
       48 => "111110010" ,
       49 => "111110001" ,
       50 => "111110001" ,
       51 => "111110001" ,
       52 => "111110001" ,
       53 => "111110000" ,
       54 => "111110000" ,
       55 => "111110000" ,
       56 => "111101111" ,
       57 => "111101111" ,
       58 => "111101111" ,
       59 => "111101111" ,
       60 => "111101110" ,
       61 => "111101110" ,
       62 => "111101110" ,
       63 => "111101101" ,
       64 => "111101101" ,
       65 => "111101101" ,
       66 => "111101100" ,
       67 => "111101100" ,
       68 => "111101100" ,
       69 => "111101100" ,
       70 => "111101011" ,
       71 => "111101011" ,
       72 => "111101011" ,
       73 => "111101010" ,
       74 => "111101010" ,
       75 => "111101010" ,
       76 => "111101001" ,
       77 => "111101001" ,
       78 => "111101001" ,
       79 => "111101001" ,
       80 => "111101000" ,
       81 => "111101000" ,
       82 => "111101000" ,
       83 => "111100111" ,
       84 => "111100111" ,
       85 => "111100111" ,
       86 => "111100111" ,
       87 => "111100110" ,
       88 => "111100110" ,
       89 => "111100110" ,
       90 => "111100101" ,
       91 => "111100101" ,
       92 => "111100101" ,
       93 => "111100100" ,
       94 => "111100100" ,
       95 => "111100100" ,
       96 => "111100100" ,
       97 => "111100011" ,
       98 => "111100011" ,
       99 => "111100011" ,
       100 => "111100010" ,
       101 => "111100010" ,
       102 => "111100010" ,
       103 => "111100001" ,
       104 => "111100001" ,
       105 => "111100001" ,
       106 => "111100001" ,
       107 => "111100000" ,
       108 => "111100000" ,
       109 => "111100000" ,
       110 => "111011111" ,
       111 => "111011111" ,
       112 => "111011111" ,
       113 => "111011111" ,
       114 => "111011110" ,
       115 => "111011110" ,
       116 => "111011110" ,
       117 => "111011101" ,
       118 => "111011101" ,
       119 => "111011101" ,
       120 => "111011100" ,
       121 => "111011100" ,
       122 => "111011100" ,
       123 => "111011100" ,
       124 => "111011011" ,
       125 => "111011011" ,
       126 => "111011011" ,
       127 => "111011010" ,
       128 => "111011010" ,
       129 => "111011010" ,
       130 => "111011001" ,
       131 => "111011001" ,
       132 => "111011001" ,
       133 => "111011001" ,
       134 => "111011000" ,
       135 => "111011000" ,
       136 => "111011000" ,
       137 => "111010111" ,
       138 => "111010111" ,
       139 => "111010111" ,
       140 => "111010110" ,
       141 => "111010110" ,
       142 => "111010110" ,
       143 => "111010110" ,
       144 => "111010101" ,
       145 => "111010101" ,
       146 => "111010101" ,
       147 => "111010100" ,
       148 => "111010100" ,
       149 => "111010100" ,
       150 => "111010100" ,
       151 => "111010011" ,
       152 => "111010011" ,
       153 => "111010011" ,
       154 => "111010010" ,
       155 => "111010010" ,
       156 => "111010010" ,
       157 => "111010001" ,
       158 => "111010001" ,
       159 => "111010001" ,
       160 => "111010001" ,
       161 => "111010000" ,
       162 => "111010000" ,
       163 => "111010000" ,
       164 => "111001111" ,
       165 => "111001111" ,
       166 => "111001111" ,
       167 => "111001110" ,
       168 => "111001110" ,
       169 => "111001110" ,
       170 => "111001110" ,
       171 => "111001101" ,
       172 => "111001101" ,
       173 => "111001101" ,
       174 => "111001100" ,
       175 => "111001100" ,
       176 => "111001100" ,
       177 => "111001100" ,
       178 => "111001011" ,
       179 => "111001011" ,
       180 => "111001011" ,
       181 => "111001010" ,
       182 => "111001010" ,
       183 => "111001010" ,
       184 => "111001001" ,
       185 => "111001001" ,
       186 => "111001001" ,
       187 => "111001001" ,
       188 => "111001000" ,
       189 => "111001000" ,
       190 => "111001000" ,
       191 => "111000111" ,
       192 => "111000111" ,
       193 => "111000111" ,
       194 => "111000110" ,
       195 => "111000110" ,
       196 => "111000110" ,
       197 => "111000110" ,
       198 => "111000101" ,
       199 => "111000101" ,
       200 => "111000101" ,
       201 => "111000100" ,
       202 => "111000100" ,
       203 => "111000100" ,
       204 => "111000100" ,
       205 => "111000011" ,
       206 => "111000011" ,
       207 => "111000011" ,
       208 => "111000010" ,
       209 => "111000010" ,
       210 => "111000010" ,
       211 => "111000001" ,
       212 => "111000001" ,
       213 => "111000001" ,
       214 => "111000001" ,
       215 => "111000000" ,
       216 => "111000000" ,
       217 => "111000000" ,
       218 => "110111111" ,
       219 => "110111111" ,
       220 => "110111111" ,
       221 => "110111110" ,
       222 => "110111110" ,
       223 => "110111110" ,
       224 => "110111110" ,
       225 => "110111101" ,
       226 => "110111101" ,
       227 => "110111101" ,
       228 => "110111100" ,
       229 => "110111100" ,
       230 => "110111100" ,
       231 => "110111100" ,
       232 => "110111011" ,
       233 => "110111011" ,
       234 => "110111011" ,
       235 => "110111010" ,
       236 => "110111010" ,
       237 => "110111010" ,
       238 => "110111001" ,
       239 => "110111001" ,
       240 => "110111001" ,
       241 => "110111001" ,
       242 => "110111000" ,
       243 => "110111000" ,
       244 => "110111000" ,
       245 => "110110111" ,
       246 => "110110111" ,
       247 => "110110111" ,
       248 => "110110110" ,
       249 => "110110110" ,
       250 => "110110110" ,
       251 => "110110110" ,
       252 => "110110101" ,
       253 => "110110101" ,
       254 => "110110101" ,
       255 => "110110100"
    );

begin
    rom : process (clk)
    begin
        if rising_edge(clk) then
            data_out <= mem(to_integer(unsigned(address))); 
        end if;
    end process rom;

end architecture synth_c4;

