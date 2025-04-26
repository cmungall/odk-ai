# ODK-AI: Coding Ontologies Using AI Tools

ODK-AI is a Docker container for running claude-code (and in future, similar tools) with ontologies.
It is designed to be executed either interactively or in "headless" mode.

For more details, see the [documentation](https://cmungall.github.io/odk-ai/) or this [tutorial (in progress)](https://docs.google.com/presentation/d/1_ciRsRqs0hDtjcFBwZ9UhQhiQ3tlB_dOfQVEp5QR8LU/edit?slide=id.g24560ef6bb7_0_84#slide=id.g24560ef6bb7_0_84).

The container extends [ODK](https://github.com/INCATools/ontology-development-kit/), which means any tool available to ODK (e.g. ROBOT) is available for `claude-code` to use.

## Quick Start

```bash
# Pull from Docker Hub
docker run -v $PWD:/work -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY -it --rm cmungall/odk-ai:latest

# Or build locally
make build
docker run -v $PWD:/work -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY -it --rm odk-ai:latest
```

When you first run the container, it will automatically create a CLAUDE.md file in your working directory with instructions for the AI assistant.

## Documentation

See the [full documentation](https://cmungall.github.io/odk-ai/) for:
- Detailed setup instructions
- Usage guides for interactive and headless modes
- Configuration options 
- Examples and roadmap

## Example Usage

Here's an example of a PR created by Claude:
* [uberon#3508](https://github.com/obophenotype/uberon/pull/3508)

## Known Limitations

* Workflow is primarily tested with ontologies that keep their source in `.obo` format
* This project is in early development and may have bugs
