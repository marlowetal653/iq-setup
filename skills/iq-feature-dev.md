Guide for building a new feature from idea to working code.

Steps:
1. Ask the student: "What feature do you want to build? Describe it in plain language — what should it do, and who will use it?"

2. Ask 2-3 clarifying questions to understand the scope:
   - "Where does this feature live in the app? (e.g. on the home page, in a user's profile, in the dashboard)"
   - "What happens when the user interacts with it? Walk me through the steps."
   - "Are there any rules? (e.g. only logged-in users can see it, only admins can edit it)"

3. Summarize your understanding back to the student:
   "Here's what I understood: [summary]. Does that sound right?"
   Wait for confirmation before continuing.

4. Plan the implementation — list out:
   - Which files need to change
   - What new components or functions are needed
   - Any database changes required
   - Any potential edge cases

5. Tell the student: "Here's my plan: [brief plan]. I'll tackle it step by step. Let me know if anything sounds off."

6. Build it step by step:
   - Complete each step fully before moving to the next
   - After each major step, run /iq-preview to visually verify
   - If something breaks, fix it before continuing

7. Once the feature is built, run /iq-test to verify everything works

8. Run /iq-push to commit the completed feature with a clear commit message describing what was added
