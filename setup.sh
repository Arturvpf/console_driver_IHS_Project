#!/bin/bash

make
cd driver/pci
make
sudo rmmod de2i_150
sudo insmod de2i-150.ko
cd ../..
sudo chmod 666 /dev/mydev

