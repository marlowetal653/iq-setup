Install the Vercel CLI and set up a Vercel account so the student can deploy apps to the internet.

Steps:

1. Tell the student: "Let's get Vercel set up! Vercel is how we put your app live on the internet — it takes your code and deploys it to a public URL that anyone can visit. We'll install the tool and connect your account."

2. Check if Vercel CLI is already installed:
   ```bash
   vercel --version
   ```
   - If already installed, tell the student: "Vercel CLI is already installed! Let me check if you're logged in too." Then skip to step 4.

3. Install Vercel CLI:
   ```bash
   npm install -g vercel
   ```
   Tell the student: "Installing Vercel CLI — this is the command-line tool that lets us deploy your app with a single command."
   After install, confirm: "Vercel CLI is installed!"

4. Check if already logged in:
   ```bash
   vercel whoami
   ```
   - If this shows a username, tell the student: "You're already logged into Vercel as [username]. You're all set! When you're ready to put your app online, just type /deploy." Then stop here.
   - If not logged in, continue to step 5.

5. Tell the student: "Now let's connect your Vercel account. We'll use your GitHub account to sign up, so no new password needed."

6. Walk the student through creating a Vercel account:
   - Tell them to open **https://vercel.com/signup** in their browser
   - "Click **Continue with GitHub**"
   - "On the GitHub page, click **Authorize Vercel**"
   - "You might be asked about your team — select **Continue with Hobby (free)**"
   - "You should now be on the Vercel dashboard!"

7. Log in to the Vercel CLI. 🔴 This is an INTERACTIVE command — the student needs to run it themselves.

   Detect the OS:
   - **On Mac:** "Open Terminal (Cmd+Space, type 'Terminal', Enter)."
   - **On Windows:** "Open PowerShell (press Windows key, type 'PowerShell', Enter)."

   Give them the command to paste:
   "Copy and paste this into your terminal and press Enter:"
   ```
   vercel login
   ```

   Walk them through what happens:
   - "It will ask how you want to log in — use the arrow keys to select **Continue with GitHub** and press Enter"
   - "Your browser will open — click **Authorize Vercel**"
   - "Go back to your terminal — you should see 'Congratulations! You are now logged in'"

   Tell them: "🔴 Once you see the confirmation message, come back here and tell me."

8. When they confirm, verify it (this command IS non-interactive):
   ```bash
   vercel whoami
   ```

   - If `vercel whoami` shows their username: "Vercel is connected! When you're ready to put your app online, just type /deploy."
   - If not: Walk them through `vercel login` again.
