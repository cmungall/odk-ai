# Getting Started

## Building

Images are pushed to `cmungall/odk-ai` (https://hub.docker.com/r/cmungall/odk-ai) but these may be stale. 

You can check out this repo and build locally:

```bash
make build
```

## Initial Setup and Interactive Use

You will need an API key for Claude.

First `cd` to the directory that is top level of your ODK-compliant ontology repo:

```bash
docker run -v $PWD:/work -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY -e PERPLEXITY_API_KEY=$PERPLEXITY_API_KEY -e EMAIL=yourname@gmail.com -it --rm cmungall/odk-ai:latest bash
```

On the first run, a `CLAUDE.md` will be placed in the top level (unless one is there already). You will need to customize this. You can do this manually or let Claude do it.

Once in the shell, you can type:

```bash
claude
```

Follow the instructions to authenticate.

Config will be in `/root/.claude.json` (TODO: persist this)

You can use this just as you would use claude code.