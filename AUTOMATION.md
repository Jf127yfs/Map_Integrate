# Git Automation System

> **Automated branch creation, documentation, and push workflow**

---

## 🎯 Overview

The `git_helper.sh` script **automatically**:
1. ✅ Creates branches with proper naming
2. ✅ Generates BRANCH_SUMMARY.md
3. ✅ Updates documentation on each commit
4. ✅ Updates CHANGELOG.md
5. ✅ Verifies everything before push
6. ✅ Handles network retries

**No more manual documentation!**

---

## 🚀 Quick Start

### **1. Create New Feature Branch**

```bash
./git_helper.sh branch
```

**What it does:**
- Prompts for branch type (feature/fix/docs/etc.)
- Prompts for description
- Creates branch: `type/description-sessionID`
- Auto-generates BRANCH_SUMMARY.md
- Makes initial commit

**Example:**
```
$ ./git_helper.sh branch
=== Create New Feature Branch ===

Select branch type:
  1) feature  - New functionality
  2) fix      - Bug fixes
  3) docs     - Documentation
  4) refactor - Code improvements
  5) test     - Test additions
  6) chore    - Maintenance
Enter number (1-6): 1

Enter description (lowercase-with-dashes): guest-profile-page

✅ Creating branch: feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ
✅ BRANCH_SUMMARY.md created
✅ Branch created successfully!
```

---

### **2. Make Your Changes**

```bash
# Edit files normally
vim Code.gs
vim GuestProfile.html
```

---

### **3. Commit with Auto-Documentation**

```bash
./git_helper.sh commit
```

**What it does:**
- Shows files changed
- Prompts for commit type (Add/Update/Fix/etc.)
- Prompts for summary and description
- Auto-formats commit message
- **Auto-updates BRANCH_SUMMARY.md** with statistics
- Commits everything

**Example:**
```
$ ./git_helper.sh commit
=== Smart Commit ===

Files changed:
M  Code.gs
A  GuestProfile.html

Select commit type:
  1) Add      - New feature or file
  2) Update   - Modify existing
  3) Fix      - Bug fix
  4) Refactor - Code restructuring
  5) Docs     - Documentation
  6) Test     - Tests
Enter number (1-6): 1

Short summary (50 chars): Guest profile page with backend function

Detailed description (press Ctrl+D when done):
Created individual guest profile page accessible from Wall.
Includes demographics, interests, and music preferences.
^D

Commit message preview:
---
Add: Guest profile page with backend function

Created individual guest profile page accessible from Wall.
Includes demographics, interests, and music preferences.

Files Changed:
Code.gs
GuestProfile.html

Testing: Manual verification required

📦 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
---

Commit with this message? (y/n): y

✅ Committed successfully!
✅ BRANCH_SUMMARY.md updated
```

---

### **4. Push with Verification**

```bash
./git_helper.sh push
```

**What it does:**
- Verifies session ID in branch name
- Checks for uncommitted changes
- Verifies BRANCH_SUMMARY.md exists
- Prompts to update CHANGELOG.md (optional)
- Pushes with exponential backoff retry (2s, 4s, 8s, 16s)
- Shows next steps (create PR)

**Example:**
```
$ ./git_helper.sh push
=== Smart Push ===

Running pre-push checks...

✅ No uncommitted changes
✅ BRANCH_SUMMARY.md exists
✅ CHANGELOG.md exists

Pushing to remote...

✅ Push successful!

Next steps:
  1. Create PR on GitHub
  2. Use PR template: .github/pull_request_template.md
  3. Request review
```

---

## 📋 Commands Reference

### **branch** - Create New Branch

```bash
./git_helper.sh branch
```

**Prompts:**
1. Branch type (feature/fix/docs/refactor/test/chore)
2. Description (lowercase-with-dashes)

**Creates:**
- New branch: `type/description-sessionID`
- BRANCH_SUMMARY.md with template
- Initial commit

---

### **commit** - Smart Commit

```bash
./git_helper.sh commit
```

**Prompts:**
1. Commit type (Add/Update/Fix/Refactor/Docs/Test)
2. Short summary (50 chars)
3. Detailed description (multi-line)

**Does:**
- Stages all changes
- Creates detailed commit message
- Updates BRANCH_SUMMARY.md statistics
- Commits with proper format

---

### **push** - Verified Push

```bash
./git_helper.sh push
```

**Checks:**
1. Session ID in branch name
2. No uncommitted changes
3. BRANCH_SUMMARY.md exists
4. CHANGELOG.md exists (optional)

**Does:**
- Pushes with retry logic (exponential backoff)
- Max 4 retries on network failure
- Shows next steps

---

### **changelog** - Update Changelog

```bash
./git_helper.sh changelog
```

**Prompts:**
1. Version number (e.g., 1.1.0)
2. Brief description

**Does:**
- Gets recent commits
- Generates changelog entry
- Prepends to CHANGELOG.md
- Stages for commit

---

### **help** - Show Help

```bash
./git_helper.sh help
```

Shows command reference and example workflow.

---

## 🔄 Complete Workflow Example

