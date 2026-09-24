# AGENTS.md - Development Guidelines

## 🚀 Core Commands
Node version is pinned in `.mise.toml` (run `mise install` to match it).
```bash
npm install        # Install dependencies
npm run dev        # Start dev server (localhost:4321)
npm run build      # Download Gravatar, then production build into dist/
npm run preview    # Serve the production build locally
```
`npm run build` needs network access to gravatar.com (see `scripts/gravatar.mjs`).

## 📂 Project Structure
- `/src/layouts/`: Astro layouts (`BaseLayout.astro` is the root; `PageLayout` and `ArticleLayout` wrap it)
- `/src/pages/`: Routes (`words/` is the blog index and `[...slug].astro` renders posts)
- `/src/content/words/`: Blog posts (`YYYY-MM-DD-title.md`), images in `attachments/`
- `/src/content.config.ts`: Content collection schema for posts
- `/src/styles/global.css`: All site styles
- `/src/data/site.json`: Site info and social links
- `/public/`: Static files copied as-is (`_headers`, fonts, CV, `.well-known/security.txt`)
- `/scripts/`: Build helpers
- `/terraform/`: Cloudflare DNS and redirects

## 🛠️ Coding Standards

### Astro
- **Encoding**: Always use UTF-8.
- **Components**: Keep shared markup in layouts; pages stay thin.
- **Inline scripts**: Use `<script is:inline>` only when the script must run before paint (e.g. theme).

### Frontend (CSS & JS)
- **CSS**: Mobile-first, BEM-like naming (`.block__element--modifier`).
- **Theming**: Use CSS Custom Properties (`:root` vs `[data-theme='dark']`).
- **JS**: Vanilla ES6+; wrap inline scripts in IIFEs; use `localStorage` for theme persistence.

### Naming Conventions
- **Files**: kebab-case for content, PascalCase for Astro layouts/components.
- **Classes**: kebab-case (e.g., `.blog-post`).
- **JS Variables/Functions**: camelCase.
- **Constants**: UPPER_SNAKE_CASE.

## 📝 Content & Assets
- **Blog Posts**: Front matter needs `title` and `date`; optional `slug`, `author`, `tags`, `draft: true` hides a post.
- **Images**: Put post images in `src/content/words/attachments/` so Astro optimizes them.
- **Fonts**: Self-hosted in `/public/fonts/`; no external font CDNs.
- **Accessibility**: Semantic HTML, proper heading hierarchy, and alt text.

## 🛡️ Security & Performance
- **CSP**: Managed in `public/_headers`. Only whitelist domains the site actually loads from.
- **HSTS**: Always enforced (HSTS header in `_headers`).
- **security.txt**: `public/.well-known/security.txt`; bump `Expires` before it lapses.
- **Dependencies**: Dependabot opens weekly npm and monthly Terraform provider update PRs; run `npm audit` before merging npm ones.

## 🔄 Deployment Workflow
1. **Feature branch**: `feature/your-change`.
2. **Verify**: `npm run build` must pass.
3. **CI/CD**: Cloudflare Pages automatically deploys on push to `main`.
