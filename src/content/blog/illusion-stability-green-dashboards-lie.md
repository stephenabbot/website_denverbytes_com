---
title: "The Illusion of Stability: When Green Dashboards Lie"
description: "Stable metrics don't always mean a stable system. Sometimes the most dangerous problems hide behind perfectly normal averages."
publishDate: 2025-01-01
tags: ["SRE", "Monitoring", "Networking", "AWS"]
featured: false
---

# The Illusion of Stability: When Green Dashboards Lie

"Stable metrics don't always mean a stable system."

This lesson hit home when Daniel Sarica uncovered a hidden source of packet loss in an AWS Direct Connect setup—despite all indicators showing green across the board. The culprit? Microbursts.

These short-lived traffic spikes were overwhelming a 1 Gbps connection fed by a 10 Gbps source, causing intermittent failures that were completely invisible to standard monitoring. Users were experiencing problems, but every dashboard said everything was fine.

## The Problem with Averages

Here's the thing about averages: they're really good at hiding the problems that matter most. A connection might average 500 Mbps utilization over a minute, looking perfectly healthy, while experiencing regular 2-second bursts that max out the link and drop packets.

Your monitoring sees: "50% utilization, all good!"  
Your users experience: "Why does this keep timing out?"

This is a perfect example of why observability must go beyond static metrics. SREs and architects need to proactively seek out these hidden failure points before they cause real-world impact.

## Beyond the Dashboard

The most dangerous assumption in reliability engineering is that green dashboards equal happy users. They don't. Green dashboards mean your metrics are within acceptable ranges—but metrics are just abstractions of reality.

Real systems have:
- **Microbursts** that overwhelm buffers between measurement intervals
- **Tail latencies** that affect your most important users
- **Cascade failures** that start small and compound
- **Resource contention** that only shows up under specific conditions

## What This Means for SRE Practice

This isn't just a networking problem—it's a mindset problem. We need to actively hunt for the gaps between what we measure and what users experience.

**Ask different questions:**
- What happens during the 99th percentile of load?
- Where are our measurement blind spots?
- What failure modes would be invisible to our current monitoring?

**Look for the outliers:**
- That one user complaint that doesn't match your metrics
- Intermittent issues that "resolve themselves"
- Performance problems that only happen under specific conditions

**Design for visibility:**
- Monitor at multiple time scales (seconds, not just minutes)
- Track percentiles, not just averages
- Instrument the edge cases, not just the happy path

## The Takeaway

Smooth averages often hide dangerous spikes. Just because dashboards show "all good" doesn't mean users experience the same.

The next time everything looks perfect on your monitoring but you're getting user complaints, remember Daniel's microbursts. Sometimes the most critical problems are the ones hiding in plain sight, disguised as normal behavior.

Because in reliability engineering, the most expensive problems are often the ones you never see coming.
