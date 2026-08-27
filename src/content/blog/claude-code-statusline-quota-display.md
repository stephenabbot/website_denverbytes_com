---
title: "Your Claude Code Status Line Can Show How Much Plan You Have Left"
description: "Claude Code already pipes your 5-hour and 7-day rate limit usage into the status line payload. Three lines of config put it where you actually look — plus the four gotchas that will cost you time."
publishDate: 2026-08-27
tags: ["Claude", "AI", "Developer Tools", "Shell"]
featured: true
---

# Your Claude Code Status Line Can Show How Much Plan You Have Left

![Claude Code status line showing context, 5-hour, and 7-day quota usage](/assets/statusline-quota-display.png)

If you work in Claude Code, you have probably had a session stop at the worst possible moment. The client knows how close you are the whole time — it just doesn't put it anywhere you look.

Mine now reads:

```text
~/dev/core-app (main) | Opus 5 | ctx 12% | 5h 28% 3.1h | 7d 44% 3.2d
```

Context used. 5-hour window used, and time until it resets. 7-day window used, and time until that resets.

Color first — while everything is green I never read the digits. When a field turns amber I know which one, and how long I have.

## The Data Is Already Being Handed to You

On every render, Claude Code pipes a JSON object into your `statusLine` command containing:

```json
"rate_limits": {
  "five_hour": { "used_percentage": number, "resets_at": number },
  "seven_day": { "used_percentage": number, "resets_at": number }
}
```

No API key, no proxy, no third-party tool. `/usage` shows the same numbers, but that is a panel you have to remember to open — which is exactly what you don't do while you are working.

**You need Claude Code 2.1.80 or later.** That is the release where `rate_limits` first appears in the status line payload — 2.1.79 does not have it. Check with `claude --version`.

## Four Things That Will Save You Time

1. **Subscribers only.** The field is null for API key, Bedrock, and Vertex sessions — there is no plan window to report on those.

2. **Absent until the first API response** of a session, and each window can be missing independently. Guard every read: `jq -r '.rate_limits.five_hour.used_percentage // empty'`.

3. **`resets_at` is Unix epoch seconds.** Subtract now, then format. The countdown is the half that tells you whether the percentage matters — 60% burned with 40 minutes left is fine; 60% burned with four hours left is not.

4. **Make every percentage "used", never "remaining."** Mix the two and 10% means healthy in one field and nearly fatal in the next. Same glyph, opposite meaning, read at a glance by someone at the end of a long day.

## It Works on Windows Too

The whole thing is one shell script. On macOS or Linux it needs `bash`, `jq`, and `git`. On Windows, either run the identical script through Git Bash (`winget install jqlang.jq` for the one missing dependency), or port it to PowerShell 7, where `ConvertFrom-Json` replaces `jq` entirely and ANSI colour works in Windows Terminal.

Sixty lines of shell. It has already paid for itself.
