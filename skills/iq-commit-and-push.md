Build (if possible), commit, and push your work to GitHub.

Steps:
1. Run `git status` to see what changed
2. If there's no git repo or no GitHub remote, tell the student: "You don't have a GitHub repo set up yet. Run /iq-create-github-repo first, then come back and run /iq-commit-and-push again." Then stop.
3. If nothing changed, tell the student: "Nothing new to push — your work is already up to date."
4. Run the build — this is mandatory, never skip it:
   - Run: `npm run build`
   - If the build fails, read the errors, fix them, and run the build again. Keep fixing until it succeeds. Do NOT continue to commit/push until the build passes.
   - Tell the student: "Build passed!"
5. Stage all changes: `git add .`
6. Look at the diff to understand what changed
7. Auto-generate a clear, descriptive commit message based on the changes (no "Co-Authored-By" tags)
8. Commit the changes
9. Push to GitHub: `git push` (use `git push -u origin main` if this is the first push)
10. Tell the student: "Your work is saved and backed up to GitHub. Run /iq-deploy-to-vercel when you're ready to put it live on the internet."
11. Provide a link to their repo on GitHub so they can see it
