# ODK-AI Development Guide

This repository contains the source code and build files for creating the ODK-AI Docker image, which helps ontology developers use Claude with their ontology repositories.

## Repository Structure

- `Makefile` - Controls the build process for the Docker image
- `Dockerfile` - Defines the ODK-AI Docker image
- `docs/` - MkDocs documentation (for end users of the image)
- `bin/` - Scripts and utilities
- `template/` - Template files that get copied to user ontology repos

## Building the Docker Image

To build the image locally:

```bash
# Required: GitHub token for authentication
export GH_TOKEN=your_github_token
make build
```

## Documentation Development

- Documentation is built using MkDocs
- Use `uv` (modern Python package manager) to run MkDocs:

```bash
uv run mkdocs serve
```

## Testing the Image

You can test the image with:

```bash
make test
```

Or with a specific repository:

```bash
make test-repos/obophenotype/uberon
```

## Publishing the Image

To push the image to Docker Hub:

```bash
make push
```

Note: Only authorized contributors can push to the official image.
