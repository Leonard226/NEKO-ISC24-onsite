#!/bin/bash
echo "Clearing Caches..."
sudo pdsh -w sbrinz1,sbrinz2,sbrinz3,sbrinz4,sbrinz5 "sync; echo 3 > /proc/sys/vm/drop_caches"
echo "Done clearing Caches"
