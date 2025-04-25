#!/bin/bash
set -e

# Initialize CLAUDE.md from template only if it doesn't exist
if [ ! -f /work/CLAUDE.md ]; then
  echo "Initializing CLAUDE.md from template..."
  # Determine project ID from directory name
  PROJECT_ID=$(basename /work)
  # Process template with jinja2
  # jinja2 /root/CLAUDE.md.jinja2 -D "project.id=$PROJECT_ID" > /work/CLAUDE.md
  cp /root/CLAUDE.md.jinja2 /work/CLAUDE.md
  echo "Created CLAUDE.md for project $PROJECT_ID"
else
  echo "CLAUDE.md already exists, will not overwrite"
fi

# cborg-code is now permanently installed in the Docker image
# Display a message about cborg-code usage
echo "cborg-code is pre-installed. Use it with:"
echo "  export CBORG_API_KEY=your-api-key"
echo "  cborg-code"

# Execute the command passed to docker
exec "$@"