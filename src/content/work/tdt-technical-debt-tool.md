---
title: Technical Debt Tool
publishDate: 2026-01-01 00:00:00
img: /assets/stock-3.jpg
img_alt: Abstract diagram of interconnected AWS accounts and data flows
description: |
  Enterprise account analysis platform: programmatic discovery of resources,
  costs, security findings, and compliance drift across 40+ AWS accounts
  in an 800+ account organization.
tags:
  - AWS
  - Python
  - PostgreSQL
  - Enterprise
  - Security
---

## The Problem

In organizations managing dozens or hundreds of AWS accounts, most accounts contain decisions made by people who have since moved on, configurations inherited from other teams, and resources that have outlived their original purpose. There is no native AWS tool that answers the fundamental operational question: *what is actually in this account, why does it exist, and is it safe to change?*

Without visibility, teams face a predictable set of problems. Phantom resources — orphaned EBS volumes, detached Elastic IPs, Lambda functions triggered by nothing — accumulate silently, costing money without delivering value. Security misconfigurations persist because no one has reviewed the account since it was set up. IAM policies grow through the path of least resistance: broader permissions requested, granted, and never revisited. Compliance drift is invisible until an audit surfaces it. And when teams inherit accounts they didn't build, they inherit all of this — with no map.

The consequence is decision paralysis. Teams are reluctant to prune or refactor infrastructure they don't fully understand. The cost of understanding an account from scratch is high. The risk of changing something that turns out to be load-bearing is real. So accounts grow in complexity and cost, year over year, because the barrier to cleaning them up is too high.

## The Approach

The Technical Debt Tool is a Python/PostgreSQL platform that programmatically analyzes AWS account configurations and surfaces findings across four domains:

**Resource inventory**: Comprehensive discovery of all deployed resources — compute, storage, networking, serverless, database — with metadata, configuration state, and age. The goal is a complete map of what exists, not a sample.

**Cost analysis**: Identification of resources that are consuming budget without delivering value — phantom resources, oversized instances, unused reserved capacity, orphaned storage. Each finding is traceable to a specific resource with enough context to make a confident remediation decision.

**Security findings**: Configuration analysis against established baselines — public S3 buckets, unrestricted security groups, IAM policies with wildcards, CloudTrail disabled, encryption gaps. Findings are categorized by severity and include the specific configuration that triggered them.

**Compliance visibility**: Account-level assessment against internal governance standards. Which accounts meet baseline requirements, which have gaps, and where the gaps are — enabling prioritized remediation rather than undifferentiated panic.

Findings are stored in PostgreSQL, enabling cross-account queries, trend analysis over time, and reporting at both account and organizational levels.

## The Outcome

Deployed across 40+ AWS accounts in an 800+ account enterprise organization at a Fortune 23 healthcare company. The platform converted multi-day manual account reviews into automated analysis runs. Teams that inherited accounts with no documentation had a structured starting point instead of blank-screen paralysis. Security and compliance findings that had existed undetected were surfaced and prioritized. Cost optimization opportunities were identified and confirmed as safe to act on.

The v1 codebase demonstrated the core value of the approach. It also revealed the limitations of building a production system in a language being learned while building it. A v2 rebuild is in progress as a personal project, applying the architectural lessons from v1 with better separation of concerns, a more modular findings engine, and a cleaner data model.

*Note: The v1 codebase is employer intellectual property and cannot be shared. The v2 rebuild will be open source. This page will link to the repository when it is ready.*

## Stack

| Technology | Purpose |
|------------|---------|
| Python | Analysis engine and findings processing |
| PostgreSQL | Findings storage, cross-account queries, reporting |
| AWS SDK (boto3) | Account resource discovery across all services |
| AWS Organizations API | Account enumeration and metadata |
| AWS Cost Explorer API | Cost data aggregation |
| AWS Security Hub / Config | Security and compliance finding inputs |
| AWS IAM (cross-account roles) | Secure read-only access across accounts |

## V2 Direction

The rebuild addresses the structural limitations of v1:

- **Modularity**: Each findings domain (cost, security, compliance, inventory) as an independent module with a defined interface — enabling independent development, testing, and extension
- **Data model**: A cleaner schema that separates finding types, supports severity scoring, and enables time-series tracking of finding resolution
- **Configuration**: External configuration for account targets, finding rules, and thresholds — removing the hard-coded assumptions in v1
- **Testing**: A test suite, absent from v1, that enables confident iteration

The v2 repo will be public when the core is functional. The problem it solves is real and the architecture is defensible. The v1 outcome proved the value. The v2 rebuild is about doing it right.

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Converts manual account review into automated, repeatable analysis; findings are documented and tracked over time
- **Security**: Read-only cross-account access via least-privilege IAM roles; surfaces security misconfigurations that would otherwise persist undetected
- **Reliability**: PostgreSQL findings store persists across analysis runs; incremental updates enable trend tracking
- **Performance Efficiency**: Parallel account analysis; boto3 pagination handles accounts of any size
- **Cost Optimization**: Identifies phantom resources and cost waste; confirmed findings enable confident action without blast-radius risk
- **Sustainability**: Analysis runs on demand; no idle infrastructure when not scanning

</details>
