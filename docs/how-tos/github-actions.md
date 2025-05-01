# Setting up GitHub actions


!!! warning "Proceed with extreme caution!"
    Be sure to configure GitHub actions such that only trusted users can trigger AI jobs.
    Currently this configuration requires ADVANCED knowledge of actions.


See `odkai.yml` in `templates/`. Put this into your workflows dir. Also be sure that you have checked in:

- a `CLAUDE.md` file
- `.claude/settings.json` with default permissions
