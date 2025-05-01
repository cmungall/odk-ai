# Headless Mode

!!! warning "Proceed with caution!"
    Using coding tools in headless mode with long running processes can
    lead to racking up API charges

ODK-AI can be used in a non-interactive headless mode, which is useful for:

- Creating ontologies in YOLO mode
- Using in GitHub Actions

You can run Claude with specific instructions via command line:

```bash
claude -p "<YOUR INSTRUCTIONS>" --output-format stream-json
```

For example:

```bash
claude -p "fix issue 123" --output-format stream-json
```

Your `CLAUDE.md` has instructions on how to read an issue (using `gh issue view`, which is in this docker image, thanks to ODK). It should read the issue, try to solve it, and make a branch and PR.

You should keep an eye on what it is doing. Currently there are no guardrails to stop it racking up charges as it goes down rabbit holes.

## Example

Here's an example of a PR created by Claude:

* [uberon#3508](https://github.com/obophenotype/uberon/pull/3508)