FROM nixos/nix
RUN nix-channel --update
WORKDIR /code
COPY shell.nix shell.nix
RUN nix-env -i -f shell.nix
