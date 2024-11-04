
# SLURM Docker Testing

This repository demonstrates how to test SLURM job submissions locally using Docker. It includes examples for running basic SLURM jobs, executing Python scripts, and training a CNN on the MNIST dataset.

## Getting Started

### Building and Running SLURM Docker Container

1. Build the Docker image:
   ```bash
   docker build -t slurm-docker .
   ```

2. Run the Docker container:
   ```bash
docker run -d -p 2222:22 --name slurm-ssh-container slurm-docker
docker run -d -p 2222:22 --name slurm-ssh-container custom-slurm-ssh

   ```

### Alternative: Using Pre-built SLURM Image

1. Pull the SLURM Docker image:
   ```bash
   docker pull nathanhess/slurm:full
   ```

2. Run the Docker container:
   ```bash
   docker run -it --rm nathanhess/slurm:full
   docker run -it -u root -v .:/home/docker/ --rm nathanhess/slurm:full
   ```

## Creating and Submitting a SLURM Job

### Create a SLURM Job Script

Create a basic SLURM job script to print "Hello, World":
```bash
cat <<EOF > myjobscript.sh
#!/bin/bash
#SBATCH --job-name=test_job            # Job name
#SBATCH --output=output.txt            # Output file
#SBATCH --ntasks=1                     # Run a single task
#SBATCH --time=00:01:00                # Time limit hh:mm:ss
#SBATCH --mem=100M                     # Memory limit

echo "Hello, World from SLURM job!"
EOF
```

### Make the Script Executable

```bash
chmod +x myjobscript.sh
```

### Submit the Job

```bash
sbatch myjobscript.sh
```

### Check Job Queue

```bash
squeue
```

### View Output

Output will be saved in `output.txt`.

## Running a Python Script with SLURM

### Create a Python Script

```bash
cat <<EOF > my_python_script.py
import time

# Sleep for 5 seconds
time.sleep(5)

# Print a message after the delay
print("Python script completed after 5 seconds!")
EOF
```

### Make the Python Script Executable

```bash
chmod +x my_python_script.py
```

### Modify SLURM Job Script to Run Python Script

```bash
cat <<EOF > myjobscript.sh
#!/bin/bash
#SBATCH --job-name=python_job          # Job name
#SBATCH --output=python_output.txt     # Output file
#SBATCH --ntasks=1                     # Run a single task
#SBATCH --time=00:01:00                # Time limit hh:mm:ss
#SBATCH --mem=100M                     # Memory limit

# Run the Python script
python3 my_python_script.py
EOF
```

### Submit the Job

```bash
sbatch myjobscript.sh
```

### Check Job Queue

```bash
squeue
```

## Running a CNN on MNIST Dataset

### Set Up Environment

Run the following commands inside the container:
```bash
docker run -u root -it --rm nathanhess/slurm:full
```

1. Update and install dependencies:
   ```bash
   apt-get update
   apt-get install -y python3-pip
   pip3 install tensorflow
   ```

### Create and Submit SLURM Script

```bash
cat <<EOF > run_cnn_mnist.sh
#!/bin/bash
#SBATCH --job-name=cnn_mnist         # Job name
#SBATCH --output=output_cnn_mnist.txt # Output file
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --time=00:30:00              # Time limit
#SBATCH --mem=4G                     # Memory limit

# Load modules or set up environment if needed (e.g., Python)
module load python/3.8

# Execute the Python script
python3 /home/docker/cnn_mnist.py
EOF
```

Submit the job:
```bash
sbatch run_cnn_mnist.sh
```

### Check Job Queue

```bash
squeue
```
