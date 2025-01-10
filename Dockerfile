FROM rockylinux/rockylinux:9.5

# Set environments
ENV USER_NAME=myuser
ENV USER_PASSWORD=password
ENV HOME=/home/${USER_NAME}

# Update package and install git, vim, sudo, words
RUN set -ex && \
    dnf -y update && \
    dnf -y install vim git sudo words && \
    dnf clean all

# Create user and set password
RUN set -ex && \
    useradd -m ${USER_NAME} && \
    echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER_NAME} && \
    chmod 0440 /etc/sudoers.d/${USER_NAME} && \
    chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}

# switch user
USER ${USER_NAME}

# Download exercise files
WORKDIR ${HOME}
RUN git clone https://github.com/gilbutITbook/080342.git efficient_linux_at_the_command_line

CMD ["/bin/bash"]
