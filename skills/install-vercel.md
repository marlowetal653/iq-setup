Install the Vercel CLI and connect the student's Vercel account so they can deploy apps to the internet.

Steps:

1. Tell the student: "Let's get Vercel set up! Vercel is how we put your app live on the internet — it takes your code and deploys it to a public URL that anyone can visit."

2. Check if Vercel CLI is already installed:
   ```bash
   vercel --version
   ```
   - If already installed, tell the student: "Vercel CLI is already installed! Let me check if you're logged in too." Then skip to step 4.

3. Install Vercel CLI:
   ```bash
   npm install -g vercel
   ```
   Tell the student: "Installing the Vercel CLI — this is the tool that lets us deploy your app with a single command."
   After install, confirm: "Vercel CLI is installed!"

4. Check if already logged in:
   ```bash
   vercel whoami
   ```
   - If this shows a username, tell the student: "You're already logged into Vercel as [username]. You're all set! When you're ready to put your app online, just type /deploy." Then stop here.
   - If not logged in, continue to step 5.

5. Log in to Vercel. This is an INTERACTIVE command — the student needs to run it themselves.

   Detect the OS and tell them which terminal to open:
   - **Mac:** "Open Terminal (Cmd+Space, type 'Terminal', Enter)."
   - **Windows:** "Open PowerShell (press the Windows key, type 'PowerShell', Enter)."

   Give them the command to paste:
   "Copy and paste this into your terminal and press Enter:"
   ```
   vercel login
   ```

   Walk them through what happens:
   - "It will ask how you want to log in — use the arrow keys to select **Continue with GitHub** and press Enter."
   - "Your browser will open to the Vercel site."
   - "If you already have a Vercel account, just authorize and you're done."
   - "If you don't have an account yet, no worries — Vercel will create one for you automatically when you sign in with GitHub. Just click **Authorize Vercel** and follow the prompts."
   - "Once it's done, go back to your terminal — you should see a confirmation message like 'Congratulations! You are now logged in.'"
   - "Come back here and let me know once you see that message."

6. When they confirm, verify the login:
   ```bash
   vercel whoami
   ```

   - If it shows their username: "You're connected to Vercel! When you're ready to put your app online, just type /deploy."
   - If it doesn't work: Walk them through `vercel login` again, checking for errors.

7. 🔴 **Important note about environment variables.**

   Tell the student:

   "One thing to know: when you run **/deploy**, I will automatically copy all your secret keys from your local `.env` file (the one with your Supabase keys, API keys, etc.) up to the Vercel project I create for you. Without this, your live app would break — it wouldn't be able to talk to your database. So this is a non-negotiable step in the deploy flow.

   You don't need to do anything for this — just make sure your `.env` file in your project is up to date before you deploy."

   This is a contract: the `/deploy` flow MUST sync `.env` to Vercel every time. If a future version of `/deploy` skips this, it's a bug.
