#!/bin/bash
#SBATCH --job-name=cnn_mnist         # Job name
#SBATCH --output=output_cnn_mnist.txt # Output file
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --time=00:30:00              # Time limit
#SBATCH --mem=4G                     # Memory limit

# Load modules or set up environment if needed (e.g., Python)

# Execute the Python script
python3 /home/docker/files/cnn_mnist.py
