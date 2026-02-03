#!/bin/bash

# GFX Detailed Documentation Generator (English)
# Extracts CREATED events and exports (not used ones)

DOCS_DIR="$HOME/gfx-docs/scripts"
LOG_FILE="$HOME/gfx-docs/detailed-generation.log"

echo "Starting detailed documentation generation at $(date)" > "$LOG_FILE"

# Extract events that this script TRIGGERS (broadcasts) - others can listen to these
extract_triggered_events() {
    local content="$1"

    # TriggerClientEvent(-1, 'event' or TriggerClientEvent(source, 'event'
    echo "$content" | grep -oE "TriggerClientEvent\([^,]+,\s*['\"]([^'\"]+)" | sed "s/TriggerClientEvent([^,]*,\s*['\"]//g" | sort -u

    # TriggerEvent('event'
    echo "$content" | grep -oE "TriggerEvent\(['\"]([^'\"]+)" | sed "s/TriggerEvent(['\"]//g" | sort -u
}

extract_server_triggered_events() {
    local content="$1"

    # TriggerServerEvent('event'
    echo "$content" | grep -oE "TriggerServerEvent\(['\"]([^'\"]+)" | sed "s/TriggerServerEvent(['\"]//g" | sort -u
}

# Extract exports that this script CREATES - others can call these
extract_created_exports() {
    local content="$1"

    # Pattern: exports('functionName', function(param1, param2)
    # Extracts function name and parameters
    echo "$content" | sed -n "s/.*exports(['\"]\\([^'\"]*\\)['\"],.*function(\\([^)]*\\)).*/\\1|\\2/p" | sort -u
}

extract_commands() {
    local content="$1"
    echo "$content" | grep -oE "RegisterCommand\(['\"]([^'\"]+)" | sed "s/RegisterCommand(['\"]//g" | sort -u
}

