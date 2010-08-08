#! /usr/bin/env python2.6

from floating_point import downsampled_ycc_from_rgb
import random
import subprocess
import re

def fixed_point(test_vector):
    args = [str(item) for sublist in test_vector for item in sublist]
    result = subprocess.Popen(["c_code/unix_fixed_point_with_io/test"] + args, stdout=subprocess.PIPE).communicate()[0]
    return [int(i) for i in re.split(r"\s+", result.strip())]

random.seed()
num_successes = 0
num_tests = 10000
for i in xrange(num_tests):
    test_vector = [[random.randint(0, 255) for x in range(3)] for y in range(4)]
    nfp = fixed_point(test_vector)
    ideal = downsampled_ycc_from_rgb(*test_vector)
    if nfp != ideal:
        print test_vector
        print "ideal:       %s" % str(ideal)
        print "fixed_point: %s" % str(nfp)
        pass
    else:
        num_successes += 1
print "passed %d / %d tests" % (num_successes, num_tests)
