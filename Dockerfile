FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    munge \
    libmunge-dev \
    slurm-wlm \
    slurm-client \
    slurm-wlm-basic-plugins \
    curl \
    vim

# Configure Munge for authentication
RUN /usr/sbin/create-munge-key && \
    chown -R munge: /etc/munge /var/lib/munge /var/log/munge && \
    chmod 0700 /etc/munge /var/lib/munge /var/log/munge

# Configure SLURM
COPY slurm.conf /etc/slurm-llnl/slurm.conf
RUN mkdir -p /var/spool/slurmctld && \
    chown slurm: /var/spool/slurmctld && \
    mkdir -p /var/log/slurm && \
    chown slurm: /var/log/slurm

# Start services
CMD /usr/sbin/munged && /usr/sbin/slurmctld && /usr/sbin/slurmd && tail -f /dev/null
