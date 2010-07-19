#! /usr/bin/python2.6

def ycc_from_rgb(rgb):
    y = 0.257 * rgb[0] + 0.504 * rgb[1] + 0.098 * rgb[2] + 16
    cb = -0.148 * rgb[0] - 0.291 * rgb[1] + 0.439 * rgb[2] + 128
    cr = 0.439 * rgb[0] - 0.368 * rgb[1] - 0.071 * rgb[2] + 128
    return (y, cb, cr)

def downsampled_ycc_from_rgb(rgb1, rgb2, rgb3, rgb4):
    ycc1 = ycc_from_rgb(rgb1)
    ycc2 = ycc_from_rgb(rgb2)
    ycc3 = ycc_from_rgb(rgb3)
    ycc4 = ycc_from_rgb(rgb4)
    avg_cb = sum((ycc1[1], ycc2[1], ycc3[1], ycc4[1])) / 4
    avg_cr = sum((ycc1[2], ycc2[2], ycc3[2], ycc4[2])) / 4
    return (ycc1[0], ycc2[0], ycc3[0], ycc4[0], avg_cb, avg_cr)

if __name__ == '__main__':
    import random
    random.seed()
    rgb1 = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))
    rgb2 = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))
    rgb3 = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))
    rgb4 = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))
    print "RGB1: %s" % str(rgb1)
    print "RGB2: %s" % str(rgb2)
    print "RGB3: %s" % str(rgb3)
    print "RGB4: %s" % str(rgb4)
    downsampled_ycc = downsampled_ycc_from_rgb(rgb1, rgb2, rgb3, rgb4)
    print "Downsampled YCbCr (y1,y2,y3,y4,cb,cr):\n%s" % str(downsampled_ycc)
