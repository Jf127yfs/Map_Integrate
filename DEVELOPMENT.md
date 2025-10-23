# Development Guide

> **Safe development practices for the Panopticon system**

## 🛡️ Golden Rules

### **NEVER modify these without backup:**
1. ✋ Column indices in `CONFIG.COL` (Code.gs lines 25-56)
2. ✋ Check-in verification logic (Code.gs lines 536-689)
3. ✋ Sheet name references (`CONFIG.SHEETS.FRC`)
4. ✋ Photo upload function (Code.gs lines 772-855)

### **ALWAYS do this before changes:**
1. ✅ Run existing test functions to verify current state
2. ✅ Create a new git branch for your feature
3. ✅ Write test function BEFORE modifying production code
4. ✅ Test incrementally (small changes, test often)

---

## 🔄 Safe Development Workflow

### **Step 1: Before You Start**
```bash
# Ensure you're on the right branch
git status

# Create feature branch
git checkout -b feature/your-feature-name
```

### **Step 2: Verify Current State**

**In Google Apps Script Editor:**
```javascript
// Run these tests to ensure system is working
testCheckInSystem()      // Check guest retrieval
testWallData()          // Check analytics
runAllWallTests()       // Full suite
```

### **Step 3: Make Changes Safely**

#### Option A: Add New Function (SAFEST)
```javascript
// Create new function, don't modify existing ones
function myNewFeature() {
  // Your new code here
  // Test it independently first
}

function testMyNewFeature() {
  const result = myNewFeature();
  Logger.log('Test result:', result);
  return result;
}
```

#### Option B: Modify Existing Function (CAUTION)
```javascript
// 1. Copy the original function
function originalFunctionName_BACKUP() {
  // Paste original code here
}

// 2. Modify the working version
function originalFunctionName() {
  // Your modifications
}

// 3. Create test
function testModifiedFunction() {
  // Test your changes
}
```

### **Step 4: Test Your Changes**

**Local Testing:**
1. Run your test function in Apps Script
2. Check execution logs (View → Logs)
3. Test with sample data first

