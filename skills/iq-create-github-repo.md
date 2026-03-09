Create a GitHub repository for the current project and connect it.

Steps:
1. Check if GitHub CLI is authenticated:
   ```bash
   gh auth status
   ```
   - If not authenticated, tell the student: "You're not connected to GitHub yet. Let's fix that."
   - 🔴 INTERACTIVE — tell the student to open their terminal and run `gh auth login`, then walk them through the prompts (select GitHub.com, HTTPS, Login with web browser). Wait for them to confirm before continuing.

2. Check if a git repo already exists in the current directory:
   ```bash
   git rev-parse --is-inside-work-tree 2>/dev/null
   ```
   - If no git repo, initialize one:
     ```bash
     git init
     git add .
     git commit -m "Initial commit"
     ```

3. Check if a GitHub remote already exists:
   ```bash
   git remote get-url origin 2>/dev/null
   ```
   - If a remote already exists, tell the student: "This project is already connected to GitHub at [URL]. You're all set! Run /iq-commit-and-push to save your work." Then stop.

4. Ask the student: "What would you like to name your GitHub repository? (e.g. 'my-app', 'portfolio-site')"

5. Create the repo and connect it:
   ```bash
   gh repo create <name> --private --source=. --remote=origin --push
   ```
   This creates a private repo, sets it as the remote, and pushes the current code.

6. Get the repo URL:
   ```bash
   gh repo view --json url -q .url
   ```

7. Tell the student: "Your GitHub repo is created and your code is uploaded! You can see it at [URL]. From now on, just type /iq-commit-and-push to save your work to GitHub."
