#! /usr/bin/python2.6

def ycc_from_rgb(rgb):
    y = 0.257 * rgb[0] + 0.504 * rgb[1] + 0.098 * rgb[2] + 16
    cb = -0.148 * rgb[0] - 0.291 * rgb[1] + 0.439 * rgb[2] + 128
    cr = 0.439 * rgb[0] - 0.368 * rgb[1] - 0.071 * rgb[2] + 128
    return (y, cb, cr)

#def ycc4_from_rgb4(rgb4):
#    ycc4 = [ycc_from_rgb(x) for x in rgb4]
#    return ycc4

if __name__ == '__main__':
    rgb = (255, 60, 20)
    print "RGB: %s" % str(rgb)
    ycbcr = ycc_from_rgb(rgb)
    print "YCbCr: %s" % str(ycbcr)
