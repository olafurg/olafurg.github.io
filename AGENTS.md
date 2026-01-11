# AGENTS.md - Development Guidelines

## 🚀 Core Commands (Docker Only)
All local development **must** be performed via Docker Compose to ensure environment consistency.
```bash
docker compose up         # Start dev server (localhost:4567, LiveReload:35729)
docker compose up --build  # Rebuild after Gemfile changes
docker compose down -v    # Reset environment & gem cache
docker compose exec app bundle exec middleman build  # Production build
docker compose exec app bundle exec middleman article "TITLE" # Scaffold blog post
docker compose run --rm app pre-commit run --all-files # Manual lint check
```

## 📂 Project Structure
- `/source/layouts/`: ERB templates (`base_layout.erb` is the root)
- `/source/words/articles/`: Blog posts (`YYYY-MM-DD-title.html.md`)
- `/source/stylesheets/`: SCSS (managed via `all.css.scss`)
- `/source/javascripts/`: Vanilla JS / jQuery (`all.js`, `theme_switcher.js`)
- `/data/`: YAML data files (site info, social links)
- `/_headers`: Netlify/Cloudflare security headers & CSP

## 🛠️ Coding Standards

### Ruby & Middleman
- **Encoding**: Always use UTF-8.
- **Partials**: Use `<%= partial "name" %>` (omitting the underscore).
- **Helpers**: Defined in `config.rb` helper block.

### Frontend (SCSS & JS)
- **CSS**: Mobile-first, BEM-like naming (`.block__element--modifier`).
- **Theming**: Use CSS Custom Properties (`:root` vs `[data-theme='dark']`).
- **JS**: Use ES6+; wrap scripts in IIFEs; use `localStorage` for theme persistence.
- **jQuery**: Allowed for DOM manipulation where it simplifies logic.

### Naming Conventions
- **Files**: snake_case (e.g., `theme_switcher.js`).
- **Classes**: kebab-case (e.g., `.blog-post`).
- **JS Variables/Functions**: camelCase.
- **Constants**: UPPER_SNAKE_CASE.

## 📝 Content & Assets
- **Blog Posts**: Require YAML front matter (`title`, `date`, `published`).
- **Images**: Optimize for web; store in `/source/images/`.
- **Accessibility**: Semantic HTML, proper heading hierarchy, and alt text.

## 🛡️ Security & Performance
- **CSP**: Managed in `source/_headers`. Whitelist external domains and use hashes for inline scripts.
- **HSTS**: Always enforced (HSTS header in `_headers`).
- **Assets**: Minified automatically in production builds (`config.rb`).

## 🔄 Deployment Workflow
1. **Feature branch**: `feature/your-change`.
2. **Pre-commit**: Docker-based hooks ensure linting/formatting pass.
3. **CI/CD**: Cloudflare Pages automatically deploys on push to `main`.
4. **Build**: Verify via `docker compose exec app bundle exec middleman build --clean`.