# Use the base image
FROM nathanhess/slurm:full

# Switch to root user
USER root

# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Generate SSH host keys
RUN ssh-keygen -A
# RUN /usr/sbin/sshd -D

# Create a user for SSH access
RUN useradd -ms /bin/bash dockeruser && \
    echo 'dockeruser:dockerpassword' | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]

# Switch back to the default user (if needed)
# USER slurm
