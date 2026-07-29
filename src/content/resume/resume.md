---
name: "Stephen (Steve) Abbot"
title: "Senior Site Reliability Engineer"
location: "Denver, Colorado"
website: "https://denverbytes.com"
github: "https://github.com/stephenabbot"
linkedin: "https://www.linkedin.com/in/stephen-abbot"
certifications:
  - "AWS Certified Cloud Practitioner"
  - "AWS Certified AI Practitioner"
summary: "Senior Site Reliability Engineer with deep expertise in building scalable observability, automation, and governance solutions across complex AWS environments. Proven track record of delivering high-impact platforms that improve visibility, optimize cost and security, and proactively detect reliability risks at scale. Passionate about enabling teams through onboarding automation, monitoring, observability and alarm standardization, and compliance-focused tooling. Architect of reusable, secure infrastructure solutions that elevate resilience, performance, and operational efficiency across the enterprise."
---

## Experience

### Sr. Site Reliability Engineer - Centene
**Remote | Aug 2024 - Aug 2026**

Led Cloud Enablement efforts to improve AWS governance, compliance, and observability for Engineering teams managing 40+ AWS accounts, as part of a broader onboarding initiative spanning 800+ accounts organization-wide. Partnered with engineering teams and stakeholders to build scalable automation tools for onboarding, alarm standardization, and sensitive data detection. Architected a reusable Python/PostgreSQL-based platform that empowered teams to identify resource waste, security gaps, and operational drift.

- **Automated CloudWatch Alarming Management**: Designed, implemented, and extended an in-house Terraform-based alarming solution delivering minimum-recommended and custom CloudWatch alarms across Customer accounts — establishing a reusable, governance-aligned alerting foundation at scale
- **Sensitive Data Identification (S3 and CloudWatch)**: Applied AWS Macie for S3 bucket sensitive data scanning; engineered a complementary CloudWatch log analysis tool using keyword pattern matching and taxonomy-based classification to extend detection to log groups — a surface Macie did not cover at the time
- **Cross-Account Environment Drift Analysis**: Built configuration comparison capability across environment-progression account sets (dev → tst → stg → prd), identifying resources and configurations present in production without corresponding coverage in lower environments — surfacing untested infrastructure, compliance gaps, and deployment risks for teams

### Sr. Site Reliability Engineer - Centene (Contractor via Zeektek)
**Remote | Dec 2023 - Aug 2024**

Enabled consistent deployment of AWS Recommended and custom alarms to support reliable, actionable monitoring across environments. Standardized alerting made it easier for teams to detect issues early, reduce configuration drift, and maintain consistent cross team scalable monitoring practices.

- **Account Intelligence Tool**: Designed and built a modular Python reconnaissance tool — aggregating Config, Trusted Advisor, Cost Explorer, Security Hub, Macie, IAM, and service-level APIs — to establish ground-truth account visibility before each team onboarding engagement; surfaced alarming candidates alongside governance findings (tag non-compliance, CloudWatch log encryption and retention gaps, cost anomalies, sensitive data exposure) that teams had been unaware of in (often inherited) accounts; extensible by design — each additional discovery capability was added incrementally as a new API module
- **Hierarchical Alarm Customization**: Designed an intuitive, CSV-based hierarchical configuration supporting team, environment, resource-type, and resource-specific alarm overrides, enabling flexible and precise alarm management
- **Modular Core Architecture**: Developed a modular solution separating the core alarming engine (managed centrally via GitLab) from customer-specific configurations (via forked repositories), promoting standardization and simplifying maintenance while enabling team-specific customization without disrupting shared tooling
- **Automated CloudFormation Management**: Built automated deployment pipelines leveraging AWS CloudFormation to manage stack drift, deploy alarms automatically upon resource discovery, and systematically remove orphaned alarms
- **Minimal-Footprint Automation**: Engineered automated resource discovery and alarm deployment processes with minimal required AWS account permissions, enhancing security and governance
- **Enterprise Integration and Transition**: Piloted and production-validated alarm solution with three independent engineering teams, enabling enterprise-wide transition to standardized IaC workflows and governance-aligned alerting practices

### Site Reliability Engineer - Smartly
**Remote | Mar 2022 - Nov 2023**

Provided thought leadership and collaborated closely with AI-focused engineering teams as the AWS subject matter expert, guiding infrastructure modernization and observability improvements to meet enterprise-grade expectations for reliability, performance, and scalability — aligning with AWS Well-Architected principles.

