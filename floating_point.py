#! /usr/bin/python2.6

def ycc_from_rgb(rgb):
    y = sum((
        65.7377882352941/256 * rgb[0],
        129.0571294117647/256 * rgb[1],
        25.0639058823529/256 * rgb[2],
        16))
    cb = sum((
        -37.9450869960784/256 * rgb[0],
        -74.4941286901961/256 * rgb[1],
        112.4392156862745/256 * rgb[2],
        128))
    cr = sum((
        112.4392156862745/256 * rgb[0],
        -94.1539006745098/256 * rgb[1],
        -18.2853150117647/256 * rgb[2],
        128))
    return (y, cb, cr)

def downsampled_ycc_from_rgb(rgb1, rgb2, rgb3, rgb4):
    ycc1 = ycc_from_rgb(rgb1)
    ycc2 = ycc_from_rgb(rgb2)
    ycc3 = ycc_from_rgb(rgb3)
    ycc4 = ycc_from_rgb(rgb4)
    avg_cb = sum((ycc1[1], ycc2[1], ycc3[1], ycc4[1])) / 4
    avg_cr = sum((ycc1[2], ycc2[2], ycc3[2], ycc4[2])) / 4
    return [int(round(x)) for x in (ycc1[0], ycc2[0], ycc3[0], ycc4[0], avg_cb, avg_cr)]

if __name__ == '__main__':
    import sys

    if len(sys.argv) != 13:
        raise Exception("please supply 12 decimal values")
    rgb_pixels = [int(x) for x in sys.argv[1:]]
    ycc = downsampled_ycc_from_rgb(rgb_pixels[0:3], rgb_pixels[3:6], rgb_pixels[6:9], rgb_pixels[9:12])
    print " ".join([str(i) for i in ycc])
