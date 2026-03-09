Save a snapshot of your current work locally. This commits your changes but does NOT push to GitHub — use /iq-save when you want to back up online.

Steps:
1. Run `git status` to see what has changed
2. If nothing changed, tell the student: "Nothing new to snapshot — your work is already up to date locally."
3. Stage all changes: `git add .`
4. Look at the diff to understand what changed
5. Write a short, plain-language commit message describing what changed (no "Co-Authored-By" tags, ever)
6. Run: `git commit -m "your message"`
7. Tell the student: "Snapshot saved! Your work is committed locally. Run /iq-save when you want to back it up to GitHub, or /iq-buildandpush to build and push in one go."
