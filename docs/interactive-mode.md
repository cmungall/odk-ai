# Interactive Mode

!!! tip "Some knowledge required"
    Currently we assume some knowledge of BOTH ODK and Claude Code.
    Check back later for more user-friendly docs!


ODK-AI is designed to be used interactively, allowing you to work with Claude directly through a terminal interface on your ontology projects.

## Starting an Interactive Session

First, navigate to your ontology project directory 

```
cd ~/repos/my-ontology
```



and run the container:

```bash
docker run -v $PWD:/work \
  -e ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY \
  -e PERPLEXITY_API_KEY=$PERPLEXITY_API_KEY \
  -e EMAIL=your.email@example.com \
  -it --rm cmungall/odk-ai:latest bash
```

This command:

- Mounts your current directory to `/work` in the container
- Passes your Anthropic API key for Claude access
- Optionally passes a Perplexity API key for web search and deep research queries (optional)
- Provides your email (for using NCBI eutils services) (optional)
- Opens an interactive bash shell


## Using Claude

Once inside the container, start a Claude session by running:

```bash
claude
```

You will see this:

```
╭────────────────────────────────────────────╮
│ ✻ Welcome to Claude Code research preview! │
╰────────────────────────────────────────────╯


  ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗
 ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝
 ██║     ██║     ███████║██║   ██║██║  ██║█████╗  
 ██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝  
 ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗
  ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
  ██████╗ ██████╗ ██████╗ ███████╗                
 ██╔════╝██╔═══██╗██╔══██╗██╔════╝                
 ██║     ██║   ██║██║  ██║█████╗                  
 ██║     ██║   ██║██║  ██║██╔══╝                  
 ╚██████╗╚██████╔╝██████╔╝███████╗                
  ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
```

and options to configure

Follow the authentication instructions. On first run, you'll need to authenticate with Anthropic's servers.

Note that because you are in Docker it won't be able to open a web browser. It will give you a URL to open.
Follow the instructions.

!!! warning "Proceed with caution!"
    Use of claude code for creating ontologies or code can be costly, please proceed cautiously!
    Check back later on how to use this via proxies

It will store these settings in `~/.claude/` (TODO: these will be lost when you exit the container -- see below)

After authentication, you can interact with Claude directly through the terminal. Claude has access to:

- Your ontology files (standard ODK location, `src/ontology/`)
- GitHub CLI (`gh`) for issue/PR management
- ROBOT and other ODK tools
- OBO scripts for manipulating ontology files

!!! tip "OBO Format is assumed"
    Currently the pre-defined workflow works best for ontologies that have their source in `.obo` format.
    (You should be doing this anyway, obo format is best for humans AND AI)
    You can try modifying the workflow for e.g. `.ofn` but we don't support this yet

## GitHub authentication

For best experience, type

`gh auth login`

And follow the instructions to authenticate. this will allow Claude Code to create PRs and comment on issues/PRs on your behalf.

## Example Interactions

Here are some example commands you might use with Claude:

```
# Ask Claude to summarize an issue
claude "Summarize issues 123"

# Request Claude to add a new term
claude "Add a new term for 'cardiac muscle cell' with appropriate relationships and definitions"

# Ask Claude to fix an issue
claude "Fix issue 456"


# Ask Claude to review a PR
claude "Review PR 567. Post comments on the PR, and then if you think it is ready, approve and merge"

```

!!! warning "Proceed with caution!"
    By default, we give Claude Code a lot of permissions.
    Proceed with caution!

## Working with Ontology Files

Claude is configured to work with `.obo` format files. It uses some scripts from [obo-scripts](https://github.com/cmungall/obo-scripts). While these scripts are dated, they are much faster than many more modern methods.

When editing ontologies:

1. Claude will use `obo-checkout.pl` to extract specific terms for editing into `terms/`
2. Changes are made to the extracted files
3. Claude will use `obo-checkin.pl` to merge changes back into the main ontology file

This workflow helps manage the complexity of large ontology files.

## Configuration Files

Claude's configuration is stored in:

```
/root/.claude.json
```

After authentication, you may want to save this configuration for future sessions. See the [Configuration](configuration.md) section for details on persisting your settings between container runs.