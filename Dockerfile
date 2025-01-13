FROM rockylinux/rockylinux:9.5

# Set Variables
ARG USER_ID=myuser
ARG USER_PASSWORD=password
ENV HOME=/home/${USER_ID}

# Update package and install git, vim, sudo, words
RUN set -ex && \
    dnf -y update && \
    dnf -y install vim git sudo words && \
    dnf clean all

# Create user and set password
RUN set -ex && \
    useradd -m ${USER_ID} && \
    echo "${USER_ID}:${USER_PASSWORD}" | chpasswd && \
    echo "${USER_ID} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER_ID} && \
    chmod 0440 /etc/sudoers.d/${USER_ID} && \
    chown -R ${USER_ID}:${USER_ID} /home/${USER_ID}

# switch user
USER ${USER_ID}
WORKDIR ${HOME}

# Download exercise files
RUN git clone https://github.com/gilbutITbook/080342.git efficient_linux_at_the_command_line

CMD ["/bin/bash"]