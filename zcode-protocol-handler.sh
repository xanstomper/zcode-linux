#!/usr/bin/env bash
# zcode:// protocol handler - receives OAuth callback and passes it to a local HTTP server
set -euo pipefail

URL="$1"
echo "[zcode-handler] received URL: $URL" >&2

# Extract the code parameter
if [[ "$URL" == zcode://* ]]; then
  # Send to a local server that ZCode is listening on
  # Actually, we just let the app see the URL directly
  # Or we can store it and signal the app
  CODE=$(echo "$URL" | grep -oP 'code=[^&]+' | head -1)
  echo "[zcode-handler] code: $CODE" >&2
  
  # Write the URL to a known file so the app can read it
  echo "$URL" > /tmp/zcode-oauth-url.txt
fi
