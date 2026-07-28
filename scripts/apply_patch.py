from pathlib import Path
import sys

file = Path(sys.argv[1])

old = sys.argv[2]
new = sys.argv[3]

text = file.read_text(encoding="utf-8")

if old not in text:
    print("ERROR: Pattern not found.")
    sys.exit(1)

text = text.replace(old, new, 1)

file.write_text(text, encoding="utf-8")

print("Patch applied successfully.")
