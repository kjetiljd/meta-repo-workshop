# Jekyll Conversion Plan

## Current Problem
- Project has `.nojekyll` file that disables Jekyll
- Uses static HTML with custom CSS
- Has a backup Jekyll config (`_config.yml.backup`) but it's not active
- User prefers Jekyll over static HTML

## Conversion Strategy

### Phase 1: Restore Jekyll Configuration
1. Remove `.nojekyll` file
2. Restore `_config.yml` from backup
3. Convert `index.html` to `index.md` or `_layouts/default.html`
4. Set up proper Jekyll structure

### Phase 2: Preserve Content Structure
1. Convert workshop content to Jekyll-friendly format
2. Maintain existing slide functionality (Reveal.js)
3. Preserve Docker and development workflow
4. Keep all workshop exercises intact

### Phase 3: Enhance with Jekyll Features
1. Use Jekyll layouts for consistent styling
2. Add Jekyll includes for reusable components
3. Use Jekyll collections for workshop exercises
4. Implement Jekyll data files for configuration

### Phase 4: Testing and Deployment
1. Test locally with Jekyll serve
2. Verify GitHub Pages deployment
3. Ensure all links and functionality work
4. Validate responsive design

## Benefits of Jekyll Conversion
- Better maintainability with layouts and includes
- Markdown support for easier content editing
- Built-in GitHub Pages integration
- Template reusability across pages
- Better SEO with Jekyll plugins