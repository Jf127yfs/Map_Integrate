# Panopticon Guest Analytics System

> A Google Apps Script-based guest check-in and social network analysis system for events

## 📋 Project Overview

Panopticon is an event management system that allows guests to check in via a web interface and visualizes social connections between attendees in real-time. The system analyzes demographics, interests, and social attributes to create a dynamic "wall" display showing how guests are connected.

---

## 🏗️ System Architecture

### Components

```
┌─────────────────────────────────────────────────────────────┐
│                    Google Sheets (Data Store)                │
│                     Sheet: FRC (Form Responses Clean)        │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│              Google Apps Script Backend                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Code.gs    │  │ WallData.gs  │  │  Tools.gs    │      │
│  │   (Core)     │  │ (Analytics)  │  │  (Testing)   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                    Web App Interface                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │CheckInInterface│ │   Intro.html │  │   Wall.html  │      │
│  │  (Guest Form)  │ │  (Welcome)   │  │(Visualization)│     │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

---

## 📊 FRC Sheet Data Structure

The **FRC (Form Responses Clean)** Google Sheet is the primary data source. Below are the column assignments as defined in `Code.gs`:

### Column Index Reference

| Column | Index | Field Name | Description |
|--------|-------|------------|-------------|
| **A** | 0 | `TIMESTAMP` | Form submission timestamp |
| **B** | 1 | `BIRTHDAY` | Guest birthday (MM/DD format) |
| **C** | 2 | `ZODIAC` | Zodiac sign |
| **D** | 3 | `AGE` | Age group/range |
| **E** | 4 | `EDU` | Education level |
| **F** | 5 | `ZIP` | ZIP code (used for check-in verification) |
| **G** | 6 | `ETHNICITY` | Ethnicity |
| **H** | 7 | `GENDER` | Gender (used for check-in verification) |
| **I** | 8 | `ORIENTATION` | Sexual orientation |
| **J** | 9 | `INDUSTRY` | Work industry |
| **K** | 10 | `ROLE` | Job role |
| **L** | 11 | `KNOW_HOSTS` | Do they know the hosts? |
| **M** | 12 | `KNOWN_LONGEST` | How long have they known hosts? |
| **N** | 13 | `KNOW_SCORE` | Host familiarity score |
| **O** | 14 | `INTERESTS_RAW` | Raw interests data |
| **P** | 15 | `INTEREST_1` | Primary interest |
| **Q** | 16 | `INTEREST_2` | Secondary interest |
| **R** | 17 | `INTEREST_3` | Tertiary interest |
| **S** | 18 | `MUSIC` | Music preference |
| **T** | 19 | `ARTIST` | Favorite artist |
| **U** | 20 | `SONG` | Favorite song |
| **V** | 21 | `RECENT_PURCHASE` | Recent purchase |
| **W** | 22 | `AT_WORST` | At worst description |
| **X** | 23 | `SOCIAL_STANCE` | Social stance (1-10 scale) |
| **Y** | 24 | `SCREEN_NAME` | Display name (updatable) |
| **Z** | 25 | `UID` | Unique identifier |
| **AA** | 26 | `DDD_SCORE` | DDD scoring metric |
| **AB** | 27 | `CHECKED_IN` | Check-in status (Y/N) |
| **AC** | 28 | `CHECKIN_TIME` | Check-in timestamp |
| **AD** | 29 | `PHOTO_URL` | Google Drive photo URL |

### Check-In Verification Fields

Guests check in using these three fields:
- **ZIP code** (Column F)
- **Gender** (Column H)
- **Birthday** (Column B, MM/DD format)

---

## 🔧 Backend Files

### 1. **Code.gs** (Main Controller)

**Purpose:** Core system logic, routing, and check-in management

**Key Functions:**
- `doGet(e)` - Web app router (handles display, checkin, wall pages)
- `checkInGuest(zip, gender, dob)` - Guest check-in logic
- `updateGuestScreenName(uid, newScreenName)` - Update display name
- `uploadGuestPhoto(uid, fileName, mimeType, base64Data)` - Photo upload to Drive
- `getFRCSheet()` - Get the main data sheet
- `getCheckedInGuests()` - Retrieve all checked-in guests

**Configuration:**
```javascript
CONFIG.SHEETS.FRC = 'FRC'  // Main data sheet name
CONFIG.PHOTO_FOLDER_ID = '1ZcP5jpYsYy0xuGqlFYNrDgG4K40eEKJB'  // Google Drive folder
```

---

### 2. **WallData.gs** (Analytics Engine)

**Purpose:** Process guest data and build connection networks

**Key Functions:**
- `getWallData()` - Fetch all data for visualization
- `buildConnectionsByCategory(guests)` - Create connection matrices
- `buildAgeConnections(guests)` - Connect guests by age group
- `buildInterestConnections(guests)` - Connect guests by shared interests
- `buildMusicConnections(guests)` - Connect guests by music preferences
- `buildZodiacConnections(guests)` - Connect guests by zodiac sign
- `buildIndustryConnections(guests)` - Connect guests by industry
- `buildEducationConnections(guests)` - Connect guests by education level
- `buildSocialStanceConnections(guests)` - Connect guests by social stance

**Connection Categories:**
1. Age groups
2. Shared interests
3. Music preferences
4. Zodiac signs
5. Industry
6. Education level
7. Social stance

**Note:** Orientation connections are excluded for privacy.

---

### 3. **Tools.gs** (Testing & Utilities)

**Purpose:** Testing functions and documentation generation

**Key Functions:**
- `testCheckInSystem()` - Test check-in functionality
- `analyzeCheckedInGuests()` - Analyze guest data completeness
- `generateMasterDesc()` - Auto-generate data dictionary
- `testWallData()` - Test wall data fetching
- `runAllWallTests()` - Comprehensive test suite

---

## 🎨 Frontend Files

### 1. **CheckInInterface** (Guest Check-In Form)

**URL:** `?page=checkin`

**Features:**
- Guest identity verification (ZIP, gender, birthday)
- Screen name updates
- Photo upload (stored in Google Drive)
- Real-time status messages
- Debug mode for troubleshooting

**User Flow:**
1. Enter ZIP code, gender, birthday
2. System verifies against FRC sheet
3. Updates `CHECKED_IN` column (AB) to "Y"
4. Records `CHECKIN_TIME` (AC)
5. Allows photo upload and screen name changes

---

### 2. **Intro** (Welcome Screen)

**URL:** Not directly accessible (future landing page)

**Features:**
- Terminal/CRT aesthetic with scanline effects
- Typing animation for "WELCOME TO THE WALL 2025"
- System initialization messages
- Gallery placeholder for previous events

**Design:** Matrix/cyberpunk theme with green text on black background

---

### 3. **Wall** (Live Visualization)

**URL:** `?page=wall`

**Features:**
- Real-time guest connection visualization
- Animated line drawing between connected guests
- Category-based analysis cycling
- Speed control slider (1x to 10x)
- Unknown guest violation panel
- Statistics panels (connections, categories, guests)
- Terminal-style activity log

**Visualization Elements:**
- **Guest Cards:** Display UID and check-in time
- **Connection Lines:** Animated lines showing relationships
- **Color Coding:** Each category gets unique color
- **Sidebar Key:** Shows all analysis categories
- **Violation Panel:** Highlights guests who don't know hosts

**Analysis Cycle:**
The wall cycles through all demographic categories, drawing connections:
1. Age groups
2. Interests (cycles through each interest)
3. Music preferences
4. Zodiac signs
5. Industries
6. Education levels
7. Social stance ranges

---

## 🚀 Deployment

### Setup Instructions

1. **Open Google Sheets** containing your FRC data
2. **Extensions → Apps Script**
3. **Create Files:**
   - `Code.gs` (paste Code file contents)
   - `WallData.gs` (paste WallData file contents)
   - `Tools.gs` (paste Tools file contents)
4. **Create HTML Files:**
   - `CheckInInterface.html`
   - `Intro.html`
   - `Wall.html`
5. **Configure:**
   - Ensure sheet is named `FRC`
   - Update `CONFIG.PHOTO_FOLDER_ID` with your Google Drive folder ID
6. **Deploy:**
   - Click **Deploy → New deployment**
   - Type: **Web app**
   - Execute as: **Me**
   - Who has access: **Anyone** (or as needed)
   - Copy the web app URL

### Access URLs

Once deployed, access different pages:
- **Display Dashboard:** `https://script.google.com/...` (base URL)
- **Check-In Form:** `https://script.google.com/...?page=checkin`
- **Wall Visualization:** `https://script.google.com/...?page=wall`

