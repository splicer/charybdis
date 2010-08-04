#! /usr/bin/python2.6

from bitstring import BitString

c1 = 65.738 / 256
c2 = 129.057 / 256
c3 = 25.064 / 256
c4 = -37.945 / 256 * 2
c5 = -74.494 / 256 * 2
c6 = 112.439 / 256 * 2
c7 = 112.439 / 256 * 2
c8 = -94.154 / 256 * 2
c9 = -18.285 / 256 * 2

def binary(n, digits=8):
    b = BitString(int=n, length=digits)
    return b.bin[2:] # chop off '0b' prefix 

def print_lut(coeff, values_out, bits_out):
    for i in range(values_out):
        print i, "=>", "\"" + binary( int(round(coeff * i)), bits_out) + "\"",
        if i != values_out - 1:
            print ","

if __name__ == '__main__':
    print "Table for c9: \n"
    print_lut(c9, 256, 9);
