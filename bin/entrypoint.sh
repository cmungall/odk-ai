#!/bin/bash
set -e


# Initialize CLAUDE.md from template only if it doesn't exist
if [ ! -f /work/CLAUDE.md ]; then
  echo "Initializing CLAUDE.md from template..."
  # Determine project ID from directory name
  # Process template with jinja2
  # jinja2 /root/CLAUDE.md.jinja2 -D "project.id=$PROJECT_ID" > /work/CLAUDE.md
  PROJECT_ID=$(grep -oP '^id: \K[^ ]+' /work/src/ontology/*-odk.yaml)
  jinja2 /root/CLAUDE.md.jinja2 -D "project_id=$PROJECT_ID" > /work/CLAUDE.md
  echo "Created CLAUDE.md for project $PROJECT_ID_ID"
else
  echo "CLAUDE.md already exists, will not overwrite"
fi

# cborg-code is now permanently installed in the Docker image
# Display a message about cborg-code usage
#echo "cborg-code is pre-installed. Use it with:"
#echo "  export CBORG_API_KEY=your-api-key"
#echo "  cborg-code"
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