#! /usr/bin/env python2.6

from floating_point import downsampled_ycc_from_rgb
import random
import subprocess

def run_naive_fixed_point(test_vector):
    args = [item for sublist in test_vector for item in sublist]
    #args = " ".join([str(i) for i in args])
    #os.system("echo '%s' | ./naive_fixed_point/unix/test" % args)
    print subprocess.check_output(["./naive_fixed_point/unix/test"] + args)

random.seed()
for i in xrange(10):
    test_vector = [[random.randint(0, 255) for x in range(3)] for y in range(4)]
    #print test_vector
    run_naive_fixed_point(test_vector)
    #print downsampled_ycc_from_rgb(*test_vector)