**Browser Testing (for HTML changes):**
1. Deploy as NEW version (don't update existing)
2. Test in incognito window
3. Check browser console for errors

### **Step 5: Commit Incrementally**
```bash
# Small, focused commits
git add <specific-file>
git commit -m "Add: specific feature description"

# Push to your feature branch
git push -u origin feature/your-feature-name
```

---

## 🧪 Testing Checklist

### Before ANY Deployment

- [ ] Run `testCheckInSystem()` - verify guest retrieval works
- [ ] Run `testWallData()` - verify analytics work
- [ ] Test check-in with real data (use existing guest info)
- [ ] Verify FRC sheet not modified unexpectedly
- [ ] Check Apps Script execution logs for errors
- [ ] Test in browser incognito mode

### For Backend Changes (Code.gs, WallData.gs)

- [ ] Create test function first
- [ ] Test with sample data
- [ ] Verify no column index changes
- [ ] Check that existing functions still work
- [ ] Run `listAllSheets()` if modifying sheet access

### For Frontend Changes (HTML files)

- [ ] Test in multiple browsers (Chrome, Firefox, Safari)
- [ ] Check browser console for JavaScript errors
- [ ] Verify `google.script.run` calls still work
- [ ] Test responsive design (mobile, tablet, desktop)
- [ ] Check that existing UI elements still function

---

## 📁 File Safety Guide

### **Safe to Modify (Low Risk)**
- ✅ `README.md` - Documentation only
- ✅ `CHANGELOG.md` - Documentation only
- ✅ `DEVELOPMENT.md` - This file
- ✅ `Tools.gs` - Testing functions (doesn't affect production)

### **Modify with Caution (Medium Risk)**
- ⚠️ `Intro.html` - Visual only, doesn't affect data
- ⚠️ `Wall.html` - Display only, test thoroughly
- ⚠️ New functions in `Code.gs` - Test before using
- ⚠️ New analytics in `WallData.gs` - Verify data access

### **High Risk (BACKUP FIRST)**
- 🚨 `CONFIG` object in Code.gs
- 🚨 `checkInGuest()` function
- 🚨 `uploadGuestPhoto()` function
- 🚨 Column index definitions
- 🚨 `CheckInInterface.html` (active user-facing form)

---

## 🔍 Debugging Guide

### Common Issues & Solutions

#### **"FRC sheet not found"**
```javascript
// Debug: List all sheets
listAllSheets()

// Fix: Ensure sheet name is exactly "FRC"
// Or update CONFIG.SHEETS.FRC to match your sheet name
```

#### **Check-in fails**
```javascript
// Debug: Test with known data
testCheckInManually()  // Update with real values first

// Check logs for details
View → Logs in Apps Script
```

#### **Photo upload fails**
```javascript
// Verify folder ID
const folder = DriveApp.getFolderById(CONFIG.PHOTO_FOLDER_ID);
Logger.log('Folder:', folder.getName());
```

#### **Wall not showing connections**
```javascript
// Debug: Check data retrieval
const data = getWallData();
Logger.log('Guests:', data.guests.length);
Logger.log('Connections:', data.connectionsByCategory);
```

---

## 🎯 Next Steps Decision Tree

### What do you want to build?

#### **1. New Feature** (e.g., compatibility scores, new analytics)
→ Use **Option A** workflow (add new function)
→ Test independently first
→ Integrate after proven working

#### **2. UI Enhancement** (e.g., better styling, new page)
→ Create new HTML file first
→ Test standalone
→ Add route in `doGet()` after testing

#### **3. Fix/Improve Existing** (e.g., better check-in validation)
→ Use **Option B** workflow (backup first)
→ Create test function
→ Modify incrementally

#### **4. Data Structure Change** (e.g., new column)
→ ⚠️ **HIGHEST RISK**
→ Add column at END of sheet (don't insert)
→ Update CONFIG.COL carefully
→ Test all functions that read data

---

## 📋 Pre-Deployment Checklist

Before deploying ANY changes:

```
[ ] All test functions pass
[ ] No errors in execution logs
[ ] Browser console clean (for HTML changes)
[ ] Feature tested with real data
[ ] Backup of current version exists
[ ] Changes documented in CHANGELOG.md
[ ] Git commit created
[ ] Ready to rollback if needed
```

---

## 🆘 Rollback Procedure

### If something breaks:

**1. Immediate fix (Apps Script):**
```javascript
// In Apps Script Editor
// Restore from version history:
File → Version history → See version history
// Select last working version → Restore
```

**2. Git rollback:**
```bash
# Revert to last commit
git reset --hard HEAD~1

# Or revert to specific commit
git log  # Find commit hash
git reset --hard <commit-hash>
```

**3. Redeploy:**
```
In Apps Script:
Deploy → Manage deployments
→ Edit (pencil icon)
→ Version: Select previous working version
→ Deploy
```

---

## 💡 Best Practices

1. **Small Changes:** One feature at a time
2. **Test Often:** After every 10-20 lines of code
3. **Commit Often:** Every working increment
4. **Document:** Update CHANGELOG.md
5. **Ask First:** If unsure, ask before modifying core functions

---

## 🎓 Learning Resources

### Google Apps Script
- [Apps Script Documentation](https://developers.google.com/apps-script)
- [Sheets Service Reference](https://developers.google.com/apps-script/reference/spreadsheet)
- [HTML Service](https://developers.google.com/apps-script/guides/html)

### Testing
- Use `Logger.log()` extensively
- Check `View → Logs` in Apps Script
- Use browser DevTools (F12) for frontend

---

## 📞 When to Ask for Help

Ask before proceeding if you're:
- Modifying column indices
- Changing check-in verification logic
- Altering data structure
- Getting errors you don't understand
- Unsure about impact of a change

---

**Remember:** Working code is valuable. Protect it first, enhance it second! 🛡️
