# slurm-docker-testing
 testing-slurm-via-local-docker

docker build -t slurm-docker .
docker run -d --name slurm-container --privileged slurm-docker


# Alternative 
docker pull nathanhess/slurm:full

docker run -it --rm nathanhess/slurm:full

## Create a SLURM Job Script

```
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

## Make the Script Executable
```
chmod +x myjobscript.sh
```
## Submit the Job to SLURM
```
sbatch myjobscript.sh
```

```
squeue
```
## Output
output.txt


## Create a Python File

```
cat <<EOF > my_python_script.py
import time

# Sleep for 5 seconds
time.sleep(5)

# Print a message after the delay
print("Python script completed after 5 seconds!")
EOF
```

```
chmod +x my_python_script.py

```
## Modify the SLURM Job Script to Run the Python Script
```
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


# for MNIST Dataset

docker run -u root -it --rm nathanhess/slurm:full

```
apt-get update
apt-get install -y python3-pip
pip3 install tensorflow
```

```
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

```
sbatch run_cnn_mnist.sh

```

```
squeue
```
