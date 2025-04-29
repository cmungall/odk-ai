#!/bin/bash
set -e



# Initialize CLAUDE.md from template only if it doesn't exist AND the ODK yaml file exists
if [ ! -f /work/CLAUDE.md ] && ls /work/src/ontology/*-odk.yaml 1> /dev/null 2>&1; then
  echo "Initializing CLAUDE.md from template..."
  # Determine project ID from directory name
  # Process template with jinja2
  PROJECT_ID=$(grep -oP '^id: \K[^ ]+' /work/src/ontology/*-odk.yaml)
  jinja2 /root/CLAUDE.md.jinja2 -D "project_id=$PROJECT_ID" > /work/CLAUDE.md
  echo "Created CLAUDE.md for project $PROJECT_ID"
else
  if [ ! -f /work/CLAUDE.md ]; then
    echo "No ODK yaml file found in /work/src/ontology/, skipping CLAUDE.md initialization"
  else
    echo "CLAUDE.md already exists, will not overwrite"
  fi
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

# Create symlinks from /work/config to home directory
# TODO:
#   - when the image is started, the user may be in an ontology repo, OR above it
#   - for github settings, these can be shared across repos
#   - for claude settings, these should be per-repo
#   - for koding settings, these should be per-repo

if [ -d /work/config ]; then
  echo "Creating symlinks from /work/config to home directory..."
  for config_file in /work/config/.*; do
    # Skip . and .. directory entries
    if [ "$(basename "$config_file")" = "." ] || [ "$(basename "$config_file")" = ".." ]; then
      continue
    fi
    
    target_file=~/$(basename "$config_file")
    # Skip if target already exists as a real file or symlink
    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
      echo "Skipping: $target_file already exists"
    else
      # Create symlink in home directory
      ln -s "$config_file" "$target_file"
      echo "Created symlink: $target_file -> $config_file"
    fi
  done
  
  # Also handle regular files (not just hidden ones)
  for config_file in /work/config/*; do
    # Skip if it's a directory 
    if [ -d "$config_file" ]; then
      continue
    fi
    
    target_file=~/$(basename "$config_file")
    # Skip if target already exists as a real file or symlink
    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
      echo "Skipping: $target_file already exists"
    else
      # Create symlink in home directory
      ln -s "$config_file" "$target_file"
      echo "Created symlink: $target_file -> $config_file"
    fi
  done
fi

# if GITHUB_EMAIL is not set, use the default
if [ -z "$GITHUB_EMAIL" ]; then
  if [ -z "$EMAIL" ]; then
    echo "GITHUB_EMAIL is not set, and EMAIL is not set, using default email"
    GITHUB_EMAIL="cmungall+dragon-ai-agent@gmail.com"
  else
    echo "GITHUB_EMAIL is not set, using EMAIL"
    GITHUB_EMAIL="$EMAIL"
  fi
fi

if [ -z "$GITHUB_NAME" ]; then
  GITHUB_NAME="dragon-ai-agent"
fi

#git config user.name "$GITHUB_NAME"
#git config user.email "$GITHUB_EMAIL"
# Execute the command passed to docker
exec "$@"