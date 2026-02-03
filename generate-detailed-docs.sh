#!/bin/bash

# GFX Detailed Documentation Generator (English)
# Extracts events, exports, commands from source code

DOCS_DIR="$HOME/gfx-docs/scripts"
LOG_FILE="$HOME/gfx-docs/detailed-generation.log"

echo "Starting detailed documentation generation at $(date)" > "$LOG_FILE"

extract_events() {
    local content="$1"
    echo "$content" | grep -oE "RegisterNetEvent\(['\"]([^'\"]+)" | sed "s/RegisterNetEvent(['\"]//g" | sort -u
}

extract_exports() {
    local content="$1"
    echo "$content" | grep -oE "exports\[['\"]([^'\"]+)" | sed "s/exports\[['\"]//g" | sort -u
    echo "$content" | grep -oE "exports\.[a-zA-Z_][a-zA-Z0-9_]*" | sed "s/exports\.//g" | sort -u
}

extract_commands() {
    local content="$1"
    echo "$content" | grep -oE "RegisterCommand\(['\"]([^'\"]+)" | sed "s/RegisterCommand(['\"]//g" | sort -u
}

extract_callbacks() {
    local content="$1"
    echo "$content" | grep -oE "RegisterCallback\(['\"]([^'\"]+)" | sed "s/RegisterCallback(['\"]//g" | sort -u
    echo "$content" | grep -oE "TriggerCallback\(['\"]([^'\"]+)" | sed "s/TriggerCallback(['\"]//g" | sort -u
}

get_all_lua_content() {
    local repo="$1"
    local folder="$2"
    local all_content=""

    local files=$(gh api "repos/gfx-fivem/$repo/contents/$folder" --jq '.[].name' 2>/dev/null | grep '\.lua$')

    for file in $files; do
        local content=$(gh api "repos/gfx-fivem/$repo/contents/$folder/$file" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null)
        all_content="$all_content"$'\n'"$content"
    done

    echo "$all_content"
}

