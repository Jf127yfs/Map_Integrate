# Development Rules

> **Strict guidelines to protect working code while building new features**

---

## 🚨 CRITICAL RULES (NEVER BREAK THESE)

### **Rule #1: NEVER Modify Working Code Directly**
```
❌ BAD:  Edit checkInGuest() function
✅ GOOD: Create checkInGuestV2() and test it separately
```

### **Rule #2: ALWAYS Test Before Committing**
```
Every commit must pass:
- Existing test functions (testCheckInSystem, testWallData)
- New test function for your feature
- Manual browser test (for HTML changes)
```

### **Rule #3: One Feature Per Branch**
```
❌ BAD:  feature/multiple-things
✅ GOOD: feature/guest-profile-page
         feature/export-csv
         feature/compatibility-score
```

### **Rule #4: NEVER Change Column Indices**
```
❌ FORBIDDEN: Modify CONFIG.COL values
✅ ALLOWED:   Add NEW columns at the end (AA, AB, AC...)
```

### **Rule #5: Git Commit Before Major Changes**
```
Before any risky change:
1. git add .
2. git commit -m "CHECKPOINT: Before [change description]"
3. Make changes
4. If it breaks: git reset --hard HEAD
```

---

## 📐 ARCHITECTURE RULES

### **Rule #6: Separation of Concerns**

**Backend (Code.gs, WallData.gs)**
- Only handles data logic
- Returns JSON objects
- No HTML generation in main functions

**Frontend (HTML files)**
- Only handles display logic
- Calls backend via google.script.run
- No direct sheet access

### **Rule #7: Function Naming Convention**

```javascript
// User-facing functions (called from HTML)
function checkInGuest()        // camelCase, no prefix
function updateGuestScreenName()

// Internal helper functions
function _buildConnections()   // prefix with underscore
function _validateInput()

// Test functions
function testCheckIn()         // prefix with "test"
function testWallData()

// New feature functions
function getGuestProfileV2()   // suffix with version if replacing
```

### **Rule #8: Configuration First**

All magic numbers and IDs go in CONFIG:
```javascript
❌ BAD:  const folderId = '1ZcP5jpYsYy0xuGqlFYNrDgG4K40eEKJB'
✅ GOOD: const folderId = CONFIG.PHOTO_FOLDER_ID
```

---

## 🧪 TESTING RULES

### **Rule #9: Test-First Development**

Required order:
```
1. Write test function
2. Run test (it should fail)
3. Write feature code
4. Run test (it should pass)
5. Commit
```

### **Rule #10: Test Function Requirements**

Every new function must have:
```javascript
function myNewFeature() {
  // Feature code
}

function testMyNewFeature() {
  try {
    const result = myNewFeature();

    // Verify result
    if (!result) throw new Error('No result returned');
    if (!result.ok) throw new Error('Function failed: ' + result.message);

    Logger.log('✅ testMyNewFeature PASSED');
    return {passed: true};

  } catch (error) {
    Logger.log('❌ testMyNewFeature FAILED: ' + error.message);
    return {passed: false, error: error.message};
  }
}
```

### **Rule #11: Regression Testing**

Before ANY deployment:
```javascript
function runAllTests() {
  const results = [];

  results.push(testCheckInSystem());
  results.push(testWallData());
  results.push(testMyNewFeature());
  // Add all test functions here

  const failed = results.filter(r => !r.passed);
  if (failed.length > 0) {
    throw new Error('TESTS FAILED - DO NOT DEPLOY');
  }

  Logger.log('✅ ALL TESTS PASSED');
}
```

---

## 📁 FILE MODIFICATION RULES

### **Rule #12: File Safety Levels**

**🟢 GREEN (Safe to Edit Anytime)**
- Documentation files (README.md, CHANGELOG.md, RULES.md)
- New test files
- New HTML pages (not modifying existing)

**🟡 YELLOW (Edit with Caution)**
- Adding NEW functions to Code.gs
- Adding NEW functions to WallData.gs
- Modifying Tools.gs (test functions only)
- CSS changes in existing HTML

**🔴 RED (Requires Backup & Testing)**
- Modifying existing functions in Code.gs
- Changing CONFIG object
- Editing CheckInInterface.html (active form)
- Column structure changes

**⛔ FORBIDDEN (Do Not Touch)**
- CONFIG.COL values (column indices)
- checkInGuest() core logic (can extend, not replace)
- getFRCSheet() function
- Sheet name 'FRC' (without migration plan)

---

## 🔄 GIT WORKFLOW RULES

### **Rule #13: Branch Naming**

```bash
feature/descriptive-name      # New features
fix/bug-description          # Bug fixes
refactor/what-you-refactored # Code cleanup
docs/what-you-documented     # Documentation only
```

### **Rule #14: Commit Messages**

Format:
```
<type>: <short description>

<detailed description>
<what changed>
<why it changed>
<how to test it>

📦 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

Types: `Add`, `Update`, `Fix`, `Remove`, `Refactor`, `Docs`, `Test`

### **Rule #15: When to Commit**

Commit when:
- ✅ Test passes
- ✅ Feature works
- ✅ Code is clean
- ✅ No console errors

Don't commit when:
- ❌ Tests failing
- ❌ Broken functionality
- ❌ Half-finished features
- ❌ Debug code still in files

### **Rule #16: Push Frequency**

```bash
# After every working feature
git add <files>
git commit -m "Add: feature description"
git push

