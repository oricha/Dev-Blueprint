# Skill: /test

Invoke this skill with `/test` to run the full test suite, fix any failures,
and produce a clear summary of results.

---

## Steps

1. **Ensure the build is passing first**
   - Run `/build` if there is any doubt.

2. **Run the full test suite**
   ```bash
   npm test
   ```

3. **Evaluate results**
   - If **all tests pass** → proceed to step 5.
   - If **tests fail** → proceed to step 4.

4. **Fix failing tests** (iterate until resolved)
   - Read each failing test name and assertion carefully.
   - Determine whether the **implementation** or the **test** is wrong:
     - If the implementation is wrong → fix the source code.
     - If the test expectation is outdated → update the test with a comment
       explaining why.
   - Re-run `npm test` after each fix.
   - Do NOT mock away real behaviour to make tests pass artificially.

5. **Run coverage report** (if available)
   ```bash
   npm run test:coverage --if-present
   ```

6. **Report**
   - Total tests: passed / failed / skipped.
   - List any tests you fixed and what the root cause was.
   - Note any coverage regressions.

---

## Notes for the Agent

- Prefer fixing the root cause over patching individual test assertions.
- Never delete a test to make the suite pass.
- If a test requires a running database or external service, note this in the
  report and advise the user to run the dependency first.

