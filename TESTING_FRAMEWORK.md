# Testing Framework

> Comprehensive testing guide for Panopticon system

---

## 🎯 Testing Philosophy

### Core Principles

1. **Test First, Code Second** - Write test before feature
2. **Test Often** - After every 15-30 minutes of coding
3. **Test Everything** - Backend, frontend, integration
4. **Never Deploy Broken Tests** - 100% pass rate required

---

## 🧪 Test Types

### 1. Unit Tests (Backend Functions)

**Purpose:** Test individual functions in isolation

**Location:** Tools.gs or inline in Code.gs

**Template:**
```javascript
/**
 * Unit test for [function name]
 * Tests: [what aspects are tested]
 */
function testFunctionName() {
  Logger.log('=== TESTING: functionName ===');

  const testCases = [
    {
      name: 'Normal case',
      input: {param1: 'value1', param2: 'value2'},
      expected: {ok: true, result: 'expected'}
    },
    {
      name: 'Edge case - empty input',
      input: {param1: '', param2: ''},
      expected: {ok: false, message: 'Missing parameters'}
    },
    {
      name: 'Error case - invalid data',
      input: {param1: null, param2: undefined},
      expected: {ok: false}
    }
  ];

  let passed = 0;
  let failed = 0;

  testCases.forEach((tc, index) => {
    try {
      Logger.log(`\nTest ${index + 1}: ${tc.name}`);
      const result = functionName(tc.input.param1, tc.input.param2);

      // Verify result matches expected
      if (result.ok === tc.expected.ok) {
        Logger.log(`  ✅ PASS`);
        passed++;
      } else {
        Logger.log(`  ❌ FAIL - Expected ${tc.expected.ok}, got ${result.ok}`);
        failed++;
      }

    } catch (error) {
      Logger.log(`  ❌ ERROR: ${error.message}`);
      failed++;
    }
  });

  Logger.log(`\n=== SUMMARY ===`);
  Logger.log(`Passed: ${passed}/${testCases.length}`);
  Logger.log(`Failed: ${failed}/${testCases.length}`);

  return {
    passed: passed === testCases.length,
    total: testCases.length,
    passedCount: passed,
    failedCount: failed
  };
}
```

---

### 2. Integration Tests (Multi-Function)

**Purpose:** Test how functions work together

**Example:**
```javascript
/**
 * Integration test: Check-in flow
 * Tests the complete check-in process from input to database update
 */
function testCheckInFlow() {
  Logger.log('=== INTEGRATION TEST: Check-In Flow ===');

  const testGuest = {
    zip: '64110',
    gender: 'man',
    dob: '10/07'
  };

  try {
    // Step 1: Verify guest exists in FRC
    Logger.log('Step 1: Verifying guest data...');
    const sheet = getFRCSheet();
    const data = sheet.getDataRange().getValues();
    const guestExists = data.some(row =>
      row[CONFIG.COL.ZIP] === testGuest.zip
    );

    if (!guestExists) throw new Error('Test guest not found in FRC');
    Logger.log('  ✅ Guest exists');

    // Step 2: Perform check-in
    Logger.log('Step 2: Performing check-in...');
    const result = checkInGuest(testGuest.zip, testGuest.gender, testGuest.dob);

    if (!result.ok) throw new Error('Check-in failed: ' + result.message);
    Logger.log('  ✅ Check-in successful');

    // Step 3: Verify database updated
    Logger.log('Step 3: Verifying database update...');
    const updatedData = sheet.getDataRange().getValues();
    const checkedInRow = updatedData.find(row =>
      row[CONFIG.COL.ZIP] === testGuest.zip
    );

    if (!checkedInRow) throw new Error('Guest row not found');
    if (checkedInRow[CONFIG.COL.CHECKED_IN] !== 'Y') {
      throw new Error('Check-in flag not set');
    }
    Logger.log('  ✅ Database updated correctly');

    // Step 4: Verify return data
    Logger.log('Step 4: Verifying return data...');
    if (!result.uid) throw new Error('UID not returned');
    if (!result.screenName) throw new Error('Screen name not returned');
    Logger.log('  ✅ Return data complete');

    Logger.log('\n✅ INTEGRATION TEST PASSED');
    return {passed: true};

  } catch (error) {
    Logger.log(`\n❌ INTEGRATION TEST FAILED: ${error.message}`);
    return {passed: false, error: error.message};
  }
}
```

