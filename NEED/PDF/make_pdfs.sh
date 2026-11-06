#!/bin/bash
# Rebuilds the A4 PDFs from ../Build_Map.html with headless Chrome, then marks every wide page
# as turned a quarter turn clockwise, so each sheet is portrait (the printer feeds them all the same way).
# Run from anywhere: bash NEED/PDF/make_pdfs.sh
set -e
cd "$(dirname "$0")"
HTML="file://$(cd .. && pwd)/Build_Map.html"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
TMP=$(mktemp -d)
for pair in "all:0_All_Combined" "map:1_Map" "whole:1b_Whole_Company_Map" "work:2_Work_Flow" "flows:3_All_Data_Flows" "questions:4_All_Department_Questions" "prateek:5_Prateek_Questions"; do
  "$CHROME" --headless=new --disable-gpu --no-pdf-header-footer --user-data-dir="$TMP/profile" \
    --print-to-pdf="${pair##*:}.pdf" "$HTML?pdf=${pair%%:*}" >/dev/null 2>&1
done
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer --user-data-dir="$TMP/profile" \
  --print-to-pdf="7_Portal_Concept.pdf" "file://$(cd .. && pwd)/Portal_Concept.html" >/dev/null 2>&1
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer --user-data-dir="$TMP/profile" \
  --print-to-pdf="8_Build_Schema_and_Stand_Studio.pdf" "file://$(cd .. && pwd)/Schema_Concept.html" >/dev/null 2>&1
python3 -I - *.pdf <<'PY'
import re, sys
for path in sys.argv[1:]:
    b = open(path, 'rb').read()
    xi = b.rindex(b"\nxref\n") + 1
    tr = b[b.index(b"trailer", xi):]
    root = re.search(rb"/Root (\d+ 0 R)", tr).group(1)
    info = re.search(rb"/Info (\d+ 0 R)", tr)
    body = b[:xi]
    starts = [(int(m.group(1)), m.start(1)) for m in re.finditer(rb"(?:(?<=\n)|^)(\d+) 0 obj\n", body)]
    head = body[:starts[0][1]]
    out, offs, pos = [head], {}, len(head)
    for k, (num, st) in enumerate(starts):
        end = starts[k + 1][1] if k + 1 < len(starts) else len(body)
        chunk = body[st:end]
        mb = re.search(rb"/MediaBox \[\s*0 0 ([\d.]+) ([\d.]+)\s*\]", chunk)
        if b"/Type /Page\n" in chunk and mb and float(mb.group(1)) > float(mb.group(2)):
            chunk = chunk.replace(b"/Type /Page\n", b"/Type /Page\n/Rotate 90\n", 1)
        offs[num] = pos
        pos += len(chunk)
        out.append(chunk)
    size = max(offs) + 1
    x = b"xref\n0 %d\n0000000000 65535 f \n" % size
    for n in range(1, size):
        x += (b"%010d 00000 n \n" % offs[n]) if n in offs else b"0000000000 65535 f \n"
    t = b"trailer\n<</Size %d\n/Root %s\n" % (size, root)
    if info: t += b"/Info " + info.group(1) + b"\n"
    t += b">>\nstartxref\n%d\n%%%%EOF\n" % pos
    open(path, 'wb').write(b"".join(out) + x + t)
PY
rm -rf "$TMP"
ls -la *.pdf
