#!/bin/zsh
set -e

TOOL_DIR="$(cd "$(dirname "$0")" && pwd)"
PORT="${ARTHAS_KOTLIN_TOOL_V2_PORT:-8766}"
URL="http://127.0.0.1:${PORT}/index.html?v=v2-20260625-4"

cd "$TOOL_DIR"

if ! lsof -nP -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; then
  python3 -m http.server "$PORT" --bind 127.0.0.1 &
  SERVER_PID=$!
  trap 'kill "$SERVER_PID" >/dev/null 2>&1 || true' EXIT INT TERM
  sleep 1
else
  SERVER_PID=""
fi

open "$URL"

echo "Arthas Kotlin Command Tool v2:"
echo "$URL"
echo
echo "Keep this window open while using the tool."

if [[ -n "$SERVER_PID" ]]; then
  wait "$SERVER_PID"
else
  while true; do
    sleep 3600
  done
fi