extract_callbacks() {
    local content="$1"
    # Extract RegisterCallback with function parameters
    # Pattern: RegisterCallback('name', function(source, param1, param2)
    echo "$content" | sed -n "s/.*RegisterCallback(['\"]\\([^'\"]*\\)['\"],.*function(\\([^)]*\\)).*/\\1|\\2/p" | sort -u
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

    # Get all content
    local client_content=""
    if [ -n "$has_client" ]; then
        client_content=$(get_all_lua_content "$repo" "client")
    fi

    local server_content=""
    if [ -n "$has_server" ]; then
        server_content=$(get_all_lua_content "$repo" "server")
    fi

    # Extract CREATED exports (not used ones)
    local client_exports=$(extract_created_exports "$client_content")
    local server_exports=$(extract_created_exports "$server_content")

    # Extract TRIGGERED events (events this script broadcasts)
    local client_triggered=$(extract_triggered_events "$server_content") # Server triggers to client
    local server_triggered=$(extract_server_triggered_events "$client_content") # Client triggers to server

    # Extract commands
    local all_commands=$(extract_commands "$client_content$server_content")

    # Extract callbacks with parameters
    local callbacks=$(extract_callbacks "$server_content")

    # Start generating markdown
    cat > "$DOCS_DIR/$repo.md" << DOCEOF
# $title

## Installation

### 1. Copy Files
\`\`\`bash
cp -r $repo /path/to/resources/
\`\`\`

### 2. server.cfg
\`\`\`cfg
ensure $repo
\`\`\`

DOCEOF

    echo "---" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Add config section
    echo "## Configuration" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    if [ -n "$has_config" ]; then
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

    # Add Exports section - CREATED exports with parameters
    echo "## Exports" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"
    echo "Exports that other scripts can call:" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    local all_exports=$(echo -e "$client_exports\n$server_exports" | sort -u | grep -v '^$')

    if [ -n "$all_exports" ]; then
        echo "\`\`\`lua" >> "$DOCS_DIR/$repo.md"
        echo "$all_exports" | while IFS='|' read -r func_name params; do
            if [ -n "$func_name" ]; then
                echo "-- Export: $func_name"
                if [ -n "$params" ]; then
                    echo "local result = exports['$repo']:$func_name($params)"
                else
                    echo "local result = exports['$repo']:$func_name()"
                fi
                echo ""
            fi
        done >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`" >> "$DOCS_DIR/$repo.md"
    else
        echo "*No exports found*" >> "$DOCS_DIR/$repo.md"
    fi
    echo "" >> "$DOCS_DIR/$repo.md"

    echo "---" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Add Events section - TRIGGERED events (that others can listen to)
    echo "## Events" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"
    echo "Events that this script triggers (you can listen to these):" >> "$DOCS_DIR/$repo.md"
    echo "" >> "$DOCS_DIR/$repo.md"

    # Filter to only show events from this script
    local script_events=$(echo "$client_triggered" | grep -i "$repo" | sort -u)

    if [ -n "$script_events" ]; then
        echo "### Client Events" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`lua" >> "$DOCS_DIR/$repo.md"
        echo "$script_events" | while read -r event; do
            if [ -n "$event" ]; then
                echo "-- Listen to this event"
                echo "RegisterNetEvent('$event')"
                echo "AddEventHandler('$event', function(...)"
                echo "    -- Handle event"
                echo "end)"
                echo ""
            fi
        done >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
    fi

    local script_server_events=$(echo "$server_triggered" | grep -i "$repo" | sort -u)

    if [ -n "$script_server_events" ]; then
        echo "### Server Events" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`lua" >> "$DOCS_DIR/$repo.md"
        echo "$script_server_events" | while read -r event; do
            if [ -n "$event" ]; then
                echo "-- Listen to this event on server"
                echo "RegisterNetEvent('$event')"
                echo "AddEventHandler('$event', function(...)"
                echo "    -- Handle event"
                echo "end)"
                echo ""
            fi
        done >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
    fi

    if [ -z "$script_events" ] && [ -z "$script_server_events" ]; then
        echo "*No public events found*" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
    fi

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

    # Add Callbacks section with parameters
    if [ -n "$callbacks" ]; then
        echo "## Callbacks" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
        echo "Server callbacks you can trigger from client:" >> "$DOCS_DIR/$repo.md"
        echo "" >> "$DOCS_DIR/$repo.md"
        echo "\`\`\`lua" >> "$DOCS_DIR/$repo.md"
        echo "$callbacks" | while IFS='|' read -r cb_name params; do
            if [ -n "$cb_name" ]; then
                # Remove 'source' from params (it's internal to server)
                local call_params=$(echo "$params" | sed 's/source,\s*//g' | sed 's/source//g' | sed 's/^,\s*//g' | sed 's/,\s*$//g')
                echo "-- Callback: $cb_name"
                if [ -n "$call_params" ]; then
                    echo "TriggerCallback('$cb_name', function(result)"
                    echo "    -- Parameters to send: $call_params"
                    echo "    -- Handle result"
                    echo "end, $call_params)"
                else
                    echo "TriggerCallback('$cb_name', function(result)"
                    echo "    -- Handle result"
                    echo "end)"
                fi
                echo ""
            fi
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

    cat >> "$DOCS_DIR/$repo.md" << DOCEOF
## Source

- **GitHub:** https://github.com/gfx-fivem/$repo
- **Organization:** [GFX-Fivem](https://github.com/gfx-fivem)
DOCEOF

    echo "  Completed: $repo" >> "$LOG_FILE"
}

# Process all scripts
count=0
total=$(wc -l < /tmp/all_scripts.txt | tr -d ' ')

while IFS= read -r repo; do
    [ -z "$repo" ] && continue
    generate_detailed_doc "$repo"
    count=$((count + 1))
    echo "Progress: $count/$total"
done < /tmp/all_scripts.txt

echo "DONE - Generated $count documentation files"
