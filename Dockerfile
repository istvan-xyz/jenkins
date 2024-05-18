FROM jenkins/jenkins

USER root

# Docker
RUN export DEBIAN_FRONTEND=noninteractive && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt update && \
    apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --assume-yes

# Additional depedencies
RUN apt install -fuy ncftp

# Cleanup
RUN apt-get -qq -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*