---

### 3. Regression Tests (Existing Functionality)

**Purpose:** Ensure new changes don't break existing features

**Master Test Runner:**
```javascript
/**
 * Run all regression tests
 * MUST pass before any deployment
 */
function runAllRegressionTests() {
  Logger.log('╔════════════════════════════════════════════════════════════╗');
  Logger.log('║           REGRESSION TEST SUITE                            ║');
  Logger.log('╚════════════════════════════════════════════════════════════╝\n');

  const tests = [
    {name: 'Check-In System', fn: testCheckInSystem},
    {name: 'Wall Data Retrieval', fn: testWallData},
    {name: 'Guest Data Access', fn: analyzeCheckedInGuests},
    {name: 'Sheet Access', fn: testSpreadsheetAccess},
    // Add all test functions here
  ];

  const results = [];
  let totalPassed = 0;
  let totalFailed = 0;

  tests.forEach((test, index) => {
    Logger.log(`\n[${index + 1}/${tests.length}] Running: ${test.name}`);
    Logger.log('─'.repeat(60));

    try {
      const result = test.fn();

      if (result && result.passed !== false) {
        Logger.log(`✅ ${test.name}: PASSED`);
        totalPassed++;
        results.push({name: test.name, status: 'PASS'});
      } else {
        Logger.log(`❌ ${test.name}: FAILED`);
        totalFailed++;
        results.push({name: test.name, status: 'FAIL', error: result?.error});
      }

    } catch (error) {
      Logger.log(`❌ ${test.name}: ERROR - ${error.message}`);
      totalFailed++;
      results.push({name: test.name, status: 'ERROR', error: error.message});
    }
  });

  // Summary
  Logger.log('\n╔════════════════════════════════════════════════════════════╗');
  Logger.log('║                    TEST SUMMARY                            ║');
  Logger.log('╚════════════════════════════════════════════════════════════╝');
  Logger.log(`Total Tests: ${tests.length}`);
  Logger.log(`✅ Passed: ${totalPassed}`);
  Logger.log(`❌ Failed: ${totalFailed}`);
  Logger.log(`Success Rate: ${Math.round((totalPassed / tests.length) * 100)}%\n`);

  if (totalFailed > 0) {
    Logger.log('⚠️  WARNING: TESTS FAILED - DO NOT DEPLOY');
    Logger.log('Failed tests:');
    results.filter(r => r.status !== 'PASS').forEach(r => {
      Logger.log(`  - ${r.name}: ${r.error || 'Unknown error'}`);
    });
  } else {
    Logger.log('✅ ALL TESTS PASSED - SAFE TO DEPLOY');
  }

  return {
    passed: totalFailed === 0,
    total: tests.length,
    passedCount: totalPassed,
    failedCount: totalFailed,
    results: results
  };
}
```

---

### 4. Frontend Tests (Browser/HTML)

**Purpose:** Test user interface and interactions

**Manual Test Checklist:**
```
CHECKIN INTERFACE TESTS
[ ] Page loads without errors
[ ] Form fields are visible and enabled
[ ] ZIP code field accepts 5 digits
[ ] Gender dropdown has all options
[ ] Birthday field accepts MM/DD format
[ ] Submit button is clickable
[ ] Valid guest check-in succeeds
[ ] Invalid credentials show error
[ ] Success message displays
[ ] Guest info shows after check-in
[ ] Screen name update works
[ ] Photo upload form appears
[ ] Photo selection works
[ ] Upload button activates
[ ] Upload succeeds with confirmation

WALL VISUALIZATION TESTS
[ ] Canvas loads and renders
[ ] Guest cards appear in correct positions
[ ] No overlapping cards
[ ] Connections draw correctly
[ ] Animation is smooth
[ ] Speed slider works
[ ] Category cycling works
[ ] Statistics update in real-time
[ ] Unknown guests highlighted
[ ] Terminal log shows activity
[ ] No JavaScript console errors
[ ] Responsive on mobile
[ ] Responsive on tablet

INTRO SCREEN TESTS
[ ] Page loads
[ ] Typing animation works
[ ] CRT effects display
[ ] No console errors
```

