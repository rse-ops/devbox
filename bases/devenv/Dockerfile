FROM nixos/nix
RUN nix-channel --update && \
    mkdir -p ~/.config/nix && \
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
RUN nix profile install github:cachix/cachix/latest && \
    cachix use devenv && \
    nix profile install github:cachix/devenv/v0.2
ENV NIXPKGS_ALLOW_UNFREE=1
WORKDIR /code
COPY devenv.yaml devenv.yaml
COPY devenv.nix devenv.nix
RUN devenv ci
RUN devenv shell -- echo "Installing packages"
# Shell into container and do: devbox shell
