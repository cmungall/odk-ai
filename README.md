# odk-ai: coding ontologies using AI tools

odk-ai is a Docker container for running claude-code (and in future, similar tools) with ontologies.
It is designed to be executed either interactively or in "headless" mode.

For more details, see [this tutorial (in progress)](https://docs.google.com/presentation/d/1_ciRsRqs0hDtjcFBwZ9UhQhiQ3tlB_dOfQVEp5QR8LU/edit?slide=id.g24560ef6bb7_0_84#slide=id.g24560ef6bb7_0_84)

The container extends [ODK](https://github.com/INCATools/ontology-development-kit/), which means any tool available to ODK (e.g. ROBOT) is avaialble for `claude-code` to use.

__CAVEATS__

* workflow only worked out for ontologies that keep their source in `.obo`
* probably very buggy...

## Building

Images are pushed to `cmungall/odk-ai` (https://hub.docker.com/r/cmungall/odk-ai) but these may be stale. 

You can check out this repo and build locally:

`make build`

## Initial setup and interactive use

You will need an API key for Claude.

First `cd` to the directory that is top level of your ODK-compliant ontology repo:

`docker run -v $PWD:/work -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY -e PERPLEXITY_API_KEY=$PERPLEXITY_API_KEY -e EMAIL=yourname@gmail.com -it --rm cmungall/odk-ai:latest bash`

On the first run, a `CLAUDE.md` will be placed in the top level (unless one is there already). You will need to customize this. You can do this manually or let Claude do it. 

Once in the shell, you can type:

```
claude
```

Follow the instructions to authenticate

Config will be in `/root/.claude.json` (TODO: persist this)

You can use this just as you would use claude code

## Headless mode

- create ontologies in YOLO mode
- use in github actions

`claude -p "<YOUR INSTRUCTIONS>" --output-format stream-json`

For example:

`claude -p "fix issue 123" --output-format stream-json`

Your `CLAUDE.md` has instructions on how to read an issue (using `gh issue view`, which is in this docker image, thanks to ODK), it should read the issue, try and solve it, and make a branch and PR.

You should keep an eye on what it is doing. Currently there are no guardrails to stop it racking up charges as it goes down rabbit holes...

Example of a PR created by Claude:

* [uberon#3508](https://github.com/obophenotype/uberon/pull/3508)

## Preserving configs

After authentication in Docker

`cp -pr ~/.config .`
`cp ~/.claude.json .`

Then the next time you start the container

`cp -pr .config ~`
`cp .claude.json ~`

TODO - better way to persist

## TODO

- standardize `CLAUDE.md`
- explore other assistants (`cborg-code`, `aider`)
- adapt for other semantic artefacts (KGs, LinkML schemas)