**Automated Frontend Testing (Optional):**
```javascript
// Add to HTML files for debugging
function runFrontendTests() {
  console.log('=== FRONTEND TESTS ===');

  const tests = [
    {
      name: 'Backend Connection',
      test: () => {
        return new Promise((resolve, reject) => {
          google.script.run
            .withSuccessHandler(() => resolve(true))
            .withFailureHandler((error) => reject(error))
            .ping();
        });
      }
    },
    {
      name: 'Form Elements Present',
      test: () => {
        const zipInput = document.getElementById('zip');
        const genderSelect = document.getElementById('gender');
        const dobInput = document.getElementById('dob');

        if (!zipInput || !genderSelect || !dobInput) {
          throw new Error('Missing form elements');
        }
        return true;
      }
    }
  ];

  tests.forEach(async (test) => {
    try {
      await test.test();
      console.log(`✅ ${test.name}: PASSED`);
    } catch (error) {
      console.error(`❌ ${test.name}: FAILED -`, error);
    }
  });
}
```

---

## 📋 Test Checklists

### Before Writing Code

```
[ ] Understand what feature does
[ ] Identify what functions will be called
[ ] Identify what data will be accessed
[ ] Write test cases on paper
[ ] Determine expected outputs
```

### During Development

```
[ ] Write test function first
[ ] Run test (should fail initially)
[ ] Write minimal code to pass test
[ ] Run test again (should pass)
[ ] Add more test cases
[ ] Refactor if needed
[ ] Run test after each refactor
```

### Before Committing

```
[ ] All new tests pass
[ ] All existing tests still pass
[ ] No errors in execution log
[ ] Code reviewed (self)
[ ] Comments added
```

### Before Deploying

```
[ ] runAllRegressionTests() passes
[ ] Manual browser testing complete
[ ] No console errors
[ ] Test with real data
[ ] Test edge cases
[ ] Test error conditions
[ ] Performance acceptable
```

---

## 🔍 Test Data

### Sample Test Data

**Test Guest (for check-in):**
```javascript
const TEST_GUEST = {
  zip: '64110',
  gender: 'man',
  dob: '10/07',
  expectedUID: 'GUEST_XXX',
  expectedScreenName: 'Test Guest'
};
```

**Test Cases Matrix:**
```javascript
const CHECK_IN_TEST_CASES = [
  {
    scenario: 'Valid guest - first check-in',
    input: {zip: '12345', gender: 'woman', dob: '03/15'},
    expected: {ok: true, alreadyCheckedIn: false}
  },
  {
    scenario: 'Valid guest - already checked in',
    input: {zip: '12345', gender: 'woman', dob: '03/15'},
    expected: {ok: true, alreadyCheckedIn: true}
  },
  {
    scenario: 'Invalid ZIP',
    input: {zip: '00000', gender: 'woman', dob: '03/15'},
    expected: {ok: false, message: 'not found'}
  },
  {
    scenario: 'Wrong gender',
    input: {zip: '12345', gender: 'man', dob: '03/15'},
    expected: {ok: false, message: 'not found'}
  },
  {
    scenario: 'Wrong birthday',
    input: {zip: '12345', gender: 'woman', dob: '12/25'},
    expected: {ok: false, message: 'not found'}
  },
  {
    scenario: 'Missing ZIP',
    input: {zip: '', gender: 'woman', dob: '03/15'},
    expected: {ok: false, message: 'Missing required fields'}
  },
  {
    scenario: 'Invalid birthday format',
    input: {zip: '12345', gender: 'woman', dob: '3-15'},
    expected: {ok: false, message: 'Please use MM/DD format'}
  }
];
```

---

## 🎯 Coverage Goals

### Target Coverage Levels

```
✅ Critical Functions: 100% coverage
   - checkInGuest()
   - updateGuestScreenName()
   - uploadGuestPhoto()
   - getWallData()

✅ Important Functions: 80% coverage
   - All connection building functions
   - Data retrieval functions
   - Configuration functions

✅ Utility Functions: 60% coverage
   - Helper functions
   - Formatting functions
   - Display functions
```

---

## 🐛 Debugging Techniques

### Backend Debugging

**1. Logger.log() Strategy:**
```javascript
function myFunction(param1, param2) {
  Logger.log('=== myFunction STARTED ===');
  Logger.log('Input param1:', param1);
  Logger.log('Input param2:', param2);

  const result = someOperation(param1);
  Logger.log('Intermediate result:', result);

  if (!result) {
    Logger.log('ERROR: No result from someOperation');
    return {ok: false, message: 'Operation failed'};
  }

  Logger.log('=== myFunction COMPLETED ===');
  return {ok: true, result: result};
}
```

