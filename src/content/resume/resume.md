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
**Remote | Aug 2024 - Present**

Lead Cloud Enablement efforts to improve AWS governance, compliance, and observability for Engineering teams managing 40+ AWS accounts, as part of a broader onboarding initiative spanning 800+ accounts organization-wide. Partner with engineering teams and stakeholders to build scalable automation tools for onboarding, alarm standardization, and sensitive data detection. Architected a reusable Python/PostgreSQL-based platform that empowers teams to identify resource waste, security gaps, and operational drift.

- **Automate CloudWatch Alarming management**: Use and extend the Terraform Alarming solution to support minimum recommended and custom alarming across Customer accounts creating a reusable foundation that scales well across Customers
- **AWS Resource Technical Debt Application**: Initiated and led the prototyping of a Python-based solution for analyzing AWS resource utilization, compliance and best practices across multiple team AWS environment accounts, enabling proactive detection and analysis of cross-environment cost, governance and security best practices aligning with Centene Corporate goals and objectives
- **Sensitive Data Identification**: Designed and implemented automated sensitive data detection in CloudWatch logs, leveraging keyword pattern matching and taxonomy-based classification; currently enhancing detection capabilities through iterative refinements
- **Collaboration**: Collaborated closely with internal team members and external stakeholders to identify, define, and communicate key value propositions in cost optimization, security enhancement, and governance compliance, ensuring the AWS Resource Technical Debt Tool delivered relevant and actionable insights aligned with organizational objectives
- **Design and build POC Automated Cloudwatch monitoring and alarming application**: Design bash application to manage AWS account alarming at scale
- **Migrate Alarm PoC Automated Alarming Application to MVP**: Work with fellow team members to migrate PoC application to Terraform application supporting standard and custom alarming solutions for Customers to use to manage their AWS CloudWatch alarming needs

### Sr. Site Reliability Engineer - Centene (Contractor via Zeektek)
**Remote | Dec 2023 - Aug 2024**

Enabled consistent deployment of AWS Recommended and custom alarms to support reliable, actionable monitoring across environments. Standardized alerting made it easier for teams to detect issues early, reduce configuration drift, and maintain consistent cross team scalable monitoring practices.

- **Hierarchical Alarm Customization**: Designed an intuitive, CSV-based hierarchical configuration supporting team, environment, resource-type, and resource-specific alarm overrides, enabling flexible and precise alarm management
- **Modular Core Architecture**: Developed a modular solution separating the core alarming engine (managed centrally via GitLab) from customer-specific configurations (via forked repositories), promoting standardization and simplifying maintenance while enabling team-specific customization without disrupting shared tooling
- **Automated CloudFormation Management**: Built automated deployment pipelines leveraging AWS CloudFormation to manage stack drift, deploy alarms automatically upon resource discovery, and systematically remove orphaned alarms
- **Minimal-Footprint Automation**: Engineered automated resource discovery and alarm deployment processes with minimal required AWS account permissions, enhancing security and governance
- **Enterprise Integration and Transition**: Piloted and production-validated alarm solution with three independent engineering teams, enabling enterprise-wide transition to standardized IaC workflows and governance-aligned alerting practices

### Site Reliability Engineer - Smartly
**Remote | Mar 2022 - Nov 2023**

Collaborated with AI-focused engineering teams as the AWS subject matter expert, guiding infrastructure modernization and observability improvements for reliability, performance, and scalability — aligning with AWS Well-Architected principles.

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
- **Post-Incident Analysis Support**: Supported Post-Incident reviews when sensitive data was exposed
- **Notification Architecture**: Designed notification architecture using SNS and Lambda to evaluate and route alerts based on configurable rule sets, enabling team-specific incident management alerting and reporting
- **Synthetic Monitoring Framework & SLA Enforcement**: Developed a lightweight BDD-based framework for automated functional and performance checks in production, executing every 10 minutes to validate critical user journeys. Captured backend service metrics during each run, enabling early detection of latency or degradation before customer impact. Defined synthetic SLAs, budgets and integrated alerting to proactively flag anomalies in backend components
- **Logging Standards & Monitoring Integration**: Established structured logging standards and developed a shared logging library used across teams, standardizing log formats which improved cross-team troubleshooting and reduced incident resolution time
- **Team Mentorship**: Mentored development teams on observability best practices, elevating logging quality and improving production system visibility

### Lead QA Automation Engineer - Welltok
**Denver, CO | Jun 2016 - Nov 2019**

Designed and led operational intelligence initiatives for a healthcare SaaS platform, enabling data-driven incident response and performance optimization through unified observability and SLA instrumentation.

- **Anomaly Detection Framework**: Designed advanced time-series analytics system in Splunk for anomaly detection, implementing hourly and weekly behavioral patterns with moving averages and standard deviation tracking
- **Unified Dashboards**: Built unified Splunk dashboards providing a single-pane view for Engineering, Ops, and Business teams
- **Integrated Observability System**: Developed integrated observability solution consolidating data from multiple sources (Splunk, CloudWatch, New Relic, Pingdom) using automated API polling and correlation
- **Logging Optimization**: Established logging standards reducing ingestion costs and improving log signal-to-noise ratio while meeting Security, Engineering, and Support requirements
- **SLI & SLA Instrumentation**: Created actionable Service Level Indicators (SLIs), alarm thresholds, and Splunk dashboards to track SLA compliance, budgets and operational health
- **Synthetic SLA Verification**: Built a Java/Selenium and Splunk-based synthetic monitoring solution to validate SLA compliance, trigger alerts for budget violations, and proactively detect issues beyond availability alone
- **Cross-Stack Visibility**: Enabled forensic analysis by correlating cross-stack telemetry, supporting engineering and SecOps investigations

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

**Cloud Platforms**: AWS (SDK, IAM, Config, Identity Center, Cost Explorer, API Gateway, SNS, SQS, EventBridge, Firehose, EKS, EC2, Lambda, RDS, EBS, ECS, VPC, VPCE, S3, CloudWatch, LB, Transit Gateway, Secrets Manager, SSM Parameter Store)

**Infrastructure & Automation**: Terraform, CloudFormation, Git, CI/CD, GitHub Actions, Bash

**Databases**: PostgreSQL, MySQL, SQL Server, DynamoDB

**Observability & Monitoring**: CloudWatch, Splunk, Dynatrace, New Relic, RUM, custom alerting frameworks

**Languages & SDKs**: Python (Boto3, AWS SDK), Java, Node.js, .NET, SQL

**Containers & Orchestration**: Podman, Docker, Kubernetes (Minikube, EKS)
