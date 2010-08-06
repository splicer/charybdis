-------------------------------------------------------------------------------
-- Synthesizable syncronous 8-bit in 9-bit out ROM.
-- Outputs the input multiplied by c5 (as a signed integer).
-- 
-- Based on code by M. Treseler available at:
-- http://mysite.ncnetwork.net/reszotzl/sync_rom.vhd
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync_rom_c5 is
    generic (data_length : natural := 9;
             add_length  : natural := 8);

    port ( clk          : in  std_logic;
           address      : in  std_logic_vector(add_length-1 downto 0);
           data_out     : out std_logic_vector(data_length-1 downto 0)
       );
end sync_rom_c5;

architecture synth_c5 of sync_rom_c5 is ---------------------------------------------
    constant mem_size : natural := 2**add_length;
    type     mem_type is array (mem_size-1 downto 0) of
    std_logic_vector (data_length-1 downto 0);
    constant mem : mem_type := (
       0 => "000000000" ,
       1 => "111111111" ,
       2 => "111111111" ,
       3 => "111111110" ,
       4 => "111111110" ,
       5 => "111111101" ,
       6 => "111111101" ,
       7 => "111111100" ,
       8 => "111111011" ,
       9 => "111111011" ,
       10 => "111111010" ,
       11 => "111111010" ,
       12 => "111111001" ,
       13 => "111111000" ,
       14 => "111111000" ,
       15 => "111110111" ,
       16 => "111110111" ,
       17 => "111110110" ,
       18 => "111110110" ,
       19 => "111110101" ,
       20 => "111110100" ,
       21 => "111110100" ,
       22 => "111110011" ,
       23 => "111110011" ,
       24 => "111110010" ,
       25 => "111110001" ,
       26 => "111110001" ,
       27 => "111110000" ,
       28 => "111110000" ,
       29 => "111101111" ,
       30 => "111101111" ,
       31 => "111101110" ,
       32 => "111101101" ,
       33 => "111101101" ,
       34 => "111101100" ,
       35 => "111101100" ,
       36 => "111101011" ,
       37 => "111101010" ,
       38 => "111101010" ,
       39 => "111101001" ,
       40 => "111101001" ,
       41 => "111101000" ,
       42 => "111101000" ,
       43 => "111100111" ,
       44 => "111100110" ,
       45 => "111100110" ,
       46 => "111100101" ,
       47 => "111100101" ,
       48 => "111100100" ,
       49 => "111100011" ,
       50 => "111100011" ,
       51 => "111100010" ,
       52 => "111100010" ,
       53 => "111100001" ,
       54 => "111100001" ,
       55 => "111100000" ,
       56 => "111011111" ,
       57 => "111011111" ,
       58 => "111011110" ,
       59 => "111011110" ,
       60 => "111011101" ,
       61 => "111011100" ,
       62 => "111011100" ,
       63 => "111011011" ,
       64 => "111011011" ,
       65 => "111011010" ,
       66 => "111011010" ,
       67 => "111011001" ,
       68 => "111011000" ,
       69 => "111011000" ,
       70 => "111010111" ,
       71 => "111010111" ,
       72 => "111010110" ,
       73 => "111010110" ,
       74 => "111010101" ,
       75 => "111010100" ,
       76 => "111010100" ,
       77 => "111010011" ,
       78 => "111010011" ,
       79 => "111010010" ,
       80 => "111010001" ,
       81 => "111010001" ,
       82 => "111010000" ,
       83 => "111010000" ,
       84 => "111001111" ,
       85 => "111001111" ,
       86 => "111001110" ,
       87 => "111001101" ,
       88 => "111001101" ,
       89 => "111001100" ,
       90 => "111001100" ,
       91 => "111001011" ,
       92 => "111001010" ,
       93 => "111001010" ,
       94 => "111001001" ,
       95 => "111001001" ,
       96 => "111001000" ,
       97 => "111001000" ,
       98 => "111000111" ,
       99 => "111000110" ,
       100 => "111000110" ,
       101 => "111000101" ,
       102 => "111000101" ,
       103 => "111000100" ,
       104 => "111000011" ,
       105 => "111000011" ,
       106 => "111000010" ,
       107 => "111000010" ,
       108 => "111000001" ,
       109 => "111000001" ,
       110 => "111000000" ,
       111 => "110111111" ,
       112 => "110111111" ,
       113 => "110111110" ,
       114 => "110111110" ,
       115 => "110111101" ,
       116 => "110111100" ,
       117 => "110111100" ,
       118 => "110111011" ,
       119 => "110111011" ,
       120 => "110111010" ,
       121 => "110111010" ,
       122 => "110111001" ,
       123 => "110111000" ,
       124 => "110111000" ,
       125 => "110110111" ,
       126 => "110110111" ,
       127 => "110110110" ,
       128 => "110110110" ,
       129 => "110110101" ,
       130 => "110110100" ,
       131 => "110110100" ,
       132 => "110110011" ,
       133 => "110110011" ,
       134 => "110110010" ,
       135 => "110110001" ,
       136 => "110110001" ,
       137 => "110110000" ,
       138 => "110110000" ,
       139 => "110101111" ,
       140 => "110101111" ,
       141 => "110101110" ,
       142 => "110101101" ,
       143 => "110101101" ,
       144 => "110101100" ,
       145 => "110101100" ,
       146 => "110101011" ,
       147 => "110101010" ,
       148 => "110101010" ,
       149 => "110101001" ,
       150 => "110101001" ,
       151 => "110101000" ,
       152 => "110101000" ,
       153 => "110100111" ,
       154 => "110100110" ,
       155 => "110100110" ,
       156 => "110100101" ,
       157 => "110100101" ,
       158 => "110100100" ,
       159 => "110100011" ,
       160 => "110100011" ,
       161 => "110100010" ,
       162 => "110100010" ,
       163 => "110100001" ,
       164 => "110100001" ,
       165 => "110100000" ,
       166 => "110011111" ,
       167 => "110011111" ,
       168 => "110011110" ,
       169 => "110011110" ,
       170 => "110011101" ,
       171 => "110011100" ,
       172 => "110011100" ,
       173 => "110011011" ,
       174 => "110011011" ,
       175 => "110011010" ,
       176 => "110011010" ,
       177 => "110011001" ,
       178 => "110011000" ,
       179 => "110011000" ,
       180 => "110010111" ,
       181 => "110010111" ,
       182 => "110010110" ,
       183 => "110010101" ,
       184 => "110010101" ,
       185 => "110010100" ,
       186 => "110010100" ,
       187 => "110010011" ,
       188 => "110010011" ,
       189 => "110010010" ,
       190 => "110010001" ,
       191 => "110010001" ,
       192 => "110010000" ,
       193 => "110010000" ,
       194 => "110001111" ,
       195 => "110001111" ,
       196 => "110001110" ,
       197 => "110001101" ,
       198 => "110001101" ,
       199 => "110001100" ,
       200 => "110001100" ,
       201 => "110001011" ,
       202 => "110001010" ,
       203 => "110001010" ,
       204 => "110001001" ,
       205 => "110001001" ,
       206 => "110001000" ,
       207 => "110001000" ,
       208 => "110000111" ,
       209 => "110000110" ,
       210 => "110000110" ,
       211 => "110000101" ,
       212 => "110000101" ,
       213 => "110000100" ,
       214 => "110000011" ,
       215 => "110000011" ,
       216 => "110000010" ,
       217 => "110000010" ,
       218 => "110000001" ,
       219 => "110000001" ,
       220 => "110000000" ,
       221 => "101111111" ,
       222 => "101111111" ,
       223 => "101111110" ,
       224 => "101111110" ,
       225 => "101111101" ,
       226 => "101111100" ,
       227 => "101111100" ,
       228 => "101111011" ,
       229 => "101111011" ,
       230 => "101111010" ,
       231 => "101111010" ,
       232 => "101111001" ,
       233 => "101111000" ,
       234 => "101111000" ,
       235 => "101110111" ,
       236 => "101110111" ,
       237 => "101110110" ,
       238 => "101110101" ,
       239 => "101110101" ,
       240 => "101110100" ,
       241 => "101110100" ,
       242 => "101110011" ,
       243 => "101110011" ,
       244 => "101110010" ,
       245 => "101110001" ,
       246 => "101110001" ,
       247 => "101110000" ,
       248 => "101110000" ,
       249 => "101101111" ,
       250 => "101101111" ,
       251 => "101101110" ,
       252 => "101101101" ,
       253 => "101101101" ,
       254 => "101101100" ,
       255 => "101101100"
    );

begin
    rom : process (clk)
    begin
        if rising_edge(clk) then
            data_out <= mem(to_integer(unsigned(address))); 
        end if;
    end process rom;

end architecture synth_c5;

