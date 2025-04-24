# ontology-coder

Docker container for running claude-code with ontologies. This is designed to be executed either interactively or in "headless" mode.

The container extends ODK, which means any tool available to ODK (e.g. robot) is avaialble for `claude-code` to use.

__CAVEATS__

* workflow only worked out for ontologies that keep their source in `.obo`
* probably very buggy...

## Building

Images are pushed to `cmungall/odk-ai` (https://hub.docker.com/r/cmungall/odk-ai) but these may be stale. For now we recommend building locally.

`make build`


## Running

Use `run.sh` (DOES NOT WORK), or just do this:

`docker run -v $PWD:/work -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY -it --rm ontology-coder:latest bash`

TODO: 

 * claude config in `/root/.claude.json` not persisted between sessions 

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
