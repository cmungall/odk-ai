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

# Copy template files if they don't exist in the working directory
echo "Copying templates to working directory (skipping existing files and *.jinja2)..."
if [ -d /root/template ]; then
  find /root/template -type f -not -name "*.jinja2" | while read template_file; do
    # Get relative path from /root/template
    rel_path=${template_file#/root/template/}
    # Create target directory if it doesn't exist
    target_dir=$(dirname "/work/$rel_path")
    mkdir -p "$target_dir"
    
    if [ ! -f "/work/$rel_path" ]; then
      echo "Copying $rel_path to working directory"
      cp "$template_file" "/work/$rel_path"
    else
      echo "Skipping $rel_path (already exists)"
    fi
  done
fi

# Execute the command passed to docker
exec "$@"