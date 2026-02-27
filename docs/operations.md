# Operations Guide

## Deployment Operations

### Local Development

#### Initial Setup

```bash
# Clone repository
git clone https://github.com/stephenabbot/website_denverbytes_com.git
cd website_denverbytes_com

# Bootstrap project
./scripts/bootstrap.sh

# Start development server
npm run dev
```

#### Content Development

```bash
# Start development server with live reload
npm run dev

# Build for production testing
npm run build

# Preview production build
npm run preview
```

### Production Deployment

#### Manual Deployment

```bash
# Deploy to production
./scripts/deploy.sh
```

The deployment script automatically:
1. Verifies prerequisites
2. Builds the website
3. Uploads to S3 with appropriate cache headers
4. Invalidates CloudFront cache
5. Verifies deployment success

#### Automated Deployment

Deployments trigger automatically on:
- Push to `main` branch
- Manual workflow dispatch

### Content Management

#### Adding Blog Posts

1. Create new file in `src/content/blog/`
2. Use frontmatter schema:
   ```yaml
   ---
   title: "Post Title"
   description: "Brief description"
   publishDate: 2025-01-04
   tags: ["tag1", "tag2"]
   featured: false
   ---
   ```

#### Adding Portfolio Items

1. Create new file in `src/content/work/`
2. Use frontmatter schema:
   ```yaml
   ---
   title: "Project Title"
   description: "Project description"
   publishDate: 2025-01-04
   tags: ["AWS", "Infrastructure"]
   img: "/assets/project-image.jpg"
   img_alt: "Image description"
   ---
   ```

#### Adding Experience Entries

1. Create new file in `src/content/experience/`
2. Use frontmatter schema:
   ```yaml
   ---
   company: "Company Name"
   role: "Job Title"
   location: "City, State"
   startDate: 2025-01-01
   endDate: 2025-12-31
   highlights: ["Achievement 1", "Achievement 2"]
   order: 1
   ---
   ```

## Monitoring and Maintenance

### Health Checks

#### Website Availability

```bash
# Check website is accessible
curl -I https://denverbytes.com

# Check specific pages
curl -I https://denverbytes.com/work/
curl -I https://denverbytes.com/about/
```

#### Infrastructure Status

```bash
# Check S3 bucket
aws s3 ls s3://denverbytes-com-static-prd/

# Check CloudFront distribution
aws cloudfront get-distribution --id EKEPX1BWBL81Q
```

### Performance Monitoring

#### CloudFront Metrics

Monitor in AWS Console:
- Cache hit ratio
- Origin latency
- Error rates
- Geographic distribution

#### Core Web Vitals

Use tools like:
- Google PageSpeed Insights
- Lighthouse
- WebPageTest

### Backup and Recovery

#### Content Backup

S3 versioning is enabled, providing automatic backup of all content versions.

#### Recovery Procedures

```bash
# List object versions
aws s3api list-object-versions --bucket denverbytes-com-static-prd

# Restore specific version
aws s3api copy-object \
  --copy-source "denverbytes-com-static-prd/index.html?versionId=VERSION_ID" \
  --bucket denverbytes-com-static-prd \
  --key index.html
```

## Security Operations

### Access Management

- Deployment access controlled via OIDC roles
- No long-lived credentials stored in GitHub
- Role permissions follow least privilege principle

### Security Monitoring

#### SSL Certificate Status

```bash
# Check certificate expiration
echo | openssl s_client -servername denverbytes.com -connect denverbytes.com:443 2>/dev/null | openssl x509 -noout -dates
```

#### Security Headers

```bash
# Check security headers
curl -I https://denverbytes.com
```

### Incident Response

#### Deployment Rollback

If deployment issues occur:

1. **Automatic rollback**: Deployment script includes backup/restore logic
2. **Manual rollback**: Restore from S3 version history
3. **Emergency**: Use CloudFront to serve cached content while fixing issues

#### Security Incidents

1. Rotate deployment role credentials if compromised
2. Review CloudFront access logs for suspicious activity
3. Update security headers if needed

## Cost Management

### Cost Monitoring

Monitor costs for:
- S3 storage and requests
- CloudFront data transfer
- Route53 DNS queries

### Cost Optimization

- Static site generation minimizes compute costs
- CloudFront caching reduces origin requests
- S3 Intelligent Tiering optimizes storage costs
- Lifecycle policies manage old versions
