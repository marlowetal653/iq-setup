Deploy the app to the internet using Vercel so anyone can access it.

Steps:
1. First, make sure all work is saved (run /iq-commit-and-push if there are uncommitted changes)

2. Read the Vercel deploy skill at `~/.claude/skills/deploy-to-vercel/SKILL.md` and follow its deployment flow.

3. **If the Vercel CLI is not installed or the student is not authenticated** (i.e. the SKILL.md flow reaches the "Not linked + CLI not authenticated" path), use this beginner-friendly walkthrough instead of just running `vercel login`:

   a. Install the CLI:
      ```bash
      npm install -g vercel
      ```
      Tell the student: "Installing Vercel — this is what puts your app live on the internet."

   b. Walk the student through creating a Vercel account:
      - Tell them to open **https://vercel.com/signup** in their browser
      - "Click **Continue with GitHub**"
      - "On the GitHub page, click **Authorize Vercel**"
      - "You might be asked about your team — select **Continue with Hobby (free)**"
      - "You should now be on the Vercel dashboard!"

   c. Log in to the CLI. 🔴 This is an INTERACTIVE command — the student needs to run it themselves.
      - **On Mac:** "Open Terminal (Cmd+Space, type 'Terminal', Enter)."
      - **On Windows:** "Open PowerShell (press Windows key, type 'PowerShell', Enter)."
      - "Copy and paste this into your terminal and press Enter:"
        ```
        vercel login
        ```
      - "It will ask how you want to log in — select **Continue with GitHub** and press Enter"
      - "Your browser will open — click **Authorize Vercel**"
      - "Go back to your terminal — you should see 'Congratulations! You are now logged in'"
      - "🔴 Once you see the confirmation message, come back here and tell me."

   d. When they confirm, verify: `vercel whoami`

   e. Then continue with the SKILL.md linking and deploy steps.

4. After deployment, give the student their live URL
5. Open the live URL in the browser: `open <URL>` (Mac) or `start <URL>` (Windows)
6. Tell the student: "Your app is now live on the internet! Anyone with this link can use it."
