#! /bin/bash

for PROJECT in c_code/unix_*; do
    pushd $PROJECT
    make clean
    make
    if [ $? -ne 0 ]; then
        echo "*** Failed to build ${PROJECT}! ***"
        exit 1
    fi
    popd
done
