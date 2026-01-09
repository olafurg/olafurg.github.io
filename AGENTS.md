# AGENTS.md - Development Guidelines for olafurg.github.io

## Build & Development Commands

### Core Commands
```bash
# Docker development (recommended for consistency)
docker-compose up

# Docker development with live reload
docker-compose up --build

# Stop Docker containers
docker-compose down

# Clean Docker volumes
docker-compose down -v

# Local development (if Docker unavailable)
bundle exec middleman server

# Build production site
bundle exec middleman build

# Generate new blog article
bundle exec middleman article "TITLE"

# Install dependencies (Docker handles automatically)
bundle install
```

### Code Quality
```bash
# Pre-commit hooks run automatically on commit
# Manual hook execution:
pre-commit run --all-files
```

### Testing
No formal testing framework is currently implemented. When adding tests:
- Use Minitest for Ruby/Middleman testing (with spec-style syntax using `describe` and `it`)
- Use Jest for JavaScript testing
- Place tests in `/test/` directory

#### Minitest Spec Example
```ruby
require 'minitest/autorun'

describe MyHelper do
  it "should format dates correctly" do
    expect(MyHelper.format_date(Date.new(2023, 1, 1))).must_equal "2023-01-01"
  end
end
```

## Code Style Guidelines

### Ruby/Middleman Conventions
- Use UTF-8 encoding (explicitly set in config.rb)
- Follow standard Ruby style guides
- ERB templates: `<%= %>` for output, `<% %>` for logic
- Use YAML front matter for content metadata
- File naming: `YYYY-MM-DD-title.html.md` for blog posts

### CSS/SCSS Guidelines
- **Mobile-first approach**: Start with mobile styles, use `@media` for larger screens
- **CSS Custom Properties**: Use for theming (light/dark mode support)
- **SCSS variables**: Define colors, breakpoints in `_variables.scss`
- **BEM-like naming**: `.component-name`, `.component-name__element`, `.component-name--modifier`
- **Bootstrap integration**: Extend Bootstrap classes, don't override
- **Responsive breakpoint**: `$mobile-breakpoint: 600px`

### JavaScript Guidelines
- **ES6+ features**: Use `const`, `let`, arrow functions
- **IIFE pattern**: Wrap modules in `(function() { ... })()`
- **Event delegation**: Use proper event handling for dynamic content
- **Async/defer**: Use appropriate script loading attributes
- **LocalStorage**: Use for theme persistence and user preferences
- **jQuery integration**: Use jQuery for DOM manipulation when appropriate

### Import & File Organization

#### Ruby/Middleman
```ruby
# config.rb - Main configuration
# source/layouts/ - ERB templates
# source/stylesheets/ - SCSS files
# source/javascripts/ - JS files
# data/ - YAML data files
```

#### SCSS Structure
```scss
// stylesheets/all.css.scss
@import "normalize";
@import "variables";  // Colors, breakpoints, etc.
@import "components"; // Component-specific styles
@import "theme";      // Dark/light theme variables
```

#### JavaScript Structure
```javascript
// javascripts/all.js - Main site scripts
// javascripts/theme_switcher.js - Theme functionality
// Use IIFE pattern for module encapsulation
```

### Naming Conventions

#### Files & Directories
- **Ruby files**: snake_case (e.g., `blog_helper.rb`)
- **SCSS files**: snake_case (e.g., `theme_switcher.scss`)
- **JS files**: snake_case (e.g., `theme_switcher.js`)
- **ERB templates**: snake_case (e.g., `base_layout.erb`)
- **Blog posts**: `YYYY-MM-DD-title.html.md`

#### CSS Classes
- **Components**: kebab-case (e.g., `.blog-post`, `.theme-switcher`)
- **Modifiers**: double hyphen (e.g., `.blog-post--featured`)
- **Elements**: double underscore (e.g., `.blog-post__title`)

#### JavaScript
- **Variables**: camelCase (e.g., `themePreference`, `mobileBreakpoint`)
- **Functions**: camelCase (e.g., `initializeTheme()`, `toggleDarkMode()`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `THEME_STORAGE_KEY`)

### Error Handling

