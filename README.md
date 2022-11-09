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

## Environments

 - [openmpi](openmpi): with clang 14
 

## Usage

## Containers

Most of these containers will be pre-built and you can pull them down.
Browse the packages alongside the repository here to see what is available!
We will eventually have a web interface to better show you this set.

For Nix derived containers, the package set included are installed to the
defualt nix-env, meaning you can shell inside and find them on your path.

## Devbox

Devbox is a local development environment you can also use for any container
here!  To test out devbox, you can install [devbox](https://github.com/jetpack-io/devbox).
You will also need to [install Nix](https://nixos.org/download.html).

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


