# Surface energies (pyiron_workflow)
This repository demonstrates computing surface energies using the `pyiron_workflow` framework. The workflow is engine-agnostic and is demonstrated here with LAMMPS.

## Installation
Create and activate the conda environment from the provided `environment.yml`:

```bash
# Using mamba (recommended)
mamba env create -f environment.yml -n pyiron-workflow-surface-energies
conda activate pyiron-workflow-surface-energies

# Or using conda
conda env create -f environment.yml -n pyiron-workflow-surface-energies
conda activate pyiron-workflow-surface-energies

# To update an existing environment after changes to environment.yml
mamba env update -f environment.yml -n pyiron-workflow-surface-energies
# or
conda env update -f environment.yml -n pyiron-workflow-surface-energies
```

## Run the workflow
Open and execute the notebook `surface_energy.ipynb` in this directory:

```bash
jupyter lab
# or
jupyter notebook
```

Then open `surface_energy.ipynb` and run all cells.