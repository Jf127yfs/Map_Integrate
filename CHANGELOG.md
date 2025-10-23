# Changelog

## [1.0.0] - 2025-10-22 - BASELINE (WORKING VERSION)

### ✅ **Current Working Features**

#### Backend (Google Apps Script)
- [x] **Check-in system** - Guests can check in using ZIP + Gender + Birthday
- [x] **Screen name updates** - Guests can change their display name
- [x] **Photo uploads** - Photos upload to Google Drive folder
- [x] **Guest data retrieval** - `getCheckedInGuests()` fetches from FRC sheet
- [x] **Web app routing** - `doGet()` handles display/checkin/wall pages
- [x] **Unknown guest detection** - Identifies guests who don't know hosts

#### Frontend
- [x] **CheckInInterface** - Functional check-in form with validation
- [x] **Wall visualization** - Animated connection display with 7 categories
- [x] **Intro screen** - Terminal-style welcome page

#### Data Structure
- [x] **FRC sheet** - 30 columns (A-AD) properly indexed
- [x] **Column mapping** - CONFIG object with all column indices
- [x] **Drive integration** - Photo folder ID configured

### 📊 **Known Data Columns (30 total)**

```
A-E:   Timestamp, Birthday, Zodiac, Age, Education
F-H:   ZIP, Ethnicity, Gender
I-K:   Orientation, Industry, Role
L-N:   Know Hosts, Known Longest, Know Score
O-R:   Interests (Raw + 3 parsed)
S-U:   Music, Artist, Song
V-X:   Recent Purchase, At Worst, Social Stance
Y-Z:   Screen Name, UID
AA-AD: DDD Score, Checked In, Check-in Time, Photo URL
```

### 🔧 **Configuration**
```javascript
Sheet Name: FRC
Photo Folder ID: 1ZcP5jpYsYy0xuGqlFYNrDgG4K40eEKJB
```

---

## Development Notes

### ⚠️ **DO NOT MODIFY WITHOUT TESTING:**
1. Column index mappings in CONFIG.COL
2. Check-in verification logic (Code.gs lines 536-689)
3. FRC sheet name references
4. Photo upload function (Code.gs lines 772-855)

### 🧪 **Test Before Deploying:**
- Run `testCheckInSystem()` after backend changes
- Run `testWallData()` after analytics changes
- Check browser console on frontend changes

---

## Future Enhancements (Planned)

- [ ] Phase 3: Advanced analytics (Pan_Master, similarity calculations)
- [ ] Phase 4: Additional visualizations (compatibility matches)
- [ ] Phase 5: Documentation automation (Master_Desc, Tool_Registry)

---

## Change History

**2025-10-22:** Baseline version documented, README created