---

## 🔑 Key Features

### Check-In System
- ✅ Identity verification using 3 data points
- ✅ Prevents duplicate check-ins
- ✅ Photo upload with Google Drive integration
- ✅ Screen name customization
- ✅ Real-time status updates

### Analytics Engine
- ✅ Multi-dimensional connection analysis
- ✅ Privacy-conscious (excludes orientation from public display)
- ✅ Unknown guest detection
- ✅ Arrival rate tracking

### Visualization
- ✅ Real-time animated connections
- ✅ Adjustable animation speed
- ✅ Category cycling
- ✅ Terminal-style aesthetics
- ✅ Responsive guest card layout (supports up to 91 guests)

---

## 📝 Data Privacy Notes

- **Orientation data** is collected but NOT displayed on the wall
- **Unknown guests** (those who don't know hosts) are flagged privately
- **Photo uploads** are stored in a private Google Drive folder
- **UIDs** are used for display instead of real names

---

## 🧪 Testing

### Menu Commands (in Google Sheets)

After deployment, use the custom menu **🎭 Panopticon:**
- **Open Check-In Interface** - Launch check-in page
- **View Display Dashboard** - Open main display
- **Test Check-In System** - Verify check-in functionality
- **Generate Master Description** - Create data dictionary

### Test Functions (Run from Script Editor)

```javascript
testCheckInSystem()       // Test guest retrieval
testWallData()           // Test wall data fetching
runAllWallTests()        // Comprehensive test suite
analyzeCheckedInGuests() // Data completeness report
```

---

## 🛠️ Configuration

### Key Settings in Code.gs

```javascript
CONFIG = {
  SHEETS: {
    FRC: 'FRC',                    // Main data sheet name
    MASTER_DESC: 'Master_Desc',    // Documentation sheet
    PAN_LOG: 'Pan_Log',            // Event log sheet
    TOOL_REGISTRY: 'Tool_Registry', // Function tracking
    DATA_DICT: 'Data_Dictionary'   // Data dictionary
  },
  PHOTO_FOLDER_ID: '1ZcP5jpYsYy0xuGqlFYNrDgG4K40eEKJB' // Google Drive folder
}
```

---

## 📌 Important Notes

### Sheet Requirements
- Sheet MUST be named **"FRC"** (or update CONFIG)
- Column order MUST match the index reference above
- All 30 columns (A-AD) should be present

### Birthday Format
- Input format: `MM/DD` (e.g., `03/15`)
- System normalizes with leading zeros (e.g., `3/5` → `03/05`)

### Check-In Status
- Column AB (`CHECKED_IN`) uses "Y" or "Yes" for checked-in guests
- Column AC (`CHECKIN_TIME`) stores timestamp

### Photo Storage
- Photos stored in Google Drive folder (ID in CONFIG)
- Filenames: `{UID}_{originalFileName}`
- Public sharing link generated and stored in Column AD

---

## 🎯 Future Enhancements (Placeholders)

From Code.gs comments:
- **Phase 3:** Advanced analytics layer (Pan_Master, similarity calculations)
- **Phase 4:** Additional visualization endpoints (compatibility matches)
- **Phase 5:** Documentation automation (Master_Desc, Tool_Registry)

---

## 📄 File Manifest

| File | Type | Purpose |
|------|------|---------|
| `Code` | Apps Script | Main controller & routing |
| `WallData` | Apps Script | Analytics & connection building |
| `Tools` | Apps Script | Testing & documentation |
| `CheckInInterface` | HTML | Guest check-in form |
| `Intro` | HTML | Welcome screen |
| `Wall` | HTML | Live visualization display |

---

## 🔍 Troubleshooting

### Common Issues

1. **"FRC sheet not found"**
   - Ensure sheet is named exactly "FRC"
   - Run `listAllSheets()` to see available sheets

2. **Check-in fails**
   - Verify ZIP, gender, and birthday match FRC data exactly
   - Check birthday format (MM/DD)
   - Run `testCheckInSystem()` to diagnose

3. **Photos not uploading**
   - Verify `CONFIG.PHOTO_FOLDER_ID` is correct
   - Ensure folder has proper sharing permissions
   - Check file size (max 10MB)

4. **Wall not displaying connections**
   - Ensure at least 2 guests are checked in
   - Run `testWallData()` to check data retrieval
   - Check browser console for JavaScript errors

---

## 📞 Support

For issues or questions:
- Check the Apps Script execution log (View → Logs)
- Use the test functions in Tools.gs
- Enable debug mode in CheckInInterface (line 336: `debugMode = true`)

---

## 🏷️ Version

**Current Version:** 1.0
**Last Updated:** 2025-10-22
**System Status:** Foundation layer active, ready for expansion

---

## ⚖️ License

This is a private event management system. All guest data should be handled according to applicable privacy laws and event policies.

---

**Built with Google Apps Script**
*A real-time social network analysis system for events*
