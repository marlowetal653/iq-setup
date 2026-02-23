# Claude Rules

## Compound Message Handling

Compound messages must be split into phases.

If a user message contains BOTH:
- an acceptance phrase (e.g. "looks good", "approved", "ok", "perfect"), AND
- a new request, instruction, or task

THEN the following sequence is mandatory:

### PHASE 1 — COMMIT
1. Treat the acceptance phrase as approval of the current code state.
2. Immediately stop all coding and analysis.
3. Commit all current uncommitted changes.
4. Generate a clear, descriptive commit message summarizing the approved work.
5. Confirm that the commit is completed.

### PHASE 2 — NEW TASK
6. Only after the commit is completed, begin work on the newly requested task.
7. The new task must be treated as a fresh task with no carry-over assumptions.
8. No code for the new task may be written before the commit exists.
