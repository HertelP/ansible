# sshd on archlinux
FROM	 archlinux:latest

ARG USER=test_user
RUN	 pacman -Syy

RUN	 pacman -S --noconfirm openssh
RUN	 pacman -S --noconfirm git ansible which sudo base-devel base vi linux-firmware linux nvim
RUN	 pacman -Syu --noconfirm

# Generate host keys
# RUN  /usr/bin/ssh-keygen -A

# Expose tcp port
# EXPOSE	 22

RUN useradd -m -s /bin/bash ${USER}

RUN --mount=type=secret,id=user_password \
    echo "${USER}:$(cat /run/secrets/user_password)" | chpasswd

RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${USER}
WORKDIR /home/${USER}

ADD /local.yml /home/${USER}/local.yml
ADD /tasks /home/${USER}/tasks
ADD .ssh /home/${USER}/.ssh
ADD .pass_keys /home/${USER}/.pass_keys
CMD ["/bin/bash"]
