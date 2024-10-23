# slurm-docker-testing
 testing-slurm-via-local-docker

docker build -t slurm-docker .
docker run -d --name slurm-container --privileged slurm-docker


# Alternative 
docker pull nathanhess/slurm:full