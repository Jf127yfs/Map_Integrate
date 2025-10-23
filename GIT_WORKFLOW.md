# Git Workflow Guide

> **Comprehensive Git workflow for safe, documented development**

---

## 🌲 Branch Naming Strategy

### **Format:**

```
<type>/<description>-<session-id>
```

### **Types:**

| Type | When to Use | Example |
|------|-------------|---------|
| `feature/` | New functionality | `feature/guest-profile-page-ABC123` |
| `fix/` | Bug fixes | `fix/check-in-validation-ABC123` |
| `docs/` | Documentation only | `docs/api-documentation-ABC123` |
| `refactor/` | Code improvements | `refactor/simplify-wall-logic-ABC123` |
| `test/` | Test additions | `test/add-integration-tests-ABC123` |
| `chore/` | Maintenance tasks | `chore/update-dependencies-ABC123` |

### **Description Rules:**

- ✅ Use lowercase with hyphens
- ✅ Be descriptive but concise (3-5 words)
- ✅ Describe WHAT changes, not why
- ❌ Don't use generic names like "updates" or "changes"

### **Session ID:**

- Must end with session ID from task context
- Current session: `011CUQNMysrT2QthN4rzfrEQ`
- Format: `claude/<branch-name>-<session-id>`

---

## 📝 Commit Message Format

### **Structure:**

```
<type>: <short summary>

<detailed description>

<what changed>
<why it changed>
<how to test>

<footer>
```

### **Types:**

- `Add:` - New feature or file
- `Update:` - Modify existing functionality
- `Fix:` - Bug fix
- `Remove:` - Delete code or files
- `Refactor:` - Code restructuring
- `Docs:` - Documentation changes
- `Test:` - Test additions/changes
- `Chore:` - Maintenance tasks

### **Example:**

```
Add: Guest profile page with statistics

Implemented individual guest detail view accessible from Wall.
Shows guest demographics, interests, music preferences, and
compatibility scores with other guests.

Files Added:
- GuestProfile.html (new page)
- getGuestProfile() in Code.gs (backend function)
- testGuestProfile() in Tools.gs (test function)

Files Modified:
- Wall.html (added click handlers on guest cards)
- CONFIG object (added GUEST_PROFILE constants)

Testing:
- Run testGuestProfile() in Apps Script
- Open Wall, click any guest card
- Verify profile page loads with correct data

Risk Level: Low (isolated feature, no core modifications)

📦 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## 🔄 Workflow: Feature Development

### **Step 1: Create Feature Branch**

```bash
# Ensure on main/base branch
git checkout claude/create-readme-011CUQNMysrT2QthN4rzfrEQ

# Pull latest changes
git pull origin claude/create-readme-011CUQNMysrT2QthN4rzfrEQ

# Create new feature branch
git checkout -b feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ

# Verify branch created
git branch --show-current
```

### **Step 2: Develop with Incremental Commits**

```bash
# Work on feature
# Make small, focused changes

# Stage specific files
git add GuestProfile.html

# Commit with detailed message
git commit -m "Add: Guest profile HTML structure

Created basic HTML layout for guest profile page.
Includes:
- Header with guest UID and screen name
- Demographics section
- Interests section
- Music preferences section
- Placeholder for compatibility scores

Testing: Open GuestProfile.html in browser (static)

📦 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Continue development...
# Commit frequently (every 30-60 minutes)
```

### **Step 3: Push to Remote**

```bash
# Push branch to remote
git push -u origin feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ

# If push fails (network), retry with exponential backoff
# Wait 2s, retry
# Wait 4s, retry
# Wait 8s, retry
# Wait 16s, retry (max 4 retries)
```

### **Step 4: Create Pull Request**

```bash
# Use GitHub web interface or gh CLI
gh pr create \
  --base claude/create-readme-011CUQNMysrT2QthN4rzfrEQ \
  --head feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ \
  --title "Feature: Guest Profile Page" \
  --body "$(cat .github/pull_request_template.md)"

# Or get PR URL from git push output
```

---

## 📋 Pull Request Template

### **Create: `.github/pull_request_template.md`**

```markdown
## Feature/Fix Description

**What does this PR do?**
<!-- Brief description -->

**Why is this change needed?**
<!-- Business/user value -->

---

## Changes Made

### Files Added
- [ ] `filename.html` - Purpose
- [ ] `filename.gs` - Purpose

### Files Modified
- [ ] `Code.gs` - Lines XXX-YYY - What changed
- [ ] `Wall.html` - Lines XXX-YYY - What changed

