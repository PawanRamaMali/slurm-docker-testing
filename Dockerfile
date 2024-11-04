# Use the base image
FROM nathanhess/slurm:full

# Switch to root user to install packages
USER root

# Install SSH server and sudo
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    mkdir /var/run/sshd && \
    ssh-keygen -A  # Generate all necessary SSH host keys

# Create a user for SSH access
RUN useradd -ms /bin/bash dockeruser && \
    echo 'dockeruser:dockerpassword' | chpasswd && \
    echo 'dockeruser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Copy a custom slurm.conf
COPY slurm.conf /etc/slurm/slurm.conf

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]

# Switch back to the default user if necessary
# USER slurm
