# Use the latest Ubuntu image
FROM ubuntu:20.04

# Install tzdata first to avoid errors
RUN apt-get update -y && \
    apt-get install -y tzdata

# Set the timezone non-interactively
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend=noninteractive tzdata

# Update the package list and install necessary packages
RUN apt-get update -y && \
    apt-get install -y \
    doxygen \
    texlive-latex-base \
    dvipng \
    graphviz \
    python3-pip \
    python3-venv \
    git \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt /requirements.txt

# Set up a virtual environment
RUN python3 -m venv /venv

# Activate the virtual environment and install the required Python packages
RUN /venv/bin/pip install --no-cache-dir -r /requirements.txt

# Set the working directory (optional, if necessary for your project)
WORKDIR /root

# Expose port 8081 (if the app listens on this port)
EXPOSE 8081

# Set the entrypoint to run commands passed at runtime
CMD ["/bin/bash"]
