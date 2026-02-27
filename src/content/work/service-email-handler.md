---
title: Email Handler
publishDate: 2026-01-15 00:00:00
img: /assets/stock-2.jpg
img_alt: AWS email pipeline with Lambda and DynamoDB
description: |
  Serverless email handler that receives contact emails, enriches them with context, and
  forwards them to the right inboxes using SES and Lambda. True pay-per-use architecture
  costs effectively $0/month at portfolio contact volumes, with automatic scaling as a
  foundational CRM component that extends to support custom workflows.
tags:
  - AWS
  - Lambda
  - SES
  - SQS
  - Python
  - DynamoDB
repo: https://github.com/stephenabbot/service-email-handler
---

## The Problem

A public contact address for the portfolio projects needs to handle spam, acknowledge first contact, route replies without exposing a private mailbox, and maintain a searchable record of every conversation. Without automation, this is manual triage on every inbound message and reply.

## The Approach

AWS SES receives inbound email. A Lambda-based pipeline applies three-stage spam filtering (SES verdict flags, recipient validation, PCRE2 pattern matching), auto-acknowledges first contact, and forwards legitimate mail to a private mailbox with thread-aware reply routing via a subdomain.

All outbound sends are routed through SQS queues with dedicated sender Lambdas implementing exponential backoff retry — no email is silently lost to transient failures. LinkedIn senders get human-readable conversation IDs extracted from display names. DMARC alignment is enforced by rejecting sends on custom MAIL FROM failures rather than falling back to Amazon's default domain.

Conversation metadata is stored in DynamoDB with 8 GSIs for structured querying.

## The Outcome

A public address (`stephen.abbot@denverbytes.com`) that handles spam automatically, acknowledges every first contact, and maintains a searchable record of every conversation without manual tracking.

Replies route back to senders via the thread subdomain, keeping the private mailbox address internal.

The architecture serves as a foundational CRM component — the same event-driven patterns extend to support custom workflows like lead scoring, automated follow-ups, or integration with external systems as business needs evolve.

## Cost Model

True serverless economics — pay only for actual email traffic with automatic scaling:

**At ~200 emails/month (typical portfolio contact volume):**
- **SES**: $0.04/month (200 inbound × $0.0001 + 400 outbound × $0.0001)
- **Lambda**: $0.00/month (well within 1M free requests + 400K GB-seconds)
- **DynamoDB**: $0.00/month (on-demand within 25 GB free tier)
- **S3**: $0.00/month (email archive within 5 GB free tier)
- **SQS**: $0.00/month (within 1M free requests)
- **CloudWatch**: $0.00/month (within 5 GB free ingestion)

**Total: ~$0.04/month** in a paid account, **$0.00/month** during AWS Free Tier (12 months)

No idle infrastructure costs. Scales automatically to thousands of emails/month with proportional pricing — add $0.20 per 1,000 additional emails. The same Lambda functions and DynamoDB tables handle 10× traffic without configuration changes.

## Stack

| Technology | Purpose |
|------------|---------|
| AWS SES | Email receipt, DKIM signing, delivery |
| AWS Lambda (Python 3.12) | 3 processing (inbound, reply, attachment) + 3 senders (ack, forward, reply) |
| AWS SQS | Send queues with DLQs — exponential backoff retry for all outbound email |
| AWS S3 | Email archive, attachments, extracted text |
| AWS DynamoDB | Conversation tracking (8 GSIs) |
| AWS CloudWatch / SNS | Structured logging, 9 alarms (Lambda errors + DLQ depth) |
| AWS SSM | Spam keyword config indirection |
| AWS Route53 | MX, SPF, DKIM, DMARC, thread subdomain |
| OpenTofu / Terraform | Full infrastructure as code |

**Repository**: [service-email-handler](https://github.com/stephenabbot/service-email-handler)

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Full IaC; automated spam management; structured conversation records
- **Security**: DKIM/SPF/DMARC on all outbound mail; S3 AES256 encryption; least-privilege Lambda roles; private mailbox never exposed to senders
- **Reliability**: SES managed availability; SQS queues with exponential backoff retry and dead-letter queues ensure no outbound email is silently lost; DynamoDB PAY_PER_REQUEST scales to any volume; S3 11-nine durability for archive
- **Performance Efficiency**: Event-driven Lambda; no polling or idle compute; sub-second email processing
- **Cost Optimization**: True serverless pay-per-use — effectively $0/month at portfolio contact volumes (~200 emails), $0.04/month in paid accounts; scales automatically to thousands of emails with proportional pricing
- **Sustainability**: No idle servers; Lambda invokes only on received mail; zero compute waste

</details>
