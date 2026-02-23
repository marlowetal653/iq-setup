Run a comprehensive test suite on what was just built. Leave no stone unturned.

## Test Data Bank
When filling forms or creating test data, always use values from this bank. Pick the appropriate field.

| Field | Value |
|---|---|
| **Email** | `test@e2etest.com` |
| **Password** | `TestPassword123!` |
| **First name** | `Test` |
| **Last name** | `Student` |
| **Full name** | `Test Student` |
| **Phone** | `+33 6 12 34 56 78` |
| **Address line 1** | `42 Rue de Rivoli` |
| **Address line 2** | `Apt 7B` |
| **City** | `Paris` |
| **State / Region** | `Ile-de-France` |
| **Zip / Postal code** | `75001` |
| **Country** | `France` |
| **Company** | `Test Company` |
| **Job title** | `Developer` |
| **Website** | `https://example.com` |
| **Date of birth** | `1990-03-15` |
| **Username** | `test_student` |
| **Credit card** | Never enter real or fake card numbers — skip or flag |
| **SSN / ID** | Never enter — skip or flag |

For **edge-case testing**, also try:
- Empty strings / whitespace only
- Very long strings (300+ chars)
- Special characters: `e a u n o ae`
- SQL-ish strings: `'; DROP TABLE users; --`
- Script tags: `<script>alert('xss')</script>`
- Negative numbers, zero, huge numbers
- Future dates, past dates, Feb 29

## Phase 1 — Static Analysis
1. Check for a linter config (eslint, biome, etc.) and run the linter. Fix any issues found.
2. Check for TypeScript and run `tsc --noEmit` if applicable. Fix any type errors.

## Phase 2 — Unit / Integration Tests
3. Check for an existing test framework (vitest, jest, etc.) in `package.json`.
4. If tests exist, run them. If they don't exist yet, **write them** for the code that was just changed or added:
   - Look at recent git changes (`git diff HEAD~1` or `git diff main`) to identify what was built
   - Write tests covering **all edge cases**: empty states, boundary values, invalid inputs, weird combinations of selections
   - For forms: test every combination of field values, required vs optional, validation rules, error states
   - For API/DB interactions: test that data is correctly saved, updated, deleted
   - Test both happy paths and error paths
5. Run all tests and fix any failures.

## Phase 3 — Database & RLS (if Supabase is used)
6. Check if the project uses Supabase (look for supabase client, `.env` files, etc.)
7. If yes:
   - List the tables involved in the recent changes
   - Verify RLS policies exist on those tables — flag any table with RLS enabled but missing policies, or with policies that might block legitimate operations
   - Run test queries to confirm CRUD operations work as expected and aren't silently blocked by RLS
   - Check for missing indexes on frequently queried columns
   - Run `get_advisors` for security and performance checks

## Phase 4 — E2E / Playwright Browser Testing
8. Read `package.json` to find the dev/start script
9. Start the dev server in the background
10. Wait for the server to be ready and extract the local URL
11. Open the app in an **incognito/private browser context** (use `browser_run_code` to create an incognito context if needed)
12. **Create a test account** (or log in if it already exists) with these credentials:
    - Email: `test@e2etest.com`
    - Password: `TestPassword123!`
13. Test the actual feature that was just built end-to-end:
    - Identify what was recently changed from git history
    - Walk through every user flow related to that feature
    - For forms: fill and submit with valid data, then with invalid data, then with edge-case data (empty strings, very long strings, special characters, etc.)
    - For interactive UI: click every button, toggle every option, test every combination of states
    - For lists/tables: test with zero items, one item, many items
    - Check for console errors after each interaction
    - Take screenshots at key moments
14. Test responsive behavior if relevant (resize viewport and re-test critical flows)

## Phase 5 — Report
15. Compile a full test report:
    - What passed
    - What failed (with details and screenshots)
    - Warnings (missing tests, potential issues, RLS concerns)
    - Suggested fixes for any failures
16. Fix all critical failures and re-run until green.