#### Ruby/Middleman
- Use proper error handling in helpers and configuration
- Validate data from YAML files
- Handle missing assets gracefully

#### JavaScript
- Use try-catch blocks for localStorage operations
- Check for DOM element existence before manipulation
- Graceful degradation for missing features

### Theme System Guidelines

#### CSS Custom Properties
```css
:root {
  --bg-color: #ffffff;
  --text-color: #333333;
}

[data-theme='dark'] {
  --bg-color: #1a1a1a;
  --text-color: #ffffff;
}
```

#### JavaScript Theme Handling
```javascript
// Use localStorage for persistence
// Detect system preference with matchMedia
// Apply theme via data-theme attribute
// Handle theme switching with smooth transitions
```

### Content Guidelines

#### Blog Posts
- Use YAML front matter with `title`, `date`, `published` flag
- Write in Markdown with fenced code blocks
- Include proper meta descriptions
- Use semantic HTML structure

#### Static Pages
- Use appropriate layout templates
- Include proper meta tags
- Follow accessibility guidelines
- Ensure responsive design

### Performance Guidelines

#### Images
- Use appropriate file formats (WebP, AVIF when supported)
- Implement responsive images
- Optimize file sizes
- Use lazy loading when appropriate

#### CSS/JS
- Minify in production build
- Use async/defer for non-critical scripts
- Implement CSS critical path optimization
- Remove unused CSS/JS

### Security Guidelines

#### CSP Headers
- Use Content Security Policy headers in `_headers`
- Include hashes for inline scripts
- Whitelist external domains appropriately
- Regular security audits recommended

#### Dependencies
- Keep Ruby gems updated
- Use reputable CDN resources
- Review third-party scripts regularly
- Implement SRI for external resources

### Git Workflow

#### Branching
- `main`: Production branch
- Feature branches: `feature/description`
- Use descriptive commit messages

#### Pre-commit Hooks
- Trailing whitespace removal
- End-of-file fixer
- YAML validation
- Large file detection
- Line ending normalization (LF)

### Docker Development

#### Container Usage
- **Docker Compose is the recommended development environment**
- Ruby 3.4.4-slim base image with system dependencies
- Mount source directory for live reload
- Expose ports 4567 (Middleman) and 35729 (LiveReload)
- Volume `bundle_data` persists gems between container restarts

#### Docker Commands
```bash
# Start development server
docker-compose up

# Rebuild and start (after Gemfile changes)
docker-compose up --build

# Stop containers
docker-compose down

# Clean volumes (reset gem cache)
docker-compose down -v

# View logs
docker-compose logs -f

# Execute commands in container
docker-compose exec app bash
docker-compose exec app bundle exec middleman build
```

#### Container Configuration
- **Bind address**: `0.0.0.0` for external access
- **Working directory**: `/app`
- **Bundle path**: `/usr/local/bundle` (persisted via volume)
- **Environment**: Proper PATH and bundle configuration
- **System deps**: build-essential, libxml2-dev, libxslt1-dev, nodejs

#### Development Workflow
1. **Always use Docker Compose** for consistent environment
2. **Code changes** automatically reflected via volume mounting
3. **Bundle installation** handled automatically on container start
4. **Live reload** works on port 35729 for browser auto-refresh
5. **Access site** at http://localhost:4567

### Deployment

#### Production Build
```bash
bundle exec middleman build --clean
```
- Builds to `build/` directory
- Minifies CSS/JS
- Optimizes assets
- Ready for static hosting

#### Hosting
- Cloudflare Pages for static site hosting
- Automatic deployment on git push
- CDN integration for global performance
- SSL/TLS certificates automatically managed

### Accessibility Guidelines

#### HTML Structure
- Use semantic HTML5 elements
- Proper heading hierarchy
- Alt text for images
- ARIA labels where appropriate

#### Theme Support
- High contrast ratios in both themes
- Focus indicators for keyboard navigation
- Screen reader compatibility
- Respect user's motion preferences

### Documentation

#### Code Comments
- Comment complex logic
- Document helper functions
- Explain non-obvious implementations
- Keep comments up-to-date

#### README
- Update README with setup instructions
- Include deployment information
- Document custom configurations
- Provide troubleshooting guidance