#!/bin/bash
# Renders one image per person (all their portal screens) from ../Stands_Simulation.html with headless Chrome.
# Usage: bash NEED/screens/make_screens.sh   (about 5 minutes)
cd "$(dirname "$0")"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
BASE="file://$(cd .. && pwd)/Stands_Simulation.html"
TMP=$(mktemp -d)
while IFS=$'\t' read -r dept name W H; do
  slug=$(python3 -c "import re,sys;print(re.sub(r'[^a-z0-9]+','-',sys.argv[1].lower()).strip('-'))" "$name")
  enc=$(python3 -c "import urllib.parse,sys;print(urllib.parse.quote(sys.argv[1]))" "$name")
  out="${dept}_${slug}"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --user-data-dir="$TMP/p" --window-size="$W,$H" --screenshot="$TMP/$out.png" "$BASE?sheet=$enc" >/dev/null 2>&1
  sips -s format jpeg -s formatOptions 82 "$TMP/$out.png" --out "$out.jpg" >/dev/null 2>&1
  echo "$out"
done < list.tsv
