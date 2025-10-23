#!/bin/bash

##############################################################################
# Git Automation Helper
# Automates branch creation, documentation, and push process
##############################################################################

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Session ID (must match Claude Code session)
SESSION_ID="011CUQNMysrT2QthN4rzfrEQ"

##############################################################################
# Function: Create New Feature Branch
##############################################################################
create_branch() {
    echo -e "${BLUE}=== Create New Feature Branch ===${NC}\n"

    # Get branch type
    echo "Select branch type:"
    echo "  1) feature  - New functionality"
    echo "  2) fix      - Bug fixes"
    echo "  3) docs     - Documentation"
    echo "  4) refactor - Code improvements"
    echo "  5) test     - Test additions"
    echo "  6) chore    - Maintenance"
    read -p "Enter number (1-6): " type_num

    case $type_num in
        1) branch_type="feature";;
        2) branch_type="fix";;
        3) branch_type="docs";;
        4) branch_type="refactor";;
        5) branch_type="test";;
        6) branch_type="chore";;
        *) echo -e "${RED}Invalid selection${NC}"; exit 1;;
    esac

    # Get description
    read -p "Enter description (lowercase-with-dashes): " description

    # Validate description
    if [[ ! "$description" =~ ^[a-z0-9-]+$ ]]; then
        echo -e "${RED}Error: Description must be lowercase with dashes only${NC}"
        exit 1
    fi

    # Build branch name
    branch_name="${branch_type}/${description}-${SESSION_ID}"

    echo -e "\n${GREEN}Creating branch: ${branch_name}${NC}\n"

    # Create branch
    git checkout -b "$branch_name"

    # Create BRANCH_SUMMARY.md
    create_branch_summary "$branch_name" "$branch_type" "$description"

    echo -e "\n${GREEN}✅ Branch created successfully!${NC}"
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Make your changes"
    echo "  2. Run: ./git_helper.sh commit"
    echo "  3. Run: ./git_helper.sh push"
}

##############################################################################
# Function: Create BRANCH_SUMMARY.md
##############################################################################
create_branch_summary() {
    local branch_name=$1
    local branch_type=$2
    local description=$3

    cat > BRANCH_SUMMARY.md << EOF
# Branch: ${branch_name}

## 📋 Purpose

<!-- Describe what this branch does -->
${description}

---

## 📊 Commits Summary

<!-- Will be auto-updated on each commit -->

### Commit 1: Initial commit
- **Hash:** (pending)
- **Date:** $(date +%Y-%m-%d)
- **Files:** BRANCH_SUMMARY.md
- **What:** Branch created and documented

---

## 📁 Files Changed

### Added (New Files)
<!-- List will be updated automatically -->
- [ ] BRANCH_SUMMARY.md - Branch documentation

### Modified
<!-- List will be updated automatically -->
- [ ] (none yet)

### Deleted
<!-- List will be updated automatically -->
- [ ] (none yet)

---

## 🧪 Testing Summary

### Tests Run

**Regression Tests:**
- [ ] testCheckInSystem() - Not run yet
- [ ] testWallData() - Not run yet

**New Tests:**
- [ ] (add your tests here)

### Manual Testing
- [ ] Browser testing
- [ ] No console errors
- [ ] Feature works as expected

---

## 🎯 Feature Highlights

<!-- Describe main features/changes -->

1.
2.
3.

---

## 🔒 Safety Measures

**Risk Level:** [🟢 Low / 🟡 Medium / 🔴 High]

**Why this risk level:**
<!-- Explain -->

**Mitigation:**
- [ ] Tests written first
- [ ] No core function modifications
- [ ] Follows RULES.md

---

## 📋 Deployment Checklist

### Pre-Merge
- [ ] All tests passing
- [ ] CHANGELOG.md updated
- [ ] Documentation complete
- [ ] Code reviewed

### Ready for Merge
- [ ] PR created
- [ ] PR approved
- [ ] Ready to deploy

---

## 📈 Statistics

**Branch Type:** ${branch_type}
**Created:** $(date +%Y-%m-%d)
**Session ID:** ${SESSION_ID}

**Progress:**
- Commits: 0
- Files Changed: 0
- Tests Added: 0
- Lines Added: 0

---

**Branch Status:** 🔨 **IN DEVELOPMENT**

---

*Last Updated: $(date +"%Y-%m-%d %H:%M:%S")*
EOF

    git add BRANCH_SUMMARY.md
    git commit -m "Docs: Initialize branch with BRANCH_SUMMARY.md

Branch: ${branch_name}
Type: ${branch_type}
Purpose: ${description}

📦 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

    echo -e "${GREEN}✅ BRANCH_SUMMARY.md created${NC}"
}