- **Containerization and Cloud Migration**: Architected and executed migration from Elastic Beanstalk to a container-based microservices architecture leveraging Lambda, ECS, EKS, reducing cost, improving system scalability, flexibility, and reducing operational maintenance effort
- **Database Performance Optimization**: Identified critical PostgreSQL performance bottlenecks through detailed analysis, facilitating a strategic migration to Amazon Aurora for enhanced scalability and reliability
- **Global Delivery Enhancement**: Improved global application performance and security posture by integrating CloudFront CDN and AWS API Gateway, reducing latency and enhancing user experience
- **Comprehensive Observability Implementation**: Built a robust observability framework using CloudWatch (RUM, Metrics, Logs) with Open Telemetry, enabling data-driven, cross-stack performance optimizations and distributed tracing
- **Proactive Monitoring and Alerting**: Developed automated alerting mechanisms using AWS CloudWatch and SNS, providing real-time incident detection and notification workflows that improved response speed and on-call visibility
- **Team Mentorship and Best Practices**: Mentored junior developers and peers in AWS best practices across critical technologies including RDS, EKS, Lambda, and secure VPC configurations, fostering skill development and team alignment

### Site Reliability Engineer - TalentReef
**Denver, CO | Nov 2019 – Mar 2022**

Led platform-wide observability and alerting initiatives for a growing pre-IPO HR SaaS platform. Transitioned from QA leadership to drive system-wide monitoring, automation, and reliability practices.

- **Enterprise Observability Platform**: Architected end-to-end observability platform integrating Splunk, CloudWatch, New Relic and Pingdom data streams, enabling cross-domain visibility and reducing Mean Time to Recognize and Repair
- **Splunk Administration & Dashboard Consolidation**: Served as on-site Splunk admin, setting up, configuring, and maintaining the on-premises cluster, and consolidating operational data into single-pane dashboards for multiple teams, improving log reliability, indexing efficiency, and cross-team observability
- **Log Aggregation Pipeline**: Implemented centralized log aggregation and analysis pipeline using AWS Firehose and Lambda, correlating events across services using transaction IDs and contextual metadata
- **Security Incident Forensics**: Built Splunk-based forensic reports correlating AWS CloudTrail audit events with service-level API call and response logs into a unified, timestamped timeline, enabling precise reconstruction of authorized user activity during sensitive data exposure incidents; supported post-incident reviews when sensitive data was exposed
- **Notification Architecture**: Designed notification architecture using SNS and Lambda to evaluate and route alerts based on configurable rule sets, enabling team-specific incident management alerting and reporting
- **Synthetic Monitoring Framework & SLA Enforcement**: Developed a lightweight BDD-based framework for automated functional and performance checks in production, executing every 10 minutes to validate critical user journeys. Captured backend service metrics during each run, enabling early detection of latency or degradation before customer impact. Defined synthetic SLAs, budgets and integrated alerting to proactively flag anomalies in backend components
- **SLI Definition & Reliability Reporting**: Defined internal Service Level Indicators (SLIs) for platform services using Splunk for analysis, dashboarding, and alarming, giving engineering teams a shared, data-driven view of reliability and early-warning signals
- **Logging Standards & Monitoring Integration**: Established structured logging standards and developed a shared logging library used across teams, standardizing log formats which improved cross-team troubleshooting and reduced incident resolution time
- **Team Mentorship**: Mentored development teams on observability best practices, elevating logging quality and improving production system visibility

### Site Reliability Engineer - Welltok
**Denver, CO | Jun 2016 - Nov 2019**

Designed and led operational intelligence initiatives for a healthcare SaaS platform, enabling data-driven incident response and performance optimization through unified observability and SLA instrumentation.

- **Anomaly Detection Framework**: Designed advanced time-series analytics system in Splunk for anomaly detection, implementing hourly and weekly behavioral patterns with moving averages and standard deviation tracking
- **Unified Dashboards**: Built unified Splunk dashboards providing a single-pane view for Engineering, Ops, and Business teams
- **Integrated Observability System**: Developed integrated observability solution consolidating data from multiple sources (Splunk, CloudWatch, New Relic, Pingdom) using automated API polling and correlation
- **Logging Optimization**: Established logging standards reducing ingestion costs and improving log signal-to-noise ratio while meeting Security, Engineering, and Support requirements
- **SLI, SLO & SLA creation**: Defined Service Level Indicators, Objectives and Agreement tracking, reporting and alarming for compliance, internal engineering teams and external customer SLA reporting support
- **Synthetic SLA Verification**: Built a Java/Selenium and Splunk-based synthetic monitoring solution to validate SLA compliance, trigger alerts for budget violations, and proactively detect issues beyond availability alone
- **Security Incident Forensics Visibility**: Applied Splunk-based forensic correlation of AWS CloudTrail audit events and service-level API logs to reconstruct authorized user activity timelines across multiple sensitive data exposure incidents, supporting SecOps and compliance investigations

