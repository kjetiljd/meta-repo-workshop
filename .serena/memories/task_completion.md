# Task Completion Checklist

## After Making Changes

### 1. Local Testing
- [ ] Test with Jekyll: `bundle exec jekyll serve`
- [ ] Verify all pages load correctly
- [ ] Check responsive design on mobile
- [ ] Test all navigation links
- [ ] Validate workshop exercises work

### 2. Code Quality
- [ ] Check HTML validation
- [ ] Verify CSS consistency
- [ ] Test JavaScript functionality (slides)
- [ ] Ensure markdown renders correctly

### 3. Content Verification
- [ ] All workshop links work
- [ ] Slides presentation functions correctly
- [ ] Speaker notes accessible with 'S' key
- [ ] Resource downloads work

### 4. Git Operations
- [ ] Stage changes: `git add .`
- [ ] Commit with descriptive message
- [ ] Push to main branch: `git push origin main`

### 5. Deployment Testing
- [ ] GitHub Pages builds successfully
- [ ] Live site works: https://username.github.io/repo-name/
- [ ] All assets load (CSS, JS, images)
- [ ] Mobile responsiveness confirmed

### 6. Documentation
- [ ] Update README.md if needed
- [ ] Update DEVELOP.md for instructors
- [ ] Check TODO.md for pending items

## Emergency Rollback
If something breaks:
```bash
git revert HEAD             # Revert last commit
git push origin main        # Deploy rollback
```

## Performance Check
- [ ] Page load times acceptable
- [ ] Images optimized
- [ ] CSS/JS minified if needed