generate_detailed_doc() {
    local repo=$1
    local title=$(echo "$repo" | sed 's/gfx-/GFX /g' | sed 's/-/ /g' | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

    echo "Processing: $repo" >> "$LOG_FILE"
    echo "Processing: $repo"

    # Get repo structure
    local contents=$(gh api repos/gfx-fivem/$repo/contents 2>/dev/null)
    if [ -z "$contents" ]; then
        echo "  ERROR: Could not fetch repo" >> "$LOG_FILE"
        return
    fi

    local has_config=$(echo "$contents" | jq -r '.[] | select(.name == "config") | .name' 2>/dev/null)
    local has_client=$(echo "$contents" | jq -r '.[] | select(.name == "client") | .name' 2>/dev/null)
    local has_server=$(echo "$contents" | jq -r '.[] | select(.name == "server") | .name' 2>/dev/null)
    local has_web=$(echo "$contents" | jq -r '.[] | select(.name == "web") | .name' 2>/dev/null)
    local has_shared=$(echo "$contents" | jq -r '.[] | select(.name == "shared") | .name' 2>/dev/null)

    # Get all client content
    local client_content=""
    if [ -n "$has_client" ]; then
        client_content=$(get_all_lua_content "$repo" "client")
    fi

    # Get all server content
    local server_content=""
    if [ -n "$has_server" ]; then
        server_content=$(get_all_lua_content "$repo" "server")
    fi

    # Get config content
    local config_content=""
    if [ -n "$has_config" ]; then
        config_content=$(get_all_lua_content "$repo" "config")
    fi

    # Extract events
    local client_events=$(extract_events "$client_content")
    local server_events=$(extract_events "$server_content")

    # Extract exports
    local client_exports=$(extract_exports "$client_content")
    local server_exports=$(extract_exports "$server_content")

    # Extract commands
    local all_commands=$(extract_commands "$client_content$server_content")

    # Extract callbacks
    local callbacks=$(extract_callbacks "$server_content")

    # Start generating markdown
    cat > "$DOCS_DIR/$repo.md" << DOCEOF
# $title

## Installation

### 1. Copy Files
\`\`\`bash
# Copy $repo folder to your resources directory
cp -r $repo /path/to/resources/
\`\`\`

### 2. server.cfg
\`\`\`cfg
ensure $repo
\`\`\`

DOCEOF

    # Add dependencies if detected
    if echo "$client_content$server_content" | grep -q "ox_inventory\|ox_lib"; then
        cat >> "$DOCS_DIR/$repo.md" << DOCEOF
### 3. Dependencies
- ox_inventory or ox_lib (detected)

DOCEOF
    fi

    echo "---" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Add config section
    echo "## Configuration" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    if [ -n "$has_config" ]; then
        # Try to get specific config files
        for cfg_name in "client_config.lua" "config.lua" "shared.lua"; do
            local cfg=$(gh api "repos/gfx-fivem/$repo/contents/config/$cfg_name" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null)
            if [ -n "$cfg" ]; then
                cat >> "$DOCS_DIR/$repo.md" << DOCEOF
### $cfg_name

\`\`\`lua
$cfg
\`\`\`

DOCEOF
            fi
        done

        for cfg_name in "server_config.lua" "sv_config.lua"; do
            local cfg=$(gh api "repos/gfx-fivem/$repo/contents/config/$cfg_name" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null)
            if [ -n "$cfg" ]; then
                cat >> "$DOCS_DIR/$repo.md" << DOCEOF
### $cfg_name

\`\`\`lua
$cfg
\`\`\`

DOCEOF
            fi
        done
    else
        echo "*No configuration file found*" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
    fi

    echo "---" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Add Events section
    echo "## Events" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    if [ -n "$client_events" ]; then
        echo "### Client Events" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`lua" >> "$DOCS_DIR/$repo.md"
        echo "$client_events" | while read -r event; do
            [ -n "$event" ] && echo "-- $event"
            [ -n "$event" ] && echo "TriggerEvent('$event', ...)"
            [ -n "$event" ] && echo ""
        done >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
    fi

    if [ -n "$server_events" ]; then
        echo "### Server Events" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`lua" >> "$DOCS_DIR/$repo.md"
        echo "$server_events" | while read -r event; do
            [ -n "$event" ] && echo "-- $event"
            [ -n "$event" ] && echo "TriggerServerEvent('$event', ...)"
            [ -n "$event" ] && echo ""
        done >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
    fi

    if [ -z "$client_events" ] && [ -z "$server_events" ]; then
        echo "*No events found*" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
    fi

    echo "---" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Add Exports section
    echo "## Exports" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    local all_exports=$(echo -e "$client_exports\n$server_exports" | sort -u | grep -v '^$')

    if [ -n "$all_exports" ]; then
        echo "\`\`\`lua" >> "$DOCS_DIR/$repo.md"
        echo "$all_exports" | while read -r exp; do
            [ -n "$exp" ] && echo "exports['$repo']:$exp(...)"
        done >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`" >> "$DOCS_DIR/$repo.md"
    else
        echo "*No exports found*" >> "$DOCS_DIR/$repo.md"
    fi
    echo "" >> "$DOCS_DIR/$repo.md"

    echo "---" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Add Commands section
    echo "## Commands" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    if [ -n "$all_commands" ]; then
        echo "| Command | Description |" >> "$DOCS_DIR/$repo.md"
        echo "|---------|-------------|" >> "$DOCS_DIR/$repo.md"
        echo "$all_commands" | while read -r cmd; do
            [ -n "$cmd" ] && echo "| \`/$cmd\` | - |"
        done >> "$DOCS_DIR/$repo.md"
    else
        echo "*No commands found*" >> "$DOCS_DIR/$repo.md"
    fi
    echo "" >> "$DOCS_DIR/$repo.md"

    echo "---" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Add Callbacks section
    if [ -n "$callbacks" ]; then
        echo "## Callbacks" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`lua" >> "$DOCS_DIR/$repo.md"
        echo "$callbacks" | while read -r cb; do
            [ -n "$cb" ] && echo "-- $cb"
            [ -n "$cb" ] && echo "TriggerCallback('$cb', function(result)"
            [ -n "$cb" ] && echo "    -- handle result"
            [ -n "$cb" ] && echo "end)"
            [ -n "$cb" ] && echo ""
        done >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
        echo "---" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
    fi

    # Add Features section
    echo "## Features" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    [ -n "$has_web" ] && echo "- ✅ NUI Interface" >> "$DOCS_DIR/$repo.md"
    [ -n "$has_client" ] && echo "- ✅ Client-side" >> "$DOCS_DIR/$repo.md"
    [ -n "$has_server" ] && echo "- ✅ Server-side" >> "$DOCS_DIR/$repo.md"
    [ -n "$has_shared" ] && echo "- ✅ Shared module" >> "$DOCS_DIR/$repo.md"

    echo "" >> "$DOCS_DIR/$repo.md"
    echo "---" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Add footer
    cat >> "$DOCS_DIR/$repo.md" << DOCEOF
## Source

- **GitHub:** https://github.com/gfx-fivem/$repo
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
DOCEOF

    echo "  Completed: $repo" >> "$LOG_FILE"
}

# Read scripts from file and process
count=0
total=$(wc -l < /tmp/all_scripts.txt | tr -d ' ')

while IFS= read -r repo; do
    [ -z "$repo" ] && continue
    generate_detailed_doc "$repo"
    count=$((count + 1))
    echo "Progress: $count/$total"
done < /tmp/all_scripts.txt

echo "Detailed documentation generation completed at $(date)" >> "$LOG_FILE"
echo "DONE - Generated $count documentation files"
