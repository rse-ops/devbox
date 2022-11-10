# Nix DevBox

This is an experiment to use [Nix](https://search.nixos.org/packages) packages 
and possibly [devbox](https://github.com/jetpack-io/devbox)
to provide working environments and containers! We will be using the standard
set linked above, along with the Nix User
Repository "NUR" at [rseops](https://github.com/rse-ops/nix), shown also
in the community listing [here](https://nur.nix-community.org/repos/rseops/).

I like this approach because I think it's the best of both worlds - easy
binaries with nix, but provided in containers so I don't need to worry about
dumping them all onto my local hard drive!

> How does it work?

Each diretory here has a `shell.nix` that defines a Nix environment.
We build every environment against every base container (e.g., one vanilla,
and one for VSCode) in [bases](bases) using [uptodate](https://github.com/vsoch/uptodate).
That's it!

## Environments

 - [openmpi](openmpi): with clang 14
 
## Usage

Each environment (subfolder here that isn't bases) is built against each base.
The below describes each of the bases, along with a local Devbox environment
(not represented as a base).

Most of these containers will be pre-built and you can pull them down.
Browse the packages alongside the repository here to see what is available!
You an also browse our web interface at [https://rse-ops.github.io/devbox](https://rse-ops.github.io/devbox).

### Vanilla

- [bases/Dockerfile](bases/Dockerfile)

For these containers, they are installed to a nix-os to nix-env, so you
should be able to shell inside and find executables on the path.

### VScode

- [bases/vscode/Dockerfile](bases/vscode/Dockerfile)

These containers are optimized for use in VSCode. You can add a `.devcontainers`
directory as follows:

```bash
.devcontainer/
    devcontaine.json
    Dockerfile
```

Where the `devcontainer.json` can minimally have:

```
{
    "name": "Development environments on your infrastructure",
    "context": "../",
    "dockerFile": "Dockerfile",
}
```

And the Dockerfile can use one of the images as `FROM` and add more packages
or otherwise update the base, and then when the container starts you run `nix-shell`
to get into your enviornment.

## Devbox

- [bases/devbox/Dockerfile](bases/devbox/Dockerfile)

Devbox is a local development environment you can also use for any container
here!  Once you shell into the container, you can either add to your Devbox, or shell
inside:

```bash
$ devbox add <package>
$ devbox shell
```

And you can also use it locally with a devbox.json!
To do this, you can install [devbox](https://github.com/jetpack-io/devbox).
You will also need to [install Nix](https://nixos.org/download.html).
Further instructions for interaction are below.

### Running Environment

Choose an environment subdirectory, e.g.,

```console
$ cd openmpi
$ devbox shell
```

And that's it! Everything in the environment will be on your path.

### Adding to an environment

You can [browse for nix packages](https://search.nixos.org/packages)
and then just do:

```bash
$ devbox add <package>
```

And then shell.

### Creating an Environment

To create a new environment, create your directory, and then:

```bash
$ cd <mypackage>
$ devbox init
$ devbox add <package URI>
```

And please add a README.md with some basic instructions or descriptions!
You are encouraged to add an `uptodate.yaml` that will build over a matrix
of versions, and the automation will discover it.


