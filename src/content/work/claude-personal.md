---
title: Claude Personal
publishDate: 2026-05-28 00:00:00
img: /assets/stock-4.jpg
img_alt: AI agent running Claude Code via AWS Bedrock with IAM role assumption
description: |
  Run Claude Code on a personal Mac via AWS Bedrock — no subscription required.
  MFA-enforced sessions, automatic model selection, and assumable operational
  roles for scoped AWS access.
tags:
  - AWS
  - Bedrock
  - IAM
  - Security
  - AI
  - CloudFormation
repo: https://github.com/stephenabbot/claude-personal
---

## The Problem

Claude.ai Pro imposes a rolling message quota and a 4-hour session limit. Hit either mid-task and your flow is destroyed — context lost, momentum gone, session reset. For sustained engineering work this is a recurring interruption at the worst possible moment.

Beyond limits, every prompt and response routes through Anthropic's infrastructure. For sensitive code, client data, or regulated environments, that's a data sovereignty concern with no mitigation.

## The Approach

Shell scripts that authenticate via MFA, obtain short-lived STS credentials, and launch Claude Code against your own AWS Bedrock endpoint. No subscription, no session limits, no message quotas. Your prompts never leave your AWS account.

The launcher automatically probes for the best available model (Opus > Sonnet > Haiku) using a live 1-token invocation with an 8-second timeout, caches the result for the session, and notifies if a newer same-tier model exists but isn't yet accessible.

Operational roles extend Claude's authority beyond model invocation — read-only analysis, log inspection, or full administrative access — via IAM AssumeRole with MFA-gated trust policies. Each role is a CloudFormation stack with an explicit policy document, deployed and versioned alongside the project.

## The Outcome

Uninterrupted Claude Code sessions at ~$3/month. Complete data sovereignty. Layered security (Keychain, MFA, temporary credentials, scoped IAM). Self-contained — clone, deploy, use.

## Stack

| Technology | Purpose |
|------------|---------|
| AWS Bedrock | Model inference (Claude Opus, Sonnet, Haiku) |
| AWS IAM | Least-privilege policies, MFA enforcement |
| AWS STS | Temporary session credentials (6-hour expiry) |
| AWS CloudFormation | Operational role provisioning |
| macOS Keychain | Credential storage (AES-256, never plaintext) |
| Claude Code | AI coding assistant CLI |
| Bash | Launcher, authentication, deployment scripts |

**Repository**: [claude-personal](https://github.com/stephenabbot/claude-personal)

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Automated model selection and session management; zero manual AWS console steps after initial setup
- **Security**: MFA-enforced at every layer; credentials never touch disk; temporary sessions expire automatically; operational roles scoped by explicit policy documents
- **Reliability**: Automatic fallback across model tiers; session caching prevents redundant probes; graceful handling of throttled or unavailable models
- **Performance Efficiency**: 1-token probe with timeout distinguishes accessible from practically usable models; session cache eliminates repeated API calls
- **Cost Optimization**: Pay-per-token (~$3/month typical); no subscription; Cost Explorer integration for visibility
- **Sustainability**: No idle infrastructure; serverless inference; ephemeral credentials with no rotation overhead

</details>
