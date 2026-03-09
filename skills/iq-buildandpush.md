Build the project to make sure everything compiles, then commit and push to GitHub.

Steps:
1. First, make sure there are no obvious code errors by running the build:
   - Check `package.json` for a "build" script
   - Run: `npm run build`
2. If the build fails:
   - Read the error output carefully
   - Fix the errors
   - Run the build again
   - Only continue once the build succeeds
3. Tell the student: "Build passed! Now saving and pushing your work to GitHub."
4. Stage all changes: `git add .`
5. Look at the diff to understand what changed
6. Write a short, plain-language commit message (no "Co-Authored-By" tags)
7. Commit: `git commit -m "your message"`
8. Push to GitHub: `git push` (use `git push -u origin main` if this is the first push)
9. Tell the student: "Your app built successfully and is backed up to GitHub. Run /iq-deploy-to-vercel when you're ready to put it live on the internet."
