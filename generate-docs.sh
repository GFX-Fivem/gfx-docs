#!/bin/bash

# GFX Documentation Generator
# Generates markdown documentation for FiveM scripts

DOCS_DIR="$HOME/gfx-docs/scripts"
LOG_FILE="$HOME/gfx-docs/generation.log"
PROGRESS_FILE="$HOME/gfx-docs/progress.txt"

mkdir -p "$DOCS_DIR"
echo "Starting documentation generation at $(date)" > "$LOG_FILE"
echo "0/45" > "$PROGRESS_FILE"

generate_doc() {
    local repo=$1
    local title=$(echo "$repo" | sed 's/gfx-/GFX /g' | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

    echo "Processing: $repo" >> "$LOG_FILE"

    # Get repo contents
    local contents=$(gh api repos/gfx-fivem/$repo/contents 2>/dev/null)
    if [ -z "$contents" ]; then
        echo "  ERROR: Could not fetch repo contents" >> "$LOG_FILE"
        return
    fi

    # Check for config files
    local has_config=$(echo "$contents" | jq -r '.[] | select(.name == "config") | .name' 2>/dev/null)
    local has_client=$(echo "$contents" | jq -r '.[] | select(.name == "client") | .name' 2>/dev/null)
    local has_server=$(echo "$contents" | jq -r '.[] | select(.name == "server") | .name' 2>/dev/null)
    local has_web=$(echo "$contents" | jq -r '.[] | select(.name == "web") | .name' 2>/dev/null)

    # Get fxmanifest if exists
    local fxmanifest=""
    if echo "$contents" | jq -e '.[] | select(.name == "fxmanifest.lua")' > /dev/null 2>&1; then
        fxmanifest=$(gh api repos/gfx-fivem/$repo/contents/fxmanifest.lua --jq '.content' 2>/dev/null | base64 -d 2>/dev/null)
    fi

    # Get README if exists
    local readme=""
    if echo "$contents" | jq -e '.[] | select(.name == "README.md")' > /dev/null 2>&1; then
        readme=$(gh api repos/gfx-fivem/$repo/contents/README.md --jq '.content' 2>/dev/null | base64 -d 2>/dev/null)
    fi

    # Get config files
    local client_config=""
    local server_config=""

    if [ -n "$has_config" ]; then
        local config_files=$(gh api repos/gfx-fivem/$repo/contents/config 2>/dev/null)

        # Try different config file names
        for cfg in "client_config.lua" "config.lua" "shared.lua" "cl_config.lua"; do
            if echo "$config_files" | jq -e ".[] | select(.name == \"$cfg\")" > /dev/null 2>&1; then
                client_config=$(gh api "repos/gfx-fivem/$repo/contents/config/$cfg" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null)
                break
            fi
        done

        for cfg in "server_config.lua" "sv_config.lua"; do
            if echo "$config_files" | jq -e ".[] | select(.name == \"$cfg\")" > /dev/null 2>&1; then
                server_config=$(gh api "repos/gfx-fivem/$repo/contents/config/$cfg" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null)
                break
            fi
        done
    fi

    # Detect features
    local features=""
    [ -n "$has_web" ] && features="$features\n- NUI arayüzü"
    [ -n "$has_client" ] && features="$features\n- Client-side işlemler"
    [ -n "$has_server" ] && features="$features\n- Server-side işlemler"

    # Generate markdown
    cat > "$DOCS_DIR/$repo.md" << DOCEOF
# $title

## Kurulum

### 1. Dosyaları Kopyala
\`\`\`
$repo klasörünü resources/ dizinine kopyalayın
\`\`\`

### 2. server.cfg
\`\`\`cfg
ensure $repo
\`\`\`

---

## Konfigürasyon

DOCEOF

    # Add config section if exists
    if [ -n "$client_config" ]; then
        cat >> "$DOCS_DIR/$repo.md" << DOCEOF
### Client Config

\`\`\`lua
$client_config
\`\`\`

DOCEOF
    fi

    if [ -n "$server_config" ]; then
        cat >> "$DOCS_DIR/$repo.md" << DOCEOF
### Server Config

\`\`\`lua
$server_config
\`\`\`

DOCEOF
    fi

    # Add features
    if [ -n "$features" ]; then
        cat >> "$DOCS_DIR/$repo.md" << DOCEOF
---

## Özellikler
$(echo -e "$features")

DOCEOF
    fi

    # Add note about checking source
    cat >> "$DOCS_DIR/$repo.md" << DOCEOF
---

## Notlar

Detaylı konfigürasyon ve events için kaynak kodunu inceleyiniz:
- GitHub: https://github.com/gfx-fivem/$repo
DOCEOF

    echo "  Created: $DOCS_DIR/$repo.md" >> "$LOG_FILE"
}

# Process each script
count=0
total=45

while IFS= read -r repo; do
    [ -z "$repo" ] && continue
    generate_doc "$repo"
    count=$((count + 1))
    echo "$count/$total" > "$PROGRESS_FILE"
    echo "Progress: $count/$total - $repo"
done < /tmp/missing_scripts.txt

echo "Documentation generation completed at $(date)" >> "$LOG_FILE"
echo "DONE" > "$PROGRESS_FILE"
