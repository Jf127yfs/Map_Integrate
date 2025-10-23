# Feature Planning Template

> Copy this template for each new feature. Fill it out BEFORE writing any code.

---

## Feature Name

**[Feature Name Here]**

---

## 📋 Basic Information

**Feature ID:** `FEAT-XXX` (e.g., FEAT-001)
**Date:** YYYY-MM-DD
**Developer:** [Your Name]
**Priority:** [Low / Medium / High / Critical]
**Estimated Time:** [Hours/Days]

---

## 🎯 Goal

**What does this feature do?**
<!-- Write 2-3 sentences explaining the feature -->


**Why do we need it?**
<!-- Business/user value -->


**Success Criteria:**
<!-- How do we know it's working? -->
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

---

## 🔍 Risk Assessment

**Risk Level:** [🟢 Low / 🟡 Medium / 🔴 High]

**Low Risk (🟢)** = New isolated feature, no modifications to existing code
**Medium Risk (🟡)** = Some modifications, new data fields, requires testing
**High Risk (🔴)** = Modifies core logic, changes data structure, affects check-in

**Explanation:**
<!-- Why this risk level? -->


**Mitigation Plan:**
<!-- How will you minimize risk? -->
- [ ] Mitigation step 1
- [ ] Mitigation step 2

---

## 📁 Files Affected

### Files to CREATE (new files)
- [ ] `filename1.html` - Purpose
- [ ] `filename2.gs` - Purpose

### Files to MODIFY (existing files)
- [ ] `Code.gs` - What sections: Lines XXX-YYY
- [ ] `WallData.gs` - What sections: Lines XXX-YYY
- [ ] `CheckInInterface.html` - What sections: Lines XXX-YYY

### Files NOT Touched (but related)
- [ ] `filename.gs` - Not modifying because...

---

## 🏗️ Technical Design

### Backend Changes

**New Functions to Create:**
```javascript
/**
 * Function name and signature
 */
function myNewFunction(param1, param2) {
  // High-level logic description
  // 1. Do this
  // 2. Then this
  // 3. Return this
}
```

**Existing Functions to Call:**
- `getFRCSheet()` - To get data
- `getCheckedInGuests()` - To get guest list

**Data Accessed:**
- FRC Sheet columns: [List which columns]
- Other sheets: [List]

**Data Modified:**
- Columns: [List which columns will be written to]
- New columns needed: [Yes/No, which ones?]

### Frontend Changes

**New HTML Elements:**
<!-- Describe UI changes -->


**New Event Handlers:**
<!-- What user interactions? -->


**google.script.run Calls:**
```javascript
google.script.run
  .withSuccessHandler(onSuccess)
  .withFailureHandler(onError)
  .functionName(param1, param2);
```

---

## 🧪 Testing Plan

### Test Function

**Name:** `testMyFeature()`

**Test Cases:**
1. **Normal case:** [Description]
   - Input: [Sample data]
   - Expected output: [What should happen]

2. **Edge case 1:** [Description]
   - Input: [Sample data]
   - Expected output: [What should happen]

3. **Error case:** [Description]
   - Input: [Invalid data]
   - Expected output: [Error message]

**Test Function Code:**
```javascript
function testMyFeature() {
  Logger.log('=== TESTING MY FEATURE ===');

  try {
    // Test case 1: Normal case
    const result1 = myNewFunction('normal', 'input');
    if (!result1.ok) throw new Error('Normal case failed');

    // Test case 2: Edge case
    const result2 = myNewFunction('edge', 'case');
    if (!result2.ok) throw new Error('Edge case failed');

    // Test case 3: Error case
    const result3 = myNewFunction('invalid', 'data');
    if (result3.ok) throw new Error('Should have failed but passed');

    Logger.log('✅ ALL TESTS PASSED');
    return {passed: true};

  } catch (error) {
    Logger.log('❌ TEST FAILED: ' + error.message);
    return {passed: false, error: error.message};
  }
}
```

### Manual Testing Steps

**Browser Testing:**
1. [ ] Open page in Chrome incognito
2. [ ] Test action 1
3. [ ] Verify result 1
4. [ ] Test action 2
5. [ ] Verify result 2

**Regression Testing:**
- [ ] Run `testCheckInSystem()` - Still passes
- [ ] Run `testWallData()` - Still passes
- [ ] Test existing check-in flow - Still works
- [ ] Test existing wall display - Still works

---

## 📊 Data Requirements

### Existing Data Used

**FRC Sheet Columns:**
| Column | Field Name | How Used |
|--------|------------|----------|
| A | TIMESTAMP | Read for X |
| Y | SCREEN_NAME | Read for Y |

### New Data Fields (if any)

**Need to add columns?** [Yes/No]

If yes:
| New Column | Field Name | Data Type | Purpose |
|------------|------------|-----------|---------|
| AE | NEW_FIELD | String | For feature X |

**Migration needed?** [Yes/No]
<!-- If adding columns, how do we handle existing rows? -->

---

## 🔄 Integration Points

### How This Feature Connects to Existing System

**Calls these existing functions:**
- `getFRCSheet()` - Why: To access data
- `getCheckedInGuests()` - Why: To get guest list

