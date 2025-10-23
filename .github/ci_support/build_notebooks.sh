#!/bin/bash
set -e  # Exit on any error

echo "Starting notebook build process..."

# pyiron config 
echo "Setting up pyiron configuration..."
python .github/ci_support/pyironconfig.py

# import dataset
echo "Importing datasets..."
bash .github/ci_support/import_dataset.sh

# register jupyter kernel
echo "Registering Jupyter kernel..."
python -m ipykernel install --user --name python3 --display-name "Python 3"

# verify papermill is available
echo "Verifying papermill installation..."
python -c "import papermill; print('papermill version:', papermill.__version__)"

# execute notebooks
echo "Executing notebooks..."
current_dir=$(pwd)
i=0;
for f in $(find . -name "*.ipynb" | sort -n); do
    echo "Processing notebook: $f"
    cd $(dirname $f);
    notebook=$(basename $f);
    if papermill ${notebook} ${notebook%.*}-out.${notebook##*.} -k "python3"; then
        echo "Successfully executed: $notebook"
    else
        echo "Failed to execute: $notebook"
        i=$((i+1));
    fi
    cd $current_dir;
done;

# push error to next level
if [ $i -gt 0 ]; then
    echo "Failed to execute $i notebook(s)"
    exit 1;
fi;

echo "All notebooks executed successfully!"
