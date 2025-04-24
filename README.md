# ontology-coder

Docker container for running claude-code with ontologies. This is designed to be executed either interactively or in "headless" mode.

The container extends ODK, which means any tool available to ODK (e.g. robot) is avaialble for `claude-code` to use.

## Running

Use `run.sh`, or just do this:

`docker run -it --rm ontology-coder:latest bash`

## Interactive use

You can use this just as you would use claude code

It might not be able to open a browser [TODO], so follow instructions and enter code.

Config will be in `/root/.claude.json`

## Headless mode

- create ontologies in YOLO mode
- use in github actions

## TODO

- standardize `CLAUDE.md`
- explore other assistants (`cborg-code`, `aider`)
