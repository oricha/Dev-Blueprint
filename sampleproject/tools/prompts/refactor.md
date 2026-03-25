# Prompt Template: Refactor

Use this template when asking the AI to refactor an existing module.

---

## Prompt

```
Refactor the following code in [FILE PATH].

Goals:
1. Improve readability without changing external behaviour.
2. Remove duplication — extract repeated logic into shared helpers only when
   it is used in 3+ places.
3. Simplify overly complex conditionals.
4. Do NOT add new features, error handling, or abstractions that aren't needed
   by the current code.

After refactoring:
- Show the full updated file.
- Briefly explain each change and why it improves the code.
- Confirm that no behaviour was changed.
```

