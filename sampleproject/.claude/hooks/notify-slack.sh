#!/usr/bin/env bash
# Hook: post_task — fires after the AI agent finishes a task.
# Sends a Slack notification with the task summary.
#
# Required env vars:
#   SLACK_WEBHOOK_URL  – Incoming Webhook URL from Slack App settings
#   SLACK_CHANNEL      – e.g. "#dev-notifications"
#
# The agent runtime passes task metadata via stdin as JSON:
#   { "task": "...", "status": "success|error", "summary": "..." }

set -euo pipefail

if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
  echo "SLACK_WEBHOOK_URL not set — skipping Slack notification." >&2
  exit 0
fi

INPUT=$(cat)
TASK=$(echo "$INPUT"    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('task','unknown task'))")
STATUS=$(echo "$INPUT"  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('status','unknown'))")
SUMMARY=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('summary',''))")

ICON=":white_check_mark:"
[[ "$STATUS" == "error" ]] && ICON=":x:"

PAYLOAD=$(cat <<JSON
{
  "channel": "${SLACK_CHANNEL:-#dev-notifications}",
  "text": "$ICON *AI agent finished:* $TASK\n$SUMMARY"
}
JSON
)

curl -s -X POST -H 'Content-type: application/json' \
  --data "$PAYLOAD" \
  "$SLACK_WEBHOOK_URL"

echo "Slack notification sent."
