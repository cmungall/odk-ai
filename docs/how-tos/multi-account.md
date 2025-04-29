# Multi-account setup

Assume you have the following GitHub accounts

- `@ont-coder-agent` - you use this primarily as the account for editing the ontology and making PRs
- `@ont-review-agent` - reviews PRs, plans tasks and makes issues

## Directory setup

```
mkdir repos
mkdir repos/ont-coder-agent
mkdir repos/ont-review-agent
```

Each folder will belong to a different agent; they can have multiple repos cloned.

!!! tip "Convenience tip"
    Authentication and authorization is easier if you have a Chrome profile for each account

## Setting up `@ont-coder-agent`

```bash
cd repos/ont-coder-agent
GITHUB_NAME=ont-coder-agent \
  odkai.sh
```

You will now be in the odkai docker shell. Next we will authenticate:

```bash
gh auth login
```

follow the instructions (being sure to do this for the right account), copy the code

Then, in order to make PRs:

`gh auth setup-git`

Note that your configuration should be saved between sessions

Next start `claude` (or your favorite terminal coding agent):

`claude`

You will need to authenticate Claude. Note this is different from GitHub authentication, and you
should use whichever Chrome profile you use for your Anthropic account.

This config should persist between ODK-AI invocations.

Next, you can clone as many ontologies as you want the coder to contribute to. Depending
on how the repo is set up, you may wish to work on your own fork:

`git clone https://github.com/ont-coder-agent/my-ont.git`

Or on origin:

`git clone https://github.com/my-ontology-org/my-ont.git`

Now change to that directory and set up `CLAUDE.md`

`jinja2 /root/CLAUDE.md.jinja2 -D "project_id=<<my-ont>>"  > CLAUDE.md`

Set up git usernames:

```
git config user.name "dragon-ai-agent"
git config user.email "cmungall+dragon-ai-agent@gmail.com"
```

## Setting up `@ont-review-agent`

As above, but modifying the handle:

```bash
cd repos/ont-review-agent
<<run docker command>>
gh auth login
```

being sure to authenticate as `@ont-review-agent`

## Workflow

You will likely want to have two terminal windows open at the same time. This could be from your IDE or in a standard Terminal app.
Having some way to distinguish them visually might help.


