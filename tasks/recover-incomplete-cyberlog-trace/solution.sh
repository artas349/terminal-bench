#!/bin/bash
set -euo pipefail

# Navigate to the directory containing the script
cd "$(dirname "$0")"

echo ">> Running solution.sh from: $(pwd)"

LOGDIR="./corrupted_logs"
TMPFILE="/tmp/all_events.json"
OUTFILE="output.json"  # Relative path to ensure it's created in the task directory

if [[ ! -d "$LOGDIR" ]]; then
    echo "❌ $LOGDIR directory not found in $(pwd)"
    exit 1
fi

> "$TMPFILE"
> "$OUTFILE"

echo ">> Processing logs from $LOGDIR"

for file in "$LOGDIR"/*.log; do
    echo "   -> $file"
    awk 'BEGIN{ORS=""} /^{/{print "\n"} {print $0}' "$file" | \
    sed 's/}[^{]*{/}\n{/g' | \
    while IFS= read -r line; do
        if echo "$line" | jq -e 'type == "object" and (.timestamp | type == "string") and (.ip | type == "string") and (.severity | type == "string")' >/dev/null 2>&1; then
            echo "$line" >> "$TMPFILE"
        fi
    done
done

jq -s 'sort_by(.timestamp)' "$TMPFILE" > "$OUTFILE"

echo "✅ Done. $(jq length "$OUTFILE") entries written to $OUTFILE"
