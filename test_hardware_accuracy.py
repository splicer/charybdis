#! /usr/bin/env python2.6

from floating_point import downsampled_ycc_from_rgb
import random
import re

def ycc_from_rgb(rgb):
    y = sum((
        int(round(65.738/256 * rgb[0])),
        int(round(129.057/256 * rgb[1])),
        int(round(25.064/256 * rgb[2])),
        16)) # 8-bit
    cb = sum((
        int(round(-37.945/256 * rgb[0] * 2)),
        int(round(-74.494/256 * rgb[1] * 2)),
        int(round(112.439/256 * rgb[2] * 2)),
        128 * 2)) # 9-bit
    cr = sum((
        int(round(112.439/256 * rgb[0] * 2)),
        int(round(-94.154/256 * rgb[1] * 2)),
        int(round(-18.285/256 * rgb[2] * 2)),
        128 * 2)) # 9-bit
    return (y, cb, cr)

def hardware(rgb1, rgb2, rgb3, rgb4):
    ycc1 = ycc_from_rgb(rgb1)
    ycc2 = ycc_from_rgb(rgb2)
    ycc3 = ycc_from_rgb(rgb3)
    ycc4 = ycc_from_rgb(rgb4)
    avg_cb = int(round(sum((ycc1[1], ycc2[1], ycc3[1], ycc4[1])) / 8.0)) # 9-bit -> 8-bit
    avg_cr = int(round(sum((ycc1[2], ycc2[2], ycc3[2], ycc4[2])) / 8.0)) # 9-bit -> 8-bit
    return [ycc1[0], ycc2[0], ycc3[0], ycc4[0], avg_cb, avg_cr]

random.seed()
num_successes = 0
num_tests = 500000
error_vector = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
for i in xrange(num_tests):
    test_vector = [[random.randint(0, 255) for x in range(3)] for y in range(4)]
    nfp = hardware(*test_vector)
    ideal = downsampled_ycc_from_rgb(*test_vector)
    if nfp != ideal:
        for i in xrange(6):
            error_vector[i] += abs(nfp[i] - ideal[i])
    else:
        num_successes += 1
error_vector = [x/num_tests for x in error_vector]
print "passed %2.3f %% of %d tests" % (num_successes * 100.0 / num_tests, num_tests)
print "average approximation error vector:\n%s" % error_vector
