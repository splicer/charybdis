#! /usr/bin/env python2.6

from floating_point import downsampled_ycc_from_rgb
import random
import subprocess
import re

def run_naive_fixed_point(test_vector):
    args = [str(item) for sublist in test_vector for item in sublist]
    result = subprocess.Popen(["naive_fixed_point/unix/test"] + args, stdout=subprocess.PIPE).communicate()[0]
    return [int(i) for i in re.split(r"\s+", result.strip())]

random.seed()
for i in xrange(10):
    test_vector = [[random.randint(0, 255) for x in range(3)] for y in range(4)]
    #test_vector = [[255,255,255],[0,0,0],[0,0,0],[0,0,0]]
    print test_vector
    print run_naive_fixed_point(test_vector)
    print downsampled_ycc_from_rgb(*test_vector)