### Files Deleted
- [ ] `filename.ext` - Why removed

---

## Risk Assessment

**Risk Level:** [🟢 Low / 🟡 Medium / 🔴 High]

**Why this risk level?**
<!-- Explanation -->

**Mitigation:**
- [ ] All existing tests pass
- [ ] New tests added
- [ ] Rollback plan documented

---

## Testing

### Tests Added
- [ ] `testNewFeature()` - What it tests

### Test Results
```
✅ testCheckInSystem() - PASS
✅ testWallData() - PASS
✅ testNewFeature() - PASS
```

### Manual Testing Completed
- [ ] Tested in Apps Script editor
- [ ] Tested in browser (Chrome)
- [ ] Tested in browser (Firefox)
- [ ] Tested on mobile
- [ ] No console errors
- [ ] No execution log errors

---

## Documentation

- [ ] README.md updated (if needed)
- [ ] CHANGELOG.md updated
- [ ] Code comments added
- [ ] FEATURE_TEMPLATE.md filled out

---

## Deployment Checklist

- [ ] All tests passing
- [ ] Code reviewed (self)
- [ ] No breaking changes
- [ ] Backward compatible
- [ ] Ready to deploy

---

## Screenshots (if applicable)

<!-- Add screenshots of UI changes -->

---

## Related Issues

Closes #XXX
Related to #YYY

---

## Reviewer Notes

**What to focus on:**
- Check test coverage
- Verify no core function modifications
- Ensure follows RULES.md

**How to test:**
1. Pull branch
2. Deploy to test environment
3. Run tests
4. Test manually in browser
```

---

## 📊 Branch Documentation File

### **Create: `BRANCH_SUMMARY.md` in each feature branch**

```markdown
# Branch: feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ

## Purpose

Add individual guest profile page accessible from Wall visualization.

---

## Commits

1. **Add: Guest profile HTML structure**
   - Date: 2025-10-23
   - Files: GuestProfile.html
   - Tests: Manual browser test

2. **Add: Backend function for profile data**
   - Date: 2025-10-23
   - Files: Code.gs
   - Tests: testGuestProfile()

3. **Update: Wall with click handlers**
   - Date: 2025-10-23
   - Files: Wall.html
   - Tests: Manual browser test

---

## Files Changed

### Added
- `GuestProfile.html` (250 lines) - Profile page UI
- `Code.gs:getGuestProfile()` (45 lines) - Backend function
- `Tools.gs:testGuestProfile()` (30 lines) - Test function

### Modified
- `Wall.html` (5 lines changed) - Added click handlers
- `CONFIG` (3 lines added) - Added profile constants

### Deleted
- None

---

## Testing Summary

### Automated Tests
- ✅ `testGuestProfile()` - PASS (profile data retrieval)
- ✅ `testCheckInSystem()` - PASS (regression)
- ✅ `testWallData()` - PASS (regression)

### Manual Tests
- ✅ Profile page loads correctly
- ✅ Guest data displays accurately
- ✅ Click from Wall navigates correctly
- ✅ No console errors
- ✅ Mobile responsive

---

## Deployment Status

- [ ] Merged to main branch
- [ ] Deployed to production
- [ ] Verified in production

---

## Rollback Plan

If issues occur:
1. Revert PR merge
2. Restore previous deployment version
3. Branch remains available for fixes

---

## Notes

- Risk Level: Low (isolated feature)
- Backward Compatible: Yes
- Breaking Changes: None
```

---

## 🚀 Deployment Workflow

### **Before Merge**

```bash
# 1. Ensure all tests pass
# Run in Apps Script editor:
runAllRegressionTests()

# 2. Update documentation
# Edit CHANGELOG.md
# Edit BRANCH_SUMMARY.md

# 3. Final commit
git add .
git commit -m "Docs: Update changelog and branch summary

Prepared for merge:
- Updated CHANGELOG.md with v1.1 changes
- Completed BRANCH_SUMMARY.md
- All tests passing

Ready for PR review and merge.

📦 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# 4. Push
git push
```

### **Create PR**

```bash
# Get PR creation URL from push output
# Or use GitHub web interface
# Fill out PR template completely
```

### **After Merge**

```bash
# 1. Switch to main branch
git checkout claude/create-readme-011CUQNMysrT2QthN4rzfrEQ

# 2. Pull merged changes
git pull origin claude/create-readme-011CUQNMysrT2QthN4rzfrEQ

