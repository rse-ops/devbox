FROM nixos/nix
RUN nix-channel --update
RUN wget https://github.com/jetpack-io/devbox/releases/download/0.1.0/devbox_0.1.0_linux_amd64.tar.gz && \
    tar -xzvf devbox_0.1.0_linux_amd64.tar.gz && \
    chmod +x devbox && \
    mv devbox /usr/bin
ENV PATH=/usr/bin:$PATH
WORKDIR /code
COPY devbox.json devbox.json
RUN devbox shell -- echo "Installing packages"
# RUN nix-env -i -f shell.nix
# RUN $HOME/.nix-profile/bin/nix-env -i -f shell.nix
