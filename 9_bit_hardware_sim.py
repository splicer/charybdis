#! /usr/bin/python2.6

def ycc_from_rgb(rgb):
    # 8-bit RGB input
    # 9-bit YCbCr output
    y = (int(round(0.257 * rgb[0] * 2)), int(round(0.504 * rgb[1] * 2)), int(round(0.098 * rgb[2] * 2)), 16 * 2)
    cb = (int(round(-0.148 * rgb[0] * 2)), int(round(-0.291 * rgb[1] * 2)), int(round(0.439 * rgb[2] * 2)), 128 * 2)
    cr = (int(round(0.439 * rgb[0] * 2)), int(round(-0.368 * rgb[1] * 2)), int(round(-0.071 * rgb[2] * 2)), 128 * 2)
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
