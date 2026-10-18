#!/bin/bash
ok=0; fail=0
for f in "$@"; do
  dir=$(dirname "$f"); base=$(basename "${f%.*}")
  mkdir -p "$dir/Converted MP4"
  out="$dir/Converted MP4/$base.mp4"; n=1
  while [ -e "$out" ]; do out="$dir/Converted MP4/$base ($n).mp4"; n=$((n+1)); done
  if /usr/bin/avconvert --source "$f" --output "$out" --preset PresetHighestQuality >/dev/null 2>&1; then
    ok=$((ok+1))
  else
    rm -f "$out"; fail=$((fail+1))
  fi
done
msg="Converted $ok file(s) to MP4"
[ "$fail" -gt 0 ] && msg="$msg, $fail failed"
osascript -e "display notification \"$msg\" with title \"Convert to MP4\""