**2. Step-by-Step Verification:**
```javascript
function testWithSteps() {
  Logger.log('Step 1: Getting sheet...');
  const sheet = getFRCSheet();
  Logger.log('  Sheet name:', sheet.getName());

  Logger.log('Step 2: Getting data...');
  const data = sheet.getDataRange().getValues();
  Logger.log('  Rows:', data.length);

  Logger.log('Step 3: Processing...');
  // ... etc
}
```

**3. Data Inspection:**
```javascript
function inspectData() {
  const sheet = getFRCSheet();
  const data = sheet.getDataRange().getValues();

  Logger.log('=== DATA INSPECTION ===');
  Logger.log('Total rows:', data.length);
  Logger.log('Total columns:', data[0].length);
  Logger.log('\nFirst row (headers):');
  Logger.log(JSON.stringify(data[0], null, 2));
  Logger.log('\nSecond row (first data):');
  Logger.log(JSON.stringify(data[1], null, 2));
}
```

### Frontend Debugging

**1. Console.log() Strategy:**
```javascript
console.log('=== Function Started ===');
console.log('Variables:', {var1, var2, var3});

try {
  const result = someOperation();
  console.log('Success:', result);
} catch (error) {
  console.error('Error:', error);
  console.error('Stack:', error.stack);
}
```

**2. Network Inspection:**
```javascript
// Monitor google.script.run calls
google.script.run
  .withSuccessHandler(function(result) {
    console.log('Backend returned:', result);
    // Process result
  })
  .withFailureHandler(function(error) {
    console.error('Backend error:', error);
    console.error('Error details:', error.message);
  })
  .myFunction(param1, param2);
```

---

## 🧰 Testing Tools

### Built-in Tools

**Apps Script:**
- Execution log (View → Logs)
- Debugger (Debug → Debug function)
- Version history (File → Version history)

**Browser:**
- Console (F12 → Console)
- Network tab (F12 → Network)
- Elements inspector (F12 → Elements)

### Custom Test Utilities

```javascript
/**
 * Utility: Assert equality
 */
function assertEqual(actual, expected, message) {
  if (actual !== expected) {
    throw new Error(
      `Assertion failed: ${message}\n` +
      `  Expected: ${expected}\n` +
      `  Actual: ${actual}`
    );
  }
  Logger.log(`✅ Assert passed: ${message}`);
}

/**
 * Utility: Assert object properties
 */
function assertHasProperty(obj, prop, message) {
  if (!obj.hasOwnProperty(prop)) {
    throw new Error(
      `Assertion failed: ${message}\n` +
      `  Object missing property: ${prop}`
    );
  }
  Logger.log(`✅ Assert passed: ${message}`);
}

/**
 * Utility: Time a function
 */
function timeFunction(fn, name) {
  const start = new Date().getTime();
  const result = fn();
  const end = new Date().getTime();

  Logger.log(`⏱️  ${name} took ${end - start}ms`);
  return result;
}
```

---

## 📊 Test Reporting

### Test Report Template

```javascript
function generateTestReport() {
  const report = {
    timestamp: new Date().toISOString(),
    totalTests: 0,
    passed: 0,
    failed: 0,
    tests: []
  };

  // Run tests and collect results
  const results = runAllRegressionTests();

  report.totalTests = results.total;
  report.passed = results.passedCount;
  report.failed = results.failedCount;
  report.tests = results.results;

  // Log report
  Logger.log('\n=== TEST REPORT ===');
  Logger.log(JSON.stringify(report, null, 2));

  // Optionally: Write to sheet for tracking
  // writeReportToSheet(report);

  return report;
}
```

---

## 🎓 Best Practices

### DO:
- ✅ Test early and often
- ✅ Write failing tests first
- ✅ Test edge cases
- ✅ Test error conditions
- ✅ Keep tests simple and focused
- ✅ Use descriptive test names
- ✅ Clean up test data after tests

### DON'T:
- ❌ Skip tests to save time
- ❌ Test multiple things in one test
- ❌ Use production data for testing
- ❌ Ignore failing tests
- ❌ Write tests after code
- ❌ Deploy with failing tests

---

**Remember: Good tests = Confident deployments = Working system!** 🧪
