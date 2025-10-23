#!/bin/bash
# Check if pyiron directory exists, if not create it
if [ ! -d "pyiron" ]; then
    echo "Creating pyiron directory..."
    mkdir -p pyiron/calculation
fi

cd pyiron

# Check if calculation directory and tar.gz files exist
if [ ! -d "calculation" ] || [ ! "$(ls -A calculation/*.tar.gz 2>/dev/null)" ]; then
    echo "No calculation/*.tar.gz files found. Skipping dataset import."
    exit 0
fi

for ds in $(ls calculation/*.tar.gz); do 
    cp ${ds} .
    cp calculation/export.csv .
    file=$(basename ${ds} .tar.gz)
    python << EOF
from pyiron_base import Project
Project("calculation").unpack("${file}")
EOF
    rm $(basename ${ds})
    rm export.csv
done