# NOT just at end of day
# Push working increments frequently
```

---

## 🎯 PLANNING RULES

### **Rule #17: Feature Planning Required**

Before coding ANY feature:
1. Create plan using FEATURE_TEMPLATE.md
2. List all files that will change
3. Identify risks (Low/Medium/High)
4. Write test plan
5. Get approval (from yourself or team)

### **Rule #18: Risk Assessment**

Every feature must be classified:

**🟢 Low Risk**
- No modification to existing functions
- Read-only data access
- New isolated features
- Documentation only

**🟡 Medium Risk**
- Adds new data fields
- Modifies HTML/CSS
- New backend endpoints
- Requires testing with real data

**🔴 High Risk**
- Modifies core functions
- Changes data structure
- Alters check-in logic
- Requires data migration

### **Rule #19: Definition of Done**

A feature is NOT done until:
- [ ] Code written and tested
- [ ] Test function passes
- [ ] All existing tests still pass
- [ ] Browser testing complete (for HTML)
- [ ] CHANGELOG.md updated
- [ ] Git committed and pushed
- [ ] Deployed and verified in production

---

## 🚫 FORBIDDEN ACTIONS

### **What You Should NEVER Do:**

1. ❌ Delete the FRC sheet
2. ❌ Rename FRC sheet without updating CONFIG
3. ❌ Insert columns in middle of sheet (breaks indices)
4. ❌ Change column order
5. ❌ Modify CONFIG.COL values
6. ❌ Deploy without testing
7. ❌ Commit broken code
8. ❌ Work directly on main branch
9. ❌ Skip test functions
10. ❌ Make multiple unrelated changes in one commit

---

## ✅ ENCOURAGED ACTIONS

### **What You SHOULD Do:**

1. ✅ Write test functions first
2. ✅ Create new functions instead of modifying
3. ✅ Add columns at END of sheet
4. ✅ Commit frequently (small changes)
5. ✅ Document as you go
6. ✅ Ask questions when unsure
7. ✅ Use Logger.log() extensively
8. ✅ Test in incognito browser
9. ✅ Keep backups of working versions
10. ✅ Read error messages carefully

---

## 🆘 EMERGENCY RULES

### **Rule #20: When Things Break**

**STOP. DO NOT:**
- ❌ Make more changes to "fix" it
- ❌ Deploy anyway
- ❌ Delete error messages

**DO THIS:**
1. ✅ Check Apps Script execution logs (View → Logs)
2. ✅ Check browser console (F12)
3. ✅ Revert to last working commit: `git reset --hard HEAD~1`
4. ✅ Restore Apps Script from version history
5. ✅ Document what broke and why

### **Rule #21: Rollback Procedure**

If deployed code breaks production:
```
1. Go to Apps Script → Deploy → Manage deployments
2. Click Edit (pencil icon)
3. Version → Select previous working version
4. Click Deploy
5. Verify system works
6. Then fix the code offline
```

---

## 📊 METRICS TO TRACK

Track these to ensure quality:

- **Test Pass Rate:** Should be 100% before deployment
- **Commits Per Feature:** Smaller is better (5-10 commits)
- **Lines Changed Per Commit:** Under 100 lines preferred
- **Time Between Tests:** Test every 15-30 minutes while coding
- **Rollbacks:** Should be zero (if following rules)

---

## 🎓 LEARNING RULES

### **Rule #22: When You Don't Understand**

If you encounter code you don't understand:
1. ✅ Add comments explaining what it does
2. ✅ Write test function to verify behavior
3. ✅ Ask questions
4. ❌ Don't modify it until you understand it

### **Rule #23: Code Review (Self)**

Before committing, review your own code:
- Is it readable?
- Are variable names clear?
- Are there comments for complex logic?
- Could someone else understand this?
- Is there duplicated code that should be a function?

---

## 📝 DOCUMENTATION RULES

### **Rule #24: Update Docs With Code**

When you change code, update:
- CHANGELOG.md (what changed)
- README.md (if user-facing)
- Code comments (if complex logic)
- Test function description

### **Rule #25: Comment Standards**

```javascript
/**
 * Short description of what function does
 *
 * @param {string} uid - Guest unique identifier
 * @param {string} newName - New screen name to set
 * @returns {Object} {ok: boolean, message: string}
 */
function updateGuestScreenName(uid, newName) {
  // Implementation
}
```

---

## 🎯 ENFORCEMENT

**These rules are not suggestions.**

Following them ensures:
- ✅ Working code stays working
- ✅ New features don't break old features
- ✅ You can always rollback
- ✅ Team members can understand your changes
- ✅ Production system stays stable

**Breaking these rules risks breaking the system.**

---

## 📋 QUICK REFERENCE CHECKLIST

Copy this for every feature:

```
PRE-DEVELOPMENT
[ ] Feature planned using FEATURE_TEMPLATE.md
[ ] Risk level identified (Low/Medium/High)
[ ] New branch created
[ ] Current tests pass

DURING DEVELOPMENT
[ ] Test function written first
[ ] Code written incrementally
[ ] Tested after every major change
[ ] No forbidden modifications made
[ ] Git commits every 30-60 minutes

PRE-DEPLOYMENT
[ ] Feature test passes
[ ] All existing tests pass
[ ] Browser testing complete
[ ] No console errors
[ ] CHANGELOG.md updated
[ ] Committed and pushed

POST-DEPLOYMENT
[ ] Deployed as new version (not updating current)
[ ] Tested in production
[ ] Monitoring for errors
[ ] Ready to rollback if needed
```

---

**Print this. Keep it visible. Follow it religiously.** 🛡️
