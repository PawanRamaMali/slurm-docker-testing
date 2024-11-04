#!/bin/bash
#SBATCH --job-name=python_job          # Job name
#SBATCH --output=python_output.txt     # Output file
#SBATCH --ntasks=1                     # Run a single task
#SBATCH --time=00:01:00                # Time limit hh:mm:ss
#SBATCH --mem=100M                     # Memory limit

# Run the Python script
python3 my_python_script.py