### **Scenario: Add Guest Profile Page**

```bash
# Step 1: Create branch (auto-generates BRANCH_SUMMARY.md)
$ ./git_helper.sh branch
[Select: 1) feature]
[Enter: guest-profile-page]
✅ Branch created: feature/guest-profile-page-011CUQNMysrT2QthN4rzfrEQ
✅ BRANCH_SUMMARY.md created

# Step 2: Make changes
$ vim GuestProfile.html
$ vim Code.gs

# Step 3: Commit (auto-updates BRANCH_SUMMARY.md)
$ ./git_helper.sh commit
[Select: 1) Add]
[Enter: Guest profile HTML structure]
[Enter: Created basic layout with sections...]
✅ Committed successfully!
✅ BRANCH_SUMMARY.md updated (stats: 1 commit, 2 files, 120 lines)

# Step 4: More changes
$ vim Code.gs
$ vim Tools.gs

# Step 5: Commit again (stats auto-update)
$ ./git_helper.sh commit
[Select: 1) Add]
[Enter: Backend function for profile data]
[Enter: Implemented getGuestProfile()...]
✅ Committed successfully!
✅ BRANCH_SUMMARY.md updated (stats: 2 commits, 4 files, 215 lines)

# Step 6: Update changelog
$ ./git_helper.sh changelog
[Enter: 1.1.0]
[Enter: Guest profile page feature]
✅ CHANGELOG.md updated

# Step 7: Final commit for changelog
$ ./git_helper.sh commit
[Select: 5) Docs]
[Enter: Update changelog for v1.1.0]
[Enter: Added version 1.1.0 with guest profile feature]
✅ Committed successfully!

# Step 8: Push (verifies everything)
$ ./git_helper.sh push
✅ No uncommitted changes
✅ BRANCH_SUMMARY.md exists
✅ CHANGELOG.md exists
✅ Push successful!

Next steps:
  1. Create PR on GitHub
  2. Use PR template
  3. Request review
```

**Result:**
- ✅ Branch properly named with session ID
- ✅ BRANCH_SUMMARY.md auto-generated and updated
- ✅ CHANGELOG.md updated with version
- ✅ 3 detailed commits with proper formatting
- ✅ All documentation current
- ✅ Ready for PR

---

## 📊 Auto-Generated Documentation

### **BRANCH_SUMMARY.md**

**Auto-created on branch creation**

Includes:
- Branch name and purpose
- Commit history section (manually updated)
- Files changed tracking
- Testing checklist
- Risk assessment template
- Statistics (auto-updated on commit)

**Auto-updated on each commit:**
- Commit count
- Files changed count
- Lines added count
- Last updated timestamp

---

### **CHANGELOG.md**

**Auto-updated with `./git_helper.sh changelog`**

Generates:
- Version number and date
- Description
- Recent commit messages
- Formatted changelog entry

---

## 🛡️ Safety Features

### **Session ID Validation**

```bash
# Ensures branch ends with session ID
if [[ ! "$branch" =~ -011CUQNMysrT2QthN4rzfrEQ$ ]]; then
    echo "Error: Branch must end with session ID"
    exit 1
fi
```

**Prevents 403 errors on push**

---

### **Pre-Push Checks**

```bash
# Check 1: No uncommitted changes
if ! git diff --quiet; then
    echo "❌ You have uncommitted changes"
    exit 1
fi

# Check 2: BRANCH_SUMMARY.md exists
if [ ! -f BRANCH_SUMMARY.md ]; then
    echo "❌ BRANCH_SUMMARY.md not found"
    exit 1
fi

# Check 3: CHANGELOG.md exists (optional)
if [ ! -f CHANGELOG.md ]; then
    # Prompt to create
fi
```

---

### **Network Retry Logic**

```bash
# Exponential backoff: 2s, 4s, 8s, 16s
max_retries=4
retry_count=0
wait_time=2

while [ $retry_count -lt $max_retries ]; do
    if git push -u origin "$branch"; then
        return 0
    else
        retry_count=$((retry_count + 1))
        if [ $retry_count -lt $max_retries ]; then
            echo "Retrying in ${wait_time}s..."
            sleep $wait_time
            wait_time=$((wait_time * 2))
        fi
    fi
done
```

---

## 🎯 Benefits

### **Before Automation:**

```bash
# Manual process (error-prone)
git checkout -b feature-something  # ❌ No session ID
# (forgot to create BRANCH_SUMMARY.md)
git add .
git commit -m "changes"  # ❌ Not detailed
# (forgot to update CHANGELOG.md)
git push  # ❌ Might fail, no retry
```

**Problems:**
- ❌ Missing session ID → 403 error
- ❌ No BRANCH_SUMMARY.md → Poor documentation
- ❌ Generic commit messages → Lost context
- ❌ Forgot CHANGELOG.md → No version tracking
- ❌ Network failures → Manual retries

---

### **After Automation:**

