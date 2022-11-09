#!/usr/bin/env python3

# This script does the following.
# 1. Reads in a container URI and gets all tags (versions)
# 2. Also takes an optional size to share
# 3. Generates metadata for a markdown (yaml) header section

import argparse
from datetime import datetime
import logging
import os
import subprocess
import sys
import requests
from jinja2 import Environment, FileSystemLoader, select_autoescape

logging.basicConfig(level=logging.INFO)

# We want the root
here = os.path.abspath(os.path.dirname(__file__))
templates = os.path.join(here, "templates")

env = Environment(
    autoescape=select_autoescape(["html"]), loader=FileSystemLoader(templates)
)


def write_file(content, filename):
    with open(filename, "w") as fd:
        fd.write(content)


def get_parser():
    parser = argparse.ArgumentParser(
        description="RADIUSS Docker Images Library Builder"
    )

    description = "Generate a library entry for a container"
    subparsers = parser.add_subparsers(
        help="actions",
        title="actions",
        description=description,
        dest="command",
    )

    gen = subparsers.add_parser("gen", help="generate a library entry")
    gen.add_argument("container", help="container unique resource identifier.")
    gen.add_argument(
        "--outdir",
        "-o",
        dest="outdir",
        help="Write test results to this directory",
    )
    gen.add_argument("--size", dest="size", help="Size of container in MB", type=int)

    gen.add_argument(
        "--root",
        dest="root",
        help="Root where tag folders are located",
    )
    gen.add_argument(
        "--dockerfile",
        dest="dockerfile",
        help="Root where Dockerfile is located (that might be shared by > tag)",
    )

    return parser


def main():
    parser = get_parser()

    def help(return_code=0):
        parser.print_help()
        sys.exit(return_code)

    # If an error occurs while parsing the arguments, the interpreter will exit with value 2
    args, extra = parser.parse_known_args()
    if not args.command:
        help()

    # Get tags for the container
    response = requests.get("https://crane.ggcr.dev/ls/" + args.container)
    if response.status_code != 200:
        sys.exit("Issue retrieving manifest for %s" % args.container)
    tags = [x for x in response.text.split("\n") if x]

    # Prepare set of metadata for each
    metadata = {tag: {} for tag in tags}

    # manifests
    for tag in tags:
        metadata[tag]["manifest"] = "https://crane.ggcr.dev/manifest/" + args.container + ":" + tag

    # Prepare paths to dockerfiles
    if args.root:
        for tag in tags:
            metadata[tag]["dockerfile"] = os.path.join(args.root, tag, "Dockerfile")
    elif args.dockerfile:
        for tag in tags:
            metadata[tag]["dockerfile"] = os.path.join(args.dockerfile, "Dockerfile")        

    # Render into template!
    result = env.get_template("template.md").render(
        metadata=metadata,
        size=args.size,
        container=args.container,
        versions=tags,
        name=os.path.basename(args.container),
        updated_at=datetime.now(),
    )
    print(result)
    filename = os.path.join(args.outdir, "%s.md" % args.container.replace("/", "-"))
    write_file(result, filename)


if __name__ == "__main__":
    main()
