---
title: "I Left Claude Pro. Claude Got Better."
description: "How I replaced a $20/month subscription with a $3/month AWS Bedrock setup that has no session limits, no message quotas, and complete data sovereignty — plus the Bedrock gotchas nobody warns you about."
publishDate: 2026-05-28
tags: ["AWS", "AI", "Bedrock", "Claude", "Security"]
featured: true
---

# I Left Claude Pro. Claude Got Better.

I was deep in a refactor — context loaded, momentum building, solution forming — when Claude told me to come back in 47 minutes. Flow destroyed. Again.

This wasn't a one-off annoyance. Claude.ai Pro has a rolling message quota and a hard 4-hour session ceiling. Hit either limit mid-task and you're done: context gone, session reset, work interrupted at the worst possible moment. For sustained engineering work — the kind where loading context takes twenty minutes and losing it costs an hour — these limits are architectural, not incidental.

So I pointed Claude Code at my own AWS account instead.

## What It Took

An AWS account, a Mac with Keychain, and about 15 minutes running a setup script. The result: same Claude models, same Claude Code CLI, no session limits, no message quotas, no subscription.

What it costs in practice: roughly $3/month for moderate personal use, billed per token. No minimum charges, no surprises.

What you gain beyond cost savings:

- **Sessions that don't cut you off.** Ever. You stop when you're done, not when AWS is done with you.
- **Complete data sovereignty.** Your prompts never leave your AWS account. Bedrock contractually does not use API inputs or outputs for model training. This matters if you work with sensitive code, client information, or operate in a regulated environment.
- **MFA-enforced security.** Credentials stored in macOS Keychain (AES-256), temporary session tokens that expire in 6 hours, and IAM policies that make permanent keys useless without a valid TOTP code.

## The Bedrock Gotchas Nobody Warns You About

Building this project surfaced a collection of undocumented (or poorly documented) behaviors. These are the things that cost me hours and might save you the same.

### 1. `aws bedrock` is not `aws bedrock-runtime`

The CLI splits Bedrock into two services: `bedrock` for management operations (listing models, checking access) and `bedrock-runtime` for actual inference. The error messages when you use the wrong one give zero hint about what's wrong. This is the number one gotcha for anyone new to Bedrock programmatic access.

### 2. `--body` requires `fileb://`

Passing inline JSON to `invoke-model` fails with a cryptic "Invalid base64" error in newer CLI versions. The fix is `fileb://` (a binary file reference). It's not obvious from the documentation, and the error message actively misleads you into thinking your JSON encoding is wrong.

### 3. Direct model IDs fail for Claude 4.x

`anthropic.claude-opus-4-6-v1` returns "on-demand throughput isn't supported — use an inference profile." You need the `us.` prefix: `us.anthropic.claude-opus-4-6-v1`. This applies to all Claude 4.x models and is not intuitive until you hit it.

### 4. A 1-token probe does not equal a usable model

This one was genuinely surprising. Opus passed a minimal invocation probe but timed out on real requests — three-plus minutes for a response — due to new-account throughput limits. The probe needs an aggressive timeout (I use 8 seconds) to distinguish "accessible" from "practically usable." This isn't in any documentation I've found.

### 5. Some flagship models require AWS Sales contact

Beyond any API call or console toggle. The only signal is "contact AWS Sales" buried in an AccessDeniedException. No amount of IAM policy changes or console clicks will fix this — it's a commercial gate, not a technical one.

### 6. `settings.json` silently overrides environment variables

Claude Code persists model selection in `~/.claude/settings.json`. If you set `ANTHROPIC_MODEL` in your environment but Claude is still using the wrong model, check that file. Easy to end up with conflicting configuration without realizing it.

## The Security Model

This project is arguably overengineered for personal use — and that's the point. The security posture demonstrates patterns that scale to corporate environments:

| Layer | Threat | Mitigation |
|-------|--------|------------|
| Credential storage | Keys stolen from disk | macOS Keychain (AES-256), never plaintext |
| Credential entry | Session recorders | Silent input — TOTP never echoed to terminal |
| Network access | Keys used without MFA | IAM requires `aws:MultiFactorAuthPresent` on all actions |
| Session lifetime | Token intercepted | 6-hour expiry, non-renewable without new MFA code |
| Blast radius | Compromised session | Policy grants only Bedrock invocation + model listing |

## Operational Roles: Claude as Your AWS Proxy

The base setup gives Claude zero operational access to AWS — it can only invoke models. But the real multiplier comes from giving Claude scoped authority to inspect your infrastructure, analyze logs, diagnose issues, and (optionally) make changes.

Operational roles use IAM AssumeRole with MFA-gated trust policies:

- **analyst** — Broad read-only access across CloudWatch, EC2, S3, IAM, Lambda, CloudFormation, and more. 6-hour session. Use case: "What's in these logs?", "Audit this account's IAM configuration."
- **operator** — Full administrator access. 1-hour session (intentionally short). Use case: "Deploy this infrastructure", "Fix this misconfiguration."

Each role is a CloudFormation stack with an explicit JSON policy document, deployed and versioned in the same repo. Add a custom role by copying a directory and editing the policy. No external dependencies, no shared state backend.

## The Meta Angle

The entire project — infrastructure, scripts, documentation, this blog post — was built with Claude Code running on the very Bedrock setup it enables. Claude helped design the IAM policies that constrain it, wrote the scripts that launch it, and reviewed its own operational role definitions.

There's something satisfying about an AI helping you build the harness that makes it more useful.

## The Bottom Line

If you use Claude Code regularly and hit session limits, pay for a Pro subscription you'd rather not, or work with code that shouldn't leave your infrastructure — this solves all three problems for less money with more control.

It's open source. Clone it, run `deploy.sh`, and stop losing context mid-thought.

**Repository:** [github.com/stephenabbot/claude-personal](https://github.com/stephenabbot/claude-personal)

---

*For the technical implementation details — IAM policies, model selection logic, role architecture — see the [project case study](/work/claude-personal/).*