```bash
# Automated process (foolproof)
./git_helper.sh branch    # ✅ Correct naming + BRANCH_SUMMARY.md
# (make changes)
./git_helper.sh commit    # ✅ Detailed message + auto-updates
./git_helper.sh changelog # ✅ Version tracking
./git_helper.sh push      # ✅ Verified + retries
```

**Benefits:**
- ✅ Always correct session ID
- ✅ Always has BRANCH_SUMMARY.md
- ✅ Always detailed commit messages
- ✅ Always updates statistics
- ✅ Always handles network failures
- ✅ Always shows next steps

---

## 📝 Customization

### **Change Session ID**

Edit `git_helper.sh` line 17:

```bash
SESSION_ID="your-new-session-id"
```

### **Change Retry Settings**

Edit `git_helper.sh` smart_push() function:

```bash
local max_retries=4    # Change retry count
local wait_time=2      # Change initial wait time
```

### **Change Commit Message Format**

Edit `git_helper.sh` smart_commit() function:

```bash
commit_msg="${commit_type}: ${summary}

${description}

Files Changed:
${files_changed}

Testing: Manual verification required

📦 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## 🐛 Troubleshooting

### **"Permission denied" Error**

```bash
# Make script executable
chmod +x git_helper.sh
```

### **"Session ID mismatch" Error**

```bash
# Update SESSION_ID in git_helper.sh
SESSION_ID="your-correct-session-id"
```

### **Script not found**

```bash
# Run from repository root
cd /path/to/Map_Integrate
./git_helper.sh branch
```

### **Ctrl+D not working for description**

```bash
# Alternative: Use echo
echo "My description" | ./git_helper.sh commit

# Or edit script to use read -p instead
```

---

## 🎓 Best Practices

### **Branch Creation**

```bash
# Always use script for branches
./git_helper.sh branch

# NOT manual:
git checkout -b mybranch  # ❌ Will fail on push
```

### **Committing**

```bash
# Use script for detailed commits
./git_helper.sh commit

# Manual commits are OK for tiny fixes:
git commit -m "Fix: typo in comment"  # ✅ Still follows format
```

### **Pushing**

```bash
# Always use script for first push
./git_helper.sh push

# Subsequent pushes can be manual:
git push  # ✅ Already configured with -u
```

---

## 📋 Integration with Existing Workflow

### **Works with RULES.md**

- ✅ Enforces Rule #3: One feature per branch
- ✅ Enforces Rule #14: Detailed commit messages
- ✅ Enforces Rule #15: Commit when tests pass
- ✅ Checks Rule #16: Session ID validation

### **Works with TESTING_FRAMEWORK.md**

```bash
# After running tests
runAllRegressionTests()  # In Apps Script

# Then commit
./git_helper.sh commit
[Enter: Test results passed]
```

### **Works with FEATURE_TEMPLATE.md**

```bash
# Fill out feature template first
cp FEATURE_TEMPLATE.md features/FEAT-001-my-feature.md

# Then create branch
./git_helper.sh branch
[Enter: same description as FEAT-001]
```

---

## 🚀 Advanced Usage

### **Batch Operations**

```bash
# Create branch and commit in one session
./git_helper.sh branch
# (make changes)
./git_helper.sh commit && ./git_helper.sh push
```

### **Scripted Workflow**

```bash
#!/bin/bash
# Auto-workflow for small docs changes

./git_helper.sh branch <<EOF
3
update-readme-typos
EOF

vim README.md

./git_helper.sh commit <<EOF
2
Fix typos in README
Corrected spelling and grammar errors
EOF

./git_helper.sh push
```

---

## 📊 Statistics Tracking

### **Auto-Updated in BRANCH_SUMMARY.md**

```markdown
**Progress:**
- Commits: 3        # ← Auto-updated
- Files Changed: 5  # ← Auto-updated
- Tests Added: 2    # ← Manual
- Lines Added: 342  # ← Auto-updated
```

**How it works:**
```bash
# On each commit, script runs:
commit_count=$(git rev-list --count HEAD)
files_changed=$(git diff --name-only HEAD~1 HEAD | wc -l)
lines_added=$(git diff --shortstat HEAD~1 HEAD | grep -oP '\d+(?= insertion)')

# Then updates BRANCH_SUMMARY.md
sed -i "s/Commits: [0-9]*/Commits: ${commit_count}/" BRANCH_SUMMARY.md
```

---

## ✅ Summary

**The automation system ensures:**

1. ✅ **Every branch** has correct session ID
2. ✅ **Every branch** has BRANCH_SUMMARY.md
3. ✅ **Every commit** is detailed and formatted
4. ✅ **Every commit** updates documentation
5. ✅ **Every push** is verified and retried
6. ✅ **Every push** shows next steps

**Result:** Professional, well-documented Git history with zero manual effort!

---

**Quick Reference:**

```bash
./git_helper.sh branch     # Create branch + BRANCH_SUMMARY.md
./git_helper.sh commit     # Detailed commit + auto-update stats
./git_helper.sh changelog  # Update CHANGELOG.md
./git_helper.sh push       # Verify + retry + next steps
./git_helper.sh help       # Show this reference
```

---

🤖 *Automation makes perfect development inevitable!*