### Sr. QA Engineer - Nordstrom Financial
**Denver, CO | Nov 2015 - Apr 2016**

Automation Frameworks & Financial Data Validation: Delivered automated test and data validation solutions for a credit card services platform processing ~$12B annually.

- Designed and maintained a SpecFlow/C# test automation framework to validate end-to-end payment processing systems
- Contributed to fraud detection and data integrity during annual financial reporting cycles, ensuring compliance and reducing risk

### QA Engineer - Sandhill Scientific
**Highlands Ranch, CO | Oct 2014 - Oct 2015**

Medical Device QA & Regulatory Compliance: Supported software QA and FDA regulatory validation for an embedded medical device product line.

- Designed automated compliance and reporting workflows using Microsoft Team Foundation Server
- Developed a C# test automation framework for validating embedded device firmware and desktop application functionality across releases

### QA Engineer - Flatirons Solutions
**Boulder, CO | Nov 2012 – Aug 2014**

Enterprise QA & Platform Migration: Provided QA engineering support for an enterprise document management platform used by major aerospace clients.

- Built an automated validation framework for technical documentation processing pipelines
- Developed a Java-based data transformation tool to support legacy platform migration and integration

### QA SDET Automation Engineer - Seterus IBM
**Morrisville, NC | Nov 2011 - Aug 2012**

ETL Monitoring & Automation Enablement: Supported QA and automation efforts for Seterus, a mortgage processing division within IBM.

- Designed and implemented an ETL monitoring and alerting solution to improve visibility and reliability in mortgage data pipelines
- Built internal automation tooling and provided support to engineering teams for test development and framework integration

### Professional Services Engineer - Tekelec
**Morrisville, NC | Mar 2005 - Nov 2011**

Network Intelligence & Telecom Analytics: Delivered engineering solutions and field support for Tier-1 telecom carriers, spanning both pre-sales design and post-deployment troubleshooting.

- Designed and supported customer-specific analytics tools for network traffic pattern detection
- Led global on-site engagements covering solution design, deployment, and technical troubleshooting for high-volume telecom platforms, delivering outcomes that met SLA and earned formal customer sign-off

### Sr. QA Engineer - Aspect Communications
**Chelmsford, MA | 2001 – 2005**

Messaging & Lab Infrastructure: Performed QA for a .NET-based IP telecom messaging and monitoring platform, supporting provisioning, reporting, and configuration workflows.

- Developed and executed test plans across provisioning, reporting, and configuration components
- Maintained a 75-node hybrid Windows/Linux lab environment for continuous test coverage

### Sr. Visual Basic Developer - Production Process
**Londonderry, NH | 2000 – 2001**

Real-Time Manufacturing Systems: Modernized and supported real-time control software for factory automation, leading initiatives to upgrade legacy code, improve UI design, and adopt better development practices.

- Defined and implemented development practices for real-time manufacturing production control software
- Upgraded code from VB4 to VB6 for enhanced performance and compatibility
- Collaborated with clients, management, and engineers to refine functional and UI requirements

### Lead Visual Basic Developer - Digital Equipment Corporation
**Marlboro, MA | 1994 – 2000**

Demand Planning & Pre-Sales Automation: Led the development of global business applications for demand planning and quoting, delivering solutions that significantly improved speed, accuracy, and user experience.

- Led the design and delivery of a global distributed Demand Planning Solution for Digital's product line
- Developed an automated pre-sales configuration and quoting tool, reducing quote time by 80%
- Collaborated with stakeholders to refine system requirements and UI design

## Skills

**Cloud Platforms**: AWS (Trusted Advisor, Security Hub, Macie, CloudTrail, SDK, IAM, Config, Identity Center, Cost Explorer, API Gateway, SNS, SQS, EventBridge, Firehose, EKS, EC2, Lambda, RDS, EBS, ECS, VPC, VPCE, S3, CloudWatch, LB, Transit Gateway, Secrets Manager, SSM Parameter Store)

**Infrastructure & Automation**: Terraform, CloudFormation, Git, CI/CD, GitHub Actions, Bash

**Databases**: PostgreSQL, MySQL, SQL Server, DynamoDB

**Observability & Monitoring**: CloudWatch, Splunk, Dynatrace, New Relic, RUM, custom alerting frameworks

**Languages & SDKs**: Python (Boto3, AWS SDK), Java, Node.js, .NET, SQL

**Containers & Orchestration**: Podman, Docker, Kubernetes (Minikube, EKS)
