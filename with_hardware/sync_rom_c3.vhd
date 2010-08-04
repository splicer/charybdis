-------------------------------------------------------------------------------
-- Synthesizable syncronous 8-bit in 8-bit out ROM.
-- Outputs the input multiplied by c3 (as an unsigned integer).
-- 
-- Based on code by M. Treseler available at:
-- http://mysite.ncnetwork.net/reszotzl/sync_rom.vhd
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync_rom_c3 is
    generic (data_length : natural := 8;
             add_length  : natural := 8);

    port ( clk          : in  std_logic;
           address      : in  std_logic_vector(add_length-1 downto 0);
           data_out     : out std_logic_vector(data_length-1 downto 0)
       );
end sync_rom_c3;

architecture synth_c3 of sync_rom_c3 is ---------------------------------------------
    constant mem_size : natural := 2**add_length;
    type     mem_type is array (mem_size-1 downto 0) of
    std_logic_vector (data_length-1 downto 0);
    constant mem : mem_type := (
        0 => "00000000" ,
        1 => "00000000" ,
        2 => "00000000" ,
        3 => "00000000" ,
        4 => "00000000" ,
        5 => "00000000" ,
        6 => "00000001" ,
        7 => "00000001" ,
        8 => "00000001" ,
        9 => "00000001" ,
        10 => "00000001" ,
        11 => "00000001" ,
        12 => "00000001" ,
        13 => "00000001" ,
        14 => "00000001" ,
        15 => "00000001" ,
        16 => "00000010" ,
        17 => "00000010" ,
        18 => "00000010" ,
        19 => "00000010" ,
        20 => "00000010" ,
        21 => "00000010" ,
        22 => "00000010" ,
        23 => "00000010" ,
        24 => "00000010" ,
        25 => "00000010" ,
        26 => "00000011" ,
        27 => "00000011" ,
        28 => "00000011" ,
        29 => "00000011" ,
        30 => "00000011" ,
        31 => "00000011" ,
        32 => "00000011" ,
        33 => "00000011" ,
        34 => "00000011" ,
        35 => "00000011" ,
        36 => "00000100" ,
        37 => "00000100" ,
        38 => "00000100" ,
        39 => "00000100" ,
        40 => "00000100" ,
        41 => "00000100" ,
        42 => "00000100" ,
        43 => "00000100" ,
        44 => "00000100" ,
        45 => "00000100" ,
        46 => "00000101" ,
        47 => "00000101" ,
        48 => "00000101" ,
        49 => "00000101" ,
        50 => "00000101" ,
        51 => "00000101" ,
        52 => "00000101" ,
        53 => "00000101" ,
        54 => "00000101" ,
        55 => "00000101" ,
        56 => "00000101" ,
        57 => "00000110" ,
        58 => "00000110" ,
        59 => "00000110" ,
        60 => "00000110" ,
        61 => "00000110" ,
        62 => "00000110" ,
        63 => "00000110" ,
        64 => "00000110" ,
        65 => "00000110" ,
        66 => "00000110" ,
        67 => "00000111" ,
        68 => "00000111" ,
        69 => "00000111" ,
        70 => "00000111" ,
        71 => "00000111" ,
        72 => "00000111" ,
        73 => "00000111" ,
        74 => "00000111" ,
        75 => "00000111" ,
        76 => "00000111" ,
        77 => "00001000" ,
        78 => "00001000" ,
        79 => "00001000" ,
        80 => "00001000" ,
        81 => "00001000" ,
        82 => "00001000" ,
        83 => "00001000" ,
        84 => "00001000" ,
        85 => "00001000" ,
        86 => "00001000" ,
        87 => "00001001" ,
        88 => "00001001" ,
        89 => "00001001" ,
        90 => "00001001" ,
        91 => "00001001" ,
        92 => "00001001" ,
        93 => "00001001" ,
        94 => "00001001" ,
        95 => "00001001" ,
        96 => "00001001" ,
        97 => "00001001" ,
        98 => "00001010" ,
        99 => "00001010" ,
        100 => "00001010" ,
        101 => "00001010" ,
        102 => "00001010" ,
        103 => "00001010" ,
        104 => "00001010" ,
        105 => "00001010" ,
        106 => "00001010" ,
        107 => "00001010" ,
        108 => "00001011" ,
        109 => "00001011" ,
        110 => "00001011" ,
        111 => "00001011" ,
        112 => "00001011" ,
        113 => "00001011" ,
        114 => "00001011" ,
        115 => "00001011" ,
        116 => "00001011" ,
        117 => "00001011" ,
        118 => "00001100" ,
        119 => "00001100" ,
        120 => "00001100" ,
        121 => "00001100" ,
        122 => "00001100" ,
        123 => "00001100" ,
        124 => "00001100" ,
        125 => "00001100" ,
        126 => "00001100" ,
        127 => "00001100" ,
        128 => "00001101" ,
        129 => "00001101" ,
        130 => "00001101" ,
        131 => "00001101" ,
        132 => "00001101" ,
        133 => "00001101" ,
        134 => "00001101" ,
        135 => "00001101" ,
        136 => "00001101" ,
        137 => "00001101" ,
        138 => "00001110" ,
        139 => "00001110" ,
        140 => "00001110" ,
        141 => "00001110" ,
        142 => "00001110" ,
        143 => "00001110" ,
        144 => "00001110" ,
        145 => "00001110" ,
        146 => "00001110" ,
        147 => "00001110" ,
        148 => "00001110" ,
        149 => "00001111" ,
        150 => "00001111" ,
        151 => "00001111" ,
        152 => "00001111" ,
        153 => "00001111" ,
        154 => "00001111" ,
        155 => "00001111" ,
        156 => "00001111" ,
        157 => "00001111" ,
        158 => "00001111" ,
        159 => "00010000" ,
        160 => "00010000" ,
        161 => "00010000" ,
        162 => "00010000" ,
        163 => "00010000" ,
        164 => "00010000" ,
        165 => "00010000" ,
        166 => "00010000" ,
        167 => "00010000" ,
        168 => "00010000" ,
        169 => "00010001" ,
        170 => "00010001" ,
        171 => "00010001" ,
        172 => "00010001" ,
        173 => "00010001" ,
        174 => "00010001" ,
        175 => "00010001" ,
        176 => "00010001" ,
        177 => "00010001" ,
        178 => "00010001" ,
        179 => "00010010" ,
        180 => "00010010" ,
        181 => "00010010" ,
        182 => "00010010" ,
        183 => "00010010" ,
        184 => "00010010" ,
        185 => "00010010" ,
        186 => "00010010" ,
        187 => "00010010" ,
        188 => "00010010" ,
        189 => "00010011" ,
        190 => "00010011" ,
        191 => "00010011" ,
        192 => "00010011" ,
        193 => "00010011" ,
        194 => "00010011" ,
        195 => "00010011" ,
        196 => "00010011" ,
        197 => "00010011" ,
        198 => "00010011" ,
        199 => "00010011" ,
        200 => "00010100" ,
        201 => "00010100" ,
        202 => "00010100" ,
        203 => "00010100" ,
        204 => "00010100" ,
        205 => "00010100" ,
        206 => "00010100" ,
        207 => "00010100" ,
        208 => "00010100" ,
        209 => "00010100" ,
        210 => "00010101" ,
        211 => "00010101" ,
        212 => "00010101" ,
        213 => "00010101" ,
        214 => "00010101" ,
        215 => "00010101" ,
        216 => "00010101" ,
        217 => "00010101" ,
        218 => "00010101" ,
        219 => "00010101" ,
        220 => "00010110" ,
        221 => "00010110" ,
        222 => "00010110" ,
        223 => "00010110" ,
        224 => "00010110" ,
        225 => "00010110" ,
        226 => "00010110" ,
        227 => "00010110" ,
        228 => "00010110" ,
        229 => "00010110" ,
        230 => "00010111" ,
        231 => "00010111" ,
        232 => "00010111" ,
        233 => "00010111" ,
        234 => "00010111" ,
        235 => "00010111" ,
        236 => "00010111" ,
        237 => "00010111" ,
        238 => "00010111" ,
        239 => "00010111" ,
        240 => "00010111" ,
        241 => "00011000" ,
        242 => "00011000" ,
        243 => "00011000" ,
        244 => "00011000" ,
        245 => "00011000" ,
        246 => "00011000" ,
        247 => "00011000" ,
        248 => "00011000" ,
        249 => "00011000" ,
        250 => "00011000" ,
        251 => "00011001" ,
        252 => "00011001" ,
        253 => "00011001" ,
        254 => "00011001" ,
        255 => "00011001"
    );

begin
    rom : process (clk)
    begin
        if rising_edge(clk) then
            data_out <= mem(to_integer(unsigned(address))); 
        end if;
    end process rom;

end architecture synth_c3;

