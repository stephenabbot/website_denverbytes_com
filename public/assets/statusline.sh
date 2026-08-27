#!/bin/bash
# Claude Code status line: dir (branch) | model | ctx% | 5h% | 7d%
# Reads session JSON on stdin (see https://code.claude.com/docs/en/statusline).
#
# Every percentage is USED, never remaining, so all three move in the same
# direction and a high number always means trouble.
#
# Bands:
#   ctx  green <41   yellow 41-55   red >=56   (56 is where auto-compaction risk starts)
#   5h   green <60   yellow 60-84   red >=85
#   7d   green <60   yellow 60-84   red >=85
#
# A quota segment is omitted entirely when absent: rate_limits appears only for
# Claude.ai subscribers, and only after the first API response of a session.
# Each quota segment carries the time remaining until that window resets,
# computed from resets_at (Unix epoch seconds) and rounded up to one decimal:
# hours for the five-hour window, days for the seven-day window.

input=$(cat)

j() { printf '%s' "$input" | jq -r "$1" | cut -d. -f1; }

MODEL=$(printf '%s' "$input" | jq -r '.model.display_name // "?"')
DIR=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // ""')

CTX=$(j '.context_window.used_percentage // 0')
H5=$(j '.rate_limits.five_hour.used_percentage // empty')
H5_AT=$(j '.rate_limits.five_hour.resets_at // empty')
D7=$(j '.rate_limits.seven_day.used_percentage // empty')
D7_AT=$(j '.rate_limits.seven_day.resets_at // empty')

GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
OFF=$'\033[0m'

# seg <label> <used%> <yellow-at> <red-at> [resets_at-epoch] [unit: h|d]
# Prints nothing when the value is absent.
seg() {
  local label=$1 val=$2 yel=$3 red=$4 at=$5 unit=$6 color extra=""

  [ -z "$val" ] && return 0
  case $val in *[!0-9]* | '') return 0 ;; esac

  if [ "$val" -ge "$red" ]; then
    color=$RED
  elif [ "$val" -ge "$yel" ]; then
    color=$YELLOW
  else
    color=$GREEN
  fi

  case $at in *[!0-9]* | '') at="" ;; esac

  if [ -n "$at" ]; then
    local now rem span tenths
    now=$(date +%s)
    rem=$((at - now))
    [ "$rem" -lt 0 ] && rem=0

    # Tenths of a unit, always rounded up.
    case $unit in
      d) span=86400 ;;
      *) span=3600 ;;
    esac
    tenths=$(((rem * 10 + span - 1) / span))

    extra=$(printf ' %d.%d%s' "$((tenths / 10))" "$((tenths % 10))" "$unit")
  fi

  printf '%s%s %s%%%b%s' "$color" "$label" "$val" "$extra" "$OFF"
}

DIRNAME=${DIR##*/}

# Git branch, if the working dir is a repo.
BRANCH=""
if [ -n "$DIR" ] && git -C "$DIR" rev-parse --git-dir >/dev/null 2>&1; then
  BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null)
fi

if [ -n "$BRANCH" ]; then
  LOC="$DIRNAME ($BRANCH)"
else
  LOC="$DIRNAME"
fi

OUT="$LOC | $MODEL"

for part in "$(seg ctx "$CTX" 41 56)" \
            "$(seg 5h "$H5" 60 85 "$H5_AT" h)" \
            "$(seg 7d "$D7" 60 85 "$D7_AT" d)"; do
  [ -n "$part" ] && OUT="$OUT | $part"
done

printf '%s\n' "$OUT"