# 3. Delete feature branch (optional)
git branch -d feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ
git push origin --delete feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ

# 4. Deploy to production
# In Apps Script: Deploy → Manage deployments → New version
```

---

## 📈 Branch Tracking

### **Keep a BRANCHES.md file:**

```markdown
# Active Branches

## In Development

### feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ
- **Status:** In Progress
- **Developer:** Your Name
- **Started:** 2025-10-23
- **Purpose:** Add guest profile page
- **Risk:** Low
- **Progress:** 60% complete

---

## Ready for Review

None currently

---

## Merged

### feature/enhanced-analytics-011CUQNMysrT2QthN4rzfrEQ
- **Merged:** 2025-10-22
- **PR:** #123
- **Deployed:** 2025-10-22

---

## Archived

### docs/planning-framework-011CUQNMysrT2QthN4rzfrEQ
- **Purpose:** Documentation and planning
- **Merged:** 2025-10-23
- **PR:** #122
```

---

## 🔍 Commit Inspection Commands

```bash
# View commit history
git log --oneline -20

# View specific commit details
git show <commit-hash>

# View files changed in commit
git show --name-only <commit-hash>

# View detailed diff
git show <commit-hash> --stat

# Search commit messages
git log --grep="search term"

# View commits by author
git log --author="Claude"
```

---

## 📋 Pre-Push Checklist

```
BEFORE EVERY PUSH:

[ ] All files staged: git add <files>
[ ] Commit message is detailed
[ ] Commit message follows format
[ ] Tests pass locally
[ ] No console errors
[ ] No debug code left in
[ ] CHANGELOG.md updated (if applicable)
[ ] Branch name follows convention
[ ] Session ID in branch name matches
```

---

## 🆘 Common Issues

### **Push Rejected (403 error)**

```bash
# Ensure branch name has correct session ID suffix
git branch --show-current
# Should end with: -011CUQNMysrT2QthN4rzfrEQ

# If wrong, rename branch:
git branch -m old-name new-name-011CUQNMysrT2QthN4rzfrEQ
git push -u origin new-name-011CUQNMysrT2QthN4rzfrEQ
```

### **Push Fails (Network)**

```bash
# Retry with exponential backoff
# Wait 2 seconds
git push
# If fails, wait 4 seconds
git push
# If fails, wait 8 seconds
git push
# If fails, wait 16 seconds (last try)
git push
```

### **Forgot to Create Branch**

```bash
# Create branch from current commit
git checkout -b feature/my-feature-011CUQNMysrT2QthN4rzfrEQ

# Push new branch
git push -u origin feature/my-feature-011CUQNMysrT2QthN4rzfrEQ
```

---

## 🎯 Best Practices

### **Commit Frequency:**
- ✅ Commit every 30-60 minutes
- ✅ Commit after completing a sub-task
- ✅ Commit before risky changes
- ❌ Don't wait until end of day

### **Branch Lifecycle:**
- ✅ One branch per feature
- ✅ Keep branches short-lived (1-3 days)
- ✅ Merge frequently
- ❌ Don't have multiple features in one branch

### **Commit Size:**
- ✅ Small, focused commits (50-100 lines)
- ✅ One logical change per commit
- ✅ Tests included with feature code
- ❌ Don't bundle unrelated changes

---

## 📚 Examples

### **Good Branch Names:**
```
✅ feature/export-guest-csv-011CUQNMysrT2QthN4rzfrEQ
✅ fix/birthday-format-validation-011CUQNMysrT2QthN4rzfrEQ
✅ docs/api-reference-guide-011CUQNMysrT2QthN4rzfrEQ
✅ test/wall-integration-tests-011CUQNMysrT2QthN4rzfrEQ
```

### **Bad Branch Names:**
```
❌ updates-011CUQNMysrT2QthN4rzfrEQ (not descriptive)
❌ feature/various-changes (no session ID)
❌ fix-stuff-011CUQNMysrT2QthN4rzfrEQ (too vague)
❌ FEATURE/GUEST-PROFILE (wrong case)
```

### **Good Commit Messages:**
```
✅ Add: CSV export for guest list

Created downloadable CSV with all guest data.
Includes demographics, interests, and check-in times.

Files: ExportCSV.gs, exportGuestCSV()
Tests: testCSVExport()
```

### **Bad Commit Messages:**
```
❌ updated files
❌ fixes
❌ WIP
❌ changes to code
```

---

**Remember: Detailed commits = Clear history = Easy rollbacks = Safe development** 🛡️
