#! /usr/bin/python2.6

def ycc_from_rgb(rgb):
    # 8-bit RGB input
    # 9-bit YCbCr output
    y = (int(round(65.738/256 * rgb[0] * 2)), int(round(129.057/256 * rgb[1] * 2)), int(round(25.064/256 * rgb[2] * 2)), 16 * 2)
    cb = (int(round(-37.945/256 * rgb[0] * 2)), int(round(-74.494/256 * rgb[1] * 2)), int(round(112.439/256 * rgb[2] * 2)), 128 * 2)
    cr = (int(round(112.439/256 * rgb[0] * 2)), int(round(-94.154/256 * rgb[1] * 2)), int(round(-18.285/256 * rgb[2] * 2)), 128 * 2)
    y = sum(y)
    cb = sum(cb)
    cr = sum(cr)
    return (y, cb, cr)

if __name__ == '__main__':
    import random
    import sys
    random.seed()
    if len(sys.argv) == 4:
        rgb = (int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]))
    else:
        rgb = (random.randint(0,255), random.randint(0,255), random.randint(0,255))
    ycc = ycc_from_rgb(rgb)
    print "8-bit RGB: %s" % str(rgb)
    print "9-bit YCbCr: %s" % str(ycc)
