# Building ODK-AI

This document explains how to build the ODK-AI Docker image from source.

## Prerequisites

Before building the Docker image, you need:

1. Docker installed on your system
2. A GitHub token for authentication (required during the build process)
3. Git to clone the repository

## Building the Image

### 1. Clone the Repository

```bash
git clone https://github.com/cmungall/ontology-coder.git
cd ontology-coder
```

### 2. Set Your GitHub Token

The build process requires a GitHub token to authenticate with GitHub services during the build. You can create a token at [https://github.com/settings/tokens](https://github.com/settings/tokens).

Export your GitHub token as an environment variable:

```bash
export GH_TOKEN=your_github_token
```

!!! warning
    The Makefile will check if this environment variable is set before building. If not set, the build will fail with an error message.

### 3. Run the Build Command

To build the Docker image locally:

```bash
make build
```

This will create a Docker image named `odk-ai:latest` on your local system.

## Build Options

The Makefile has several options that can be used:

- `make build`: Build the Docker image (requires GH_TOKEN)
- `make push`: Build and push the image to DockerHub (as cmungall/odk-ai:latest)
- `make run`: Run the container interactively
- `make test`: Run tests in a scratch directory

## Customizing the Build

If you need to customize the build, you can modify the following settings in the Makefile:

```makefile
IMAGE_NAME = odk-ai
TAG = latest

# Uncomment to force a clean build
#BUILD_OPTS = --no-cache
```

You can also modify the Dockerfile directly to add additional dependencies or change the configuration.

## Building Without Cache

If you want to rebuild everything from scratch (ignoring the cache):

```bash
make build BUILD_OPTS=--no-cache
```

## Troubleshooting

- **Error: "GH_TOKEN environment variable is not set"** - You need to set your GitHub token as described above
- **Docker build errors** - Make sure Docker is running and you have sufficient permissions
- **Network errors during build** - Check your internet connection, as the build process downloads packages