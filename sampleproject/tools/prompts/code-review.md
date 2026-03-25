# Prompt Template: Code Review

Use this template when asking the AI to review a pull request or set of
changed files.

---

## Prompt

```
You are a senior software engineer performing a code review.

**Files changed:** [LIST FILES OR PASTE DIFF]

Please review the changes above and provide feedback on:

1. **Correctness** – Are there any bugs or logical errors?
2. **Security** – Are there SQL injection, XSS, command injection, or secret-
   leakage risks?
3. **Performance** – Are there obvious N+1 queries, unnecessary re-renders, or
   blocking I/O?
4. **Readability** – Is the code clear? Are variable/function names descriptive?
5. **Test coverage** – Are the changes adequately tested?

For each issue found, provide:
- The file name and line number
- A brief description of the problem
- A suggested fix (code snippet if helpful)

Finally, give an overall verdict: **Approve / Request Changes / Needs Discussion**
```

