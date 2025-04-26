# Configuration

## Preserving Configs

After authentication in Docker:

```bash
cp -pr ~/.config .
cp ~/.claude.json .
```

Then the next time you start the container:

```bash
cp -pr .config ~
cp .claude.json ~
```

## GitHub Actions Configuration

*Coming soon*