**Called by:**
- New menu item: "Feature Name"
- New HTML page: `FeaturePage.html`
- Existing page: [None/Which one]

**Data flow:**
```
User Action → Frontend Event → Backend Function → FRC Sheet
     ↓              ↓                  ↓              ↓
[Describe]    [Describe]         [Describe]     [Describe]
```

---

## 🚀 Deployment Plan

### Phase 1: Development (Local Testing)
1. [ ] Create feature branch: `feature/my-feature-name`
2. [ ] Write test function
3. [ ] Write feature code
4. [ ] Test in Apps Script (Execution log)
5. [ ] Commit: "Add: test function for feature X"

### Phase 2: Integration Testing
6. [ ] Run all test functions
7. [ ] Deploy as TEST web app (new deployment)
8. [ ] Test in browser (incognito)
9. [ ] Check console for errors
10. [ ] Commit: "Add: feature X implementation"

### Phase 3: Production Deployment
11. [ ] Update CHANGELOG.md
12. [ ] Final test of all features
13. [ ] Deploy as NEW VERSION (keep old version)
14. [ ] Test in production
15. [ ] Monitor for 24 hours
16. [ ] Commit: "Release: feature X v1.0"

### Rollback Plan
If feature breaks:
```
1. Apps Script → Manage Deployments
2. Edit deployment → Select previous version
3. Deploy
4. Verify system works
5. Debug offline
```

---

## 📝 Documentation Updates

### Files to Update

- [ ] **CHANGELOG.md** - Add entry for this feature
- [ ] **README.md** - Add feature documentation (if user-facing)
- [ ] **Code comments** - Document new functions
- [ ] **This template** - Archive as `features/FEAT-XXX.md`

---

## ✅ Pre-Development Checklist

Before writing ANY code:

- [ ] This template is completely filled out
- [ ] Risk level identified and acceptable
- [ ] All existing tests currently pass
- [ ] Feature branch created
- [ ] Test function designed (written above)
- [ ] File modification list complete
- [ ] No forbidden changes planned (see RULES.md)

---

## 🎯 Development Checklist

During development:

- [ ] Test function written FIRST
- [ ] Test function runs (and fails initially)
- [ ] Feature code written incrementally
- [ ] Git commits every 30-60 minutes
- [ ] Logger.log() statements added for debugging
- [ ] No hardcoded values (use CONFIG)
- [ ] Error handling added
- [ ] Code commented

---

## 🧪 Testing Checklist

Before committing:

- [ ] Feature test function passes
- [ ] `testCheckInSystem()` still passes
- [ ] `testWallData()` still passes
- [ ] Manual browser test complete
- [ ] No console errors
- [ ] No execution log errors
- [ ] Tested with real data
- [ ] Tested edge cases
- [ ] Tested error conditions

---

## 📦 Deployment Checklist

Before deploying to production:

- [ ] All tests pass
- [ ] CHANGELOG.md updated
- [ ] README.md updated (if needed)
- [ ] Git committed and pushed
- [ ] Deployed as NEW version (not update)
- [ ] Tested in production environment
- [ ] Monitoring plan in place
- [ ] Rollback plan understood

---

## 📊 Post-Deployment Monitoring

After deployment:

**Check these in first 24 hours:**
- [ ] No errors in Apps Script execution log
- [ ] No browser console errors
- [ ] Users can complete feature workflow
- [ ] Existing features still work
- [ ] Data is being saved correctly

**Metrics to track:**
- Usage count: [How to measure]
- Error rate: [Monitor Apps Script logs]
- User feedback: [How to collect]

---

## 💡 Notes & Assumptions

**Assumptions:**
<!-- What are you assuming about the system/data/users? -->
1.
2.
3.

**Open Questions:**
<!-- What needs to be decided/clarified? -->
1.
2.
3.

**Known Limitations:**
<!-- What won't this feature do? -->
1.
2.
3.

**Future Enhancements:**
<!-- What could be added later? -->
1.
2.
3.

---

## 🔗 Related Features

**Depends on:**
<!-- What must exist for this to work? -->
- Existing feature 1
- Existing feature 2

**Enables:**
<!-- What new features does this unlock? -->
- Future feature 1
- Future feature 2

**Conflicts with:**
<!-- Are there any incompatibilities? -->
- None known

---

## 📅 Timeline

**Planned Start:** YYYY-MM-DD
**Planned Completion:** YYYY-MM-DD
**Actual Start:** YYYY-MM-DD
**Actual Completion:** YYYY-MM-DD

**Milestones:**
- [ ] Planning complete (this document)
- [ ] Test function written
- [ ] Feature code complete
- [ ] Testing complete
- [ ] Documentation updated
- [ ] Deployed to production
- [ ] Monitoring complete

---

## ✍️ Sign-off

**Planned By:** [Name] on [Date]
**Reviewed By:** [Name] on [Date]
**Approved By:** [Name] on [Date]

**Status:** [Planning / In Progress / Testing / Complete / Cancelled]

---

## 📎 Archive

After feature is complete, move this file to:
`/features/FEAT-XXX-feature-name.md`

This becomes the permanent record of how the feature was built.

---

**Remember: Fill this out BEFORE writing code. It saves time and prevents mistakes!**
