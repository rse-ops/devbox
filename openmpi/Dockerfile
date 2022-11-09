FROM nixos/nix
ARG clang_version=14
ENV clang_version=$clang_version
RUN nix-channel --update && \
    nix-env -i openmpi && \
    nix-env -iA nixpkgs.clang_${clang_version}
WORKDIR /code
