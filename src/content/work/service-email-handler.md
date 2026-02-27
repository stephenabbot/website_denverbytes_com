---
title: Email Handler
publishDate: 2026-01-15 00:00:00
img: /assets/stock-2.jpg
img_alt: AWS email pipeline with Lambda and DynamoDB
description: |
  A small AWS service that receives contact emails, enriches them with context, and
  forwards them to the right inboxes using SES and Lambda. Zero-maintenance contact
  management at pennies per month.
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
- **Performance Efficiency**: Event-driven Lambda; no polling or idle compute
- **Cost Optimization**: Serverless pay-per-use; near-zero cost at low email volumes
- **Sustainability**: No idle servers; Lambda invokes only on received mail

</details>
