---
title: "Deployed Code Trumps Claims"
description: "In a field full of unverifiable claims, I choose to demonstrate capability through actual solutions. Here's why this approach works better for everyone."
publishDate: 2025-01-01
tags: ["Philosophy", "Career", "AI", "Engineering"]
featured: true
---

# Deployed Code Trumps Claims

The technology industry has a credibility problem. Resumes are filled with impressive-sounding claims that can't be verified. "Led digital transformation initiatives." "Architected scalable solutions." "Delivered enterprise-grade platforms."

What does any of that actually mean? More importantly, how would you know if it's true?

## The Problem with Unverifiable Claims

I've been in technology for over 20 years, and I've seen this pattern repeatedly. Engineers, especially those with experience, fall into the trap of describing what they've done rather than showing what they can do. The result is a sea of similar-sounding resumes that tell you nothing about actual capability.

Consider these common claims:

- "Built monitoring solutions that improved uptime"
- "Designed cost-effective cloud architectures"
- "Mentored junior engineers on best practices"

They might all be true. They might all be complete fiction. You'd never know the difference.

## My Alternative Approach (Or: How I Learned to Stop Worrying and Love Actual Evidence)

Instead of telling you what I've accomplished, I show you what I can build. This website isn't just a portfolio - it's a live demonstration that you can poke, prod, and verify for yourself.

**The Infrastructure**: Built with Terraform, deployed via GitHub Actions, hosted on AWS with CloudFront distribution and Route53 DNS management. The entire stack can be torn down and rebuilt in about 30 minutes. (I know this because I've rebuilt it end-to-end repeatedly to refine and verify the complete automation - at 10 times.)

**The Content Management**: Uses Astro's content collections with TypeScript schema validation. Blog posts are markdown files that compile to static pages with proper SEO and performance optimization. It's like a CMS, but without the part where everything breaks when you update it.

**The Automation**: Deployment scripts handle SSL certificates, DNS propagation, and CDN invalidation automatically. No manual steps, no clickops, no "works on my machine" moments at 2 AM.

Could I have just claimed "experience with AWS infrastructure automation"? Absolutely. But now you can see exactly what that means, and more importantly, you can try it out for yourself if you like.

## The Unexpected Learning Curve

Here's where things got interesting. This entire website - the infrastructure, the content management, the deployment automation, all the content you're reading - was built over three months while I was figuring out how to work effectively using common AI tools.

Turns out, when you have a conversation partner that never gets tired of explaining AWS IAM policies or debugging Terraform issues, you can move a lot faster than traditional approaches. Who knew?

The whole thing probably represents 3 months of part time effort and 10 hours of actual focused work time on the websites content. The rest was learning, experimenting, and occasionally staring at error messages wondering why CloudFront was returning 403s. (Spoiler: it's always the S3 bucket policy.)

## The Accidental Insights

Working this way, I started noticing patterns I hadn't seen before. Like how breaking problems into smaller, well-defined chunks makes everything easier - not just for AI collaboration, but for thinking through complex systems in general.

Or how documenting your reasoning as you go (because you're explaining it to an AI repeatedly) creates this weird side effect where future-you actually understands what past-you was thinking. Revolutionary stuff, I know.

And there's this thing that happens when you're constantly iterating on solutions - you start seeing the difference between "works" and "works reliably." The AI doesn't care if your deployment script fails 10% of the time, but production sure does.

## Why This Matters for Employers (And Why You Should Care)

When you're hiring for senior technical roles, you need to know what someone can actually deliver. Especially now when:

- **Technical debt is expensive**: Poor foundational decisions compound faster than credit card interest
- **Speed matters**: Markets move fast, and "we'll fix it later" usually means "we'll rewrite it next year"
- **Scale is complex**: Solutions that work for 10 users often explode spectacularly at 10,000
- **AI changes everything**: The ability to leverage AI effectively is becoming table stakes (whether we like it or not)

By showing rather than telling, I'm demonstrating:

- **Current capability**: These solutions work today, not in some mythical past project
- **Modern tooling**: AI-enhanced workflows, current AWS services, contemporary practices
- **Operational thinking**: Solutions designed for maintenance, not just initial deployment
- **Scalable patterns**: Architectures that handle growth without requiring a complete rewrite and three months of therapy

## The Foundational Practices Philosophy

Throughout my career, I learned to focus on "foundational practices" - small decisions that compound into significant long-term value. Things like:

- **Anticipating metadata needs**: Including context in logs and metrics so future-you doesn't hate past-you
- **Designing for extensibility**: Building systems that can grow without architectural changes (without pain and regret)
- **Automating everything possible**: Eliminating manual processes that introduce human error and weekend re-work
- **Measuring what matters**: Instrumenting systems to surface actionable insights, not just pretty dashboards

These practices aren't glamorous. They don't make for exciting resume bullets. But they're the difference between systems that scale gracefully and systems that require constant firefighting, re-work and a dedicated therapy budget.

## The Learning Acceleration

Here's something I didn't expect: working with AI tools taught me as much about my own thinking patterns as it did about technology. When you have to explain your reasoning clearly enough for an AI to understand and build on it, you discover all sorts of assumptions you didn't know you were making.

Like how I used to skip documenting "obvious" decisions that turned out to be not obvious at all six months later. Or how breaking complex problems into smaller pieces isn't just good for AI collaboration - it's good system design and for human collaboration too.

The speed improvement is real, but it's not magic. It's more like having a really patient expert pair programming partner who never gets tired of explaining AWS best practices and doesn't judge you for making consistent bad choices over and over again.

## What This Means for You

If you're evaluating technical talent, look for people who show their work. Ask for GitHub repositories, live demos, architectural decisions they can walk you through. Don't just accept claims about past accomplishments - anyone can claim they "led the migration to microservices."

If you're building your own career, consider shifting from telling to showing. Build something. Deploy it. Make it work at scale. Document the decisions and trade-offs. Let the work speak for itself, because it's a lot more convincing than your resume or confident assertions combined with hand waving.

And if you're exploring AI collaboration, approach it strategically. The tools are powerful, but they are limited and they're most definitely not magic. They accelerate good thinking; they don't replace it. Focus on learning how to structure problems and manage complexity - the AI will help you implement faster, but you still need to know what you're trying to build, ideally before you set out to build it.

## The Bottom Line

In a field where anyone can claim anything, demonstrable capability stands out. This website, my AWS projects, the automation frameworks - they're not just portfolio pieces. They're proof that I can actually build things that work, not just talk about building things that might work. They also enable me to focus on some really interesting [to me] projects that I've put off up untill now because it was not feasible to consider their undertaking without a solid foundation I could take for granted.

The code is live. The infrastructure is running. The solutions are working. You can verify all of this yourself.

That's not a claim. That's a fact you can check.

And honestly? After 20 years of reading resumes full of unverifiable claims, it feels pretty good to just point at something and say "there, that's what I can do."

---

*Want to see the technical details behind this website? Check out the [infrastructure projects](/work/) or explore the [technologies](/technologies/) I work with daily. Fair warning: some of the commit messages are embarrassing.*
