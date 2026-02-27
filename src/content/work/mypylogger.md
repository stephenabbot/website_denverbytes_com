---
title: mypylogger
publishDate: 2025-12-01 00:00:00
img: /assets/stock-3.jpg
img_alt: Zero-dependency Python logging library with JSON output and comprehensive testing
description: |
  A zero-dependency Python logging library with sensible defaults, clean JSON output, 
  and 96% test coverage for reliable structured logging.
tags:
  - Python
  - Open Source
  - Logging
  - Community
repo: https://github.com/stephenabbot/mypylogger
---

## The Problem

Python's standard `logging` module has inconsistent defaults and requires boilerplate configuration to produce structured output. Lambda functions and CLI tools often end up with ad-hoc logging that is difficult to parse, search, or correlate across invocations.

## The Approach

A zero-dependency library that wraps Python's logging module with sensible defaults: structured JSON output, consistent field names, and configurable log levels via environment variable. Extracted from production Lambda code and packaged as a reusable library.

## The Outcome

Drop-in structured logging for Python Lambda functions and CLI tools. Consistent JSON output that works with CloudWatch Logs Insights and any log aggregation system without custom parsing rules.

## Stack

| Technology | Purpose |
|------------|---------|
| Python 3.x | Implementation language |
| Python `logging` | Standard library wrapper |
| PyPI | Distribution |

**Repository**: [mypylogger](https://github.com/stephenabbot/mypylogger)

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Structured JSON output parseable by CloudWatch Logs Insights
- **Security**: No dependencies; no external network calls; auditable source
- **Reliability**: Zero-dependency design eliminates transitive dependency failures in Lambda
- **Performance Efficiency**: Minimal overhead; no I/O beyond the standard logging handler
- **Cost Optimization**: Structured output reduces CloudWatch query cost vs. unstructured logs
- **Sustainability**: Lightweight; no unnecessary compute

</details>
