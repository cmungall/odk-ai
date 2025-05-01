# How to provide instructions to an AI

To use odk-ai effectively you should have a CLAUDE.md (or equivalent) in the root of your repo.

If you start up odk-ai in the root folder of an ODK-style repo, it will create one for you (if one does not exist). Note
that you are still expected to check this in.

You can generate one yourself like this (in the image):

```bash
jinja2 /root/CLAUDE.md.jinja2 -D "project_id=<<my-ont>>"  > CLAUDE.md
```

Substituting the name of your ontology

You will still likely want to customize this!