##############################################################################
# Function: Smart Commit
##############################################################################
smart_commit() {
    echo -e "${BLUE}=== Smart Commit ===${NC}\n"

    # Check if there are changes
    if git diff --quiet && git diff --cached --quiet; then
        echo -e "${YELLOW}No changes to commit${NC}"
        exit 0
    fi

    # Show what changed
    echo -e "${BLUE}Files changed:${NC}"
    git status --short
    echo ""

    # Get commit type
    echo "Select commit type:"
    echo "  1) Add      - New feature or file"
    echo "  2) Update   - Modify existing"
    echo "  3) Fix      - Bug fix"
    echo "  4) Refactor - Code restructuring"
    echo "  5) Docs     - Documentation"
    echo "  6) Test     - Tests"
    read -p "Enter number (1-6): " commit_type_num

    case $commit_type_num in
        1) commit_type="Add";;
        2) commit_type="Update";;
        3) commit_type="Fix";;
        4) commit_type="Refactor";;
        5) commit_type="Docs";;
        6) commit_type="Test";;
        *) echo -e "${RED}Invalid selection${NC}"; exit 1;;
    esac

    # Get short summary
    read -p "Short summary (50 chars): " summary

    # Get detailed description
    echo "Detailed description (press Ctrl+D when done):"
    description=$(cat)

    # Get files changed
    files_changed=$(git diff --name-only --cached)
    if [ -z "$files_changed" ]; then
        files_changed=$(git diff --name-only)
        git add -A
    fi

    # Build commit message
    commit_msg="${commit_type}: ${summary}

${description}

Files Changed:
${files_changed}

Testing: Manual verification required

📦 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

    # Show preview
    echo -e "\n${BLUE}Commit message preview:${NC}"
    echo "---"
    echo "$commit_msg"
    echo "---"

    read -p "Commit with this message? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        echo -e "${YELLOW}Commit cancelled${NC}"
        exit 0
    fi

    # Commit
    git commit -m "$commit_msg"

    # Update BRANCH_SUMMARY.md
    update_branch_summary

    echo -e "\n${GREEN}✅ Committed successfully!${NC}"
}

##############################################################################
# Function: Update BRANCH_SUMMARY.md
##############################################################################
update_branch_summary() {
    if [ ! -f BRANCH_SUMMARY.md ]; then
        echo -e "${YELLOW}Warning: BRANCH_SUMMARY.md not found${NC}"
        return
    fi

    # Get stats
    local commit_count=$(git rev-list --count HEAD)
    local files_changed=$(git diff --name-only HEAD~1 HEAD 2>/dev/null | wc -l)
    local lines_added=$(git diff --shortstat HEAD~1 HEAD 2>/dev/null | grep -oP '\d+(?= insertion)' || echo "0")

    # Update statistics section
    sed -i "s/Commits: [0-9]*/Commits: ${commit_count}/" BRANCH_SUMMARY.md
    sed -i "s/Files Changed: [0-9]*/Files Changed: ${files_changed}/" BRANCH_SUMMARY.md
    sed -i "s/Lines Added: [0-9]*/Lines Added: ${lines_added}/" BRANCH_SUMMARY.md
    sed -i "s/Last Updated:.*/Last Updated: $(date +"%Y-%m-%d %H:%M:%S")/" BRANCH_SUMMARY.md

    git add BRANCH_SUMMARY.md
    git commit --amend --no-edit

    echo -e "${GREEN}✅ BRANCH_SUMMARY.md updated${NC}"
}

##############################################################################
# Function: Update CHANGELOG.md
##############################################################################
update_changelog() {
    echo -e "${BLUE}=== Update CHANGELOG.md ===${NC}\n"

    read -p "Enter version (e.g., 1.1.0): " version
    read -p "Brief description: " description

    # Get current date
    local date=$(date +%Y-%m-%d)

    # Create changelog entry
    local entry="## [${version}] - ${date}

### ${description}

"

    # Get commit messages since last version
    local commits=$(git log --oneline --pretty=format:"- %s" HEAD~5..HEAD)

    entry+="### Changes
${commits}

---

"

    # Prepend to CHANGELOG.md (after first line)
    if [ -f CHANGELOG.md ]; then
        # Insert after "# Changelog" line
        sed -i "/# Changelog/a\\
\\
${entry}" CHANGELOG.md
    else
        # Create new CHANGELOG.md
        echo "# Changelog

${entry}" > CHANGELOG.md
    fi

    git add CHANGELOG.md

    echo -e "${GREEN}✅ CHANGELOG.md updated${NC}"
}

##############################################################################
# Function: Smart Push
##############################################################################
smart_push() {
    echo -e "${BLUE}=== Smart Push ===${NC}\n"

    # Get current branch
    local branch=$(git branch --show-current)

    # Verify session ID
    if [[ ! "$branch" =~ -${SESSION_ID}$ ]]; then
        echo -e "${RED}Error: Branch name must end with session ID: ${SESSION_ID}${NC}"
        echo -e "${YELLOW}Current branch: ${branch}${NC}"
        exit 1
    fi

    # Run checks
    echo -e "${BLUE}Running pre-push checks...${NC}\n"

    # Check 1: Uncommitted changes
    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo -e "${RED}❌ You have uncommitted changes${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ No uncommitted changes${NC}"

    # Check 2: BRANCH_SUMMARY.md exists
    if [ ! -f BRANCH_SUMMARY.md ]; then
        echo -e "${RED}❌ BRANCH_SUMMARY.md not found${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ BRANCH_SUMMARY.md exists${NC}"

    # Check 3: CHANGELOG.md updated (optional prompt)
    if [ -f CHANGELOG.md ]; then
        echo -e "${GREEN}✅ CHANGELOG.md exists${NC}"
    else
        read -p "${YELLOW}CHANGELOG.md not found. Create it? (y/n): ${NC}" create_changelog
        if [[ "$create_changelog" == "y" ]]; then
            update_changelog
        fi
    fi

    echo -e "\n${BLUE}Pushing to remote...${NC}\n"

    # Push with retry logic (exponential backoff)
    local max_retries=4
    local retry_count=0
    local wait_time=2

    while [ $retry_count -lt $max_retries ]; do
        if git push -u origin "$branch"; then
            echo -e "\n${GREEN}✅ Push successful!${NC}"

            # Show next steps
            echo -e "\n${YELLOW}Next steps:${NC}"
            echo "  1. Create PR on GitHub"
            echo "  2. Use PR template: .github/pull_request_template.md"
            echo "  3. Request review"

            return 0
        else
            retry_count=$((retry_count + 1))
            if [ $retry_count -lt $max_retries ]; then
                echo -e "${YELLOW}Push failed. Retrying in ${wait_time}s... (attempt ${retry_count}/${max_retries})${NC}"
                sleep $wait_time
                wait_time=$((wait_time * 2))
            else
                echo -e "${RED}❌ Push failed after ${max_retries} attempts${NC}"
                exit 1
            fi
        fi
    done
}

##############################################################################
# Function: Show Help
##############################################################################
show_help() {
    echo -e "${BLUE}=== Git Automation Helper ===${NC}\n"
    echo "Usage: ./git_helper.sh <command>"
    echo ""
    echo "Commands:"
    echo "  branch   - Create new feature branch with documentation"
    echo "  commit   - Smart commit with detailed message"
    echo "  push     - Push with verification and retry logic"
    echo "  changelog- Update CHANGELOG.md"
    echo "  help     - Show this help message"
    echo ""
    echo "Example workflow:"
    echo "  1. ./git_helper.sh branch"
    echo "  2. (make your changes)"
    echo "  3. ./git_helper.sh commit"
    echo "  4. ./git_helper.sh push"
}

##############################################################################
# Main Script
##############################################################################

case "${1:-help}" in
    branch)
        create_branch
        ;;
    commit)
        smart_commit
        ;;
    push)
        smart_push
        ;;
    changelog)
        update_changelog
        ;;
    help|*)
        show_help
        ;;
esac
