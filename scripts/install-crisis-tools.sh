#!/bin/bash

# Set up crisis tools: https://www.brendangregg.com/blog/2024-03-24/linux-crisis-tools.html
sudo apt-get install \
  procps \
  util-linux \
  sysstat \
  iproute2 \
  numactl \
  tcpdump \
  linux-tools-common \
  bpfcc-tools \
  bpftrace \
  trace-cmd \
  nicstat \
  ethtool \
  tiptop \
  cpuid \
  msr-tools