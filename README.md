# IQ Setup — Instructions for Claude

> **What is this?** This file contains setup instructions that Claude Code
> reads and executes. A student pastes a one-line prompt into Claude Code,
> Claude fetches this file, and walks the student through full environment
> setup. If you're a human reading this, see [docs/HUMAN_README.md](docs/HUMAN_README.md).

---

## RULES FOR CLAUDE

Before you begin, follow these rules throughout the entire setup:

1. **Talk constantly.** Before each step, tell the student what you're about to do and why. After each step, tell them what you just did and what's coming next. Never go silent for more than one action.
2. **Be idempotent.** Before installing anything, check if it's already installed. If it is, skip it and say so.
3. **Narrate installs.** Before every install command, explain what the tool does in one plain sentence. Example: "I'm about to install Git — this tracks every change you make to your code, like version history in Google Docs."
4. **Handle errors gracefully.** If something fails, explain what went wrong in plain language and suggest a fix.
5. **One step at a time.** Do not rush. Complete each phase fully before moving to the next.
6. **Supports macOS and Windows.** Detect the OS in Phase 1 and follow the correct instructions for each platform throughout.
7. **Be encouraging.** These are beginners. Celebrate small wins. Never make them feel dumb. Use phrases like "Great!" and "You're doing amazing — this is the hard part, it gets easier from here."
8. **🔴 Never run interactive commands.** Some commands need the student to type, select options, or enter passwords. You CANNOT do this for them — Claude Code's terminal doesn't support interactive input. For these commands, tell the student to open their own terminal app and type the command themselves. On Mac: **Terminal** (Cmd+Space, type "Terminal", press Enter). On Windows: **PowerShell** (press Windows key, type "PowerShell", press Enter). Walk them through every prompt they'll see. Wait for them to tell you they're done before continuing.
9. **🔴 Use red circle emoji for critical warnings.** When telling the student something they MUST NOT miss — passwords, one-time tokens, restart requirements, interactive commands — start that message with 🔴. This makes it visually impossible to miss.

---

## Phase 0 — Welcome

Before doing anything else, greet the student warmly. Say:

"👋 Hey! Welcome to IQ Setup — I'm Claude, your AI coding assistant.

Here's what we're going to do together today:

1. **Check your computer** — figure out what you're working with
2. **Install developer tools** — Git, Node.js, Supabase, GitHub CLI, Vercel, and more
3. **Install custom commands** — shortcuts that let you build, save, and deploy with one word
4. **Set up your accounts** — GitHub, Supabase, and Vercel (we'll do it step by step)
5. **Connect everything to Claude** — so I can manage your database and browser directly
6. **Connect your existing project** (if you have one on Bolt or Lovable)

The whole thing takes about 15–20 minutes. I'll guide you through every step and explain everything as we go.

⚠️ **One important thing before we start:** Please read everything I write carefully. At certain points I'll ask you to open your Terminal, type a command, or click something in your browser — if you miss those instructions, the setup will get stuck. I'll always be clear about what you need to do, but you have to follow along with me.

**Ready to start?** Just say 'yes' or 'let's go' and we'll begin! 🚀"

Wait for the student to confirm before continuing to Phase 1.

---

## Phase 1 — System Check

Detect the student's operating system:
```bash
uname -s 2>/dev/null || echo "WINDOWS"
```

- If the output is `Darwin` → this is **macOS**. Also run `uname -m` to detect architecture:
  - `arm64` = Apple Silicon (M1/M2/M3/M4) — Homebrew installs to `/opt/homebrew/`
  - `x86_64` = Intel Mac — Homebrew installs to `/usr/local/`
- If the output is `WINDOWS` or `MINGW` or `MSYS` or the command fails → this is **Windows**.
- If the output is `Linux` → stop and tell them: "This setup currently supports Mac and Windows. Linux support is coming soon."

Remember the OS and architecture — follow the correct instructions for this platform in every phase below.

Tell the student: "Your computer is ready. Let's start installing the tools you need."

---

## Phase 2 — Install Package Manager

### On macOS — Install Homebrew

Check if Homebrew is installed:
```bash
which brew
```

**If NOT installed:**

1. Tell the student: "I need to install Homebrew. It's like an app store for developer tools — it's the standard way to install things on a Mac. It's safe and used by millions of developers."

2. 🔴 INTERACTIVE INSTALL — You cannot run this yourself. Tell the student to open their **Terminal** app:
   "🔴 I need you to open the Terminal app on your Mac. Press Cmd+Space, type 'Terminal', and press Enter. Let me know when you can see a black or white window with a command prompt."

3. Once they confirm Terminal is open, give them the command to paste:
   "Copy and paste this command into Terminal, then press Enter:"
   ```
   NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. Warn them about the password prompt:
   "🔴 Your Mac will ask for your password. This is your normal computer login password. When you type it, you won't see any dots or stars — that's completely normal and intentional. Just type it and press Enter."

5. Tell them to let you know when they see "Installation successful!" or similar.
   Wait for them to confirm before continuing.

6. 🔴 CRITICAL PATH SETUP — After install, Homebrew needs to be added to your Mac's PATH or it won't work.
   Tell the student: "🔴 One more thing before we continue — I need you to paste one more command into Terminal."
   On Apple Silicon Macs (arm64):
   ```
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```
   On Intel Macs (x86_64): No action needed — tell them: "You're on an Intel Mac, so you can skip this step."

7. If the install triggered a popup asking to install "Xcode Command Line Tools":
   Tell the student: "A popup appeared asking to install developer tools. Click 'Install' and wait — it can take 5-10 minutes. Let me know when it's done."
   Wait for them to confirm, then have them retry the Homebrew install command.

8. Once they confirm it's done, come back to Claude Code and verify yourself:
   `brew --version`

**If already installed:**
- Tell the student: "Homebrew is already installed. Skipping."
- Run `brew update` to make sure it's current.

### On Windows — Verify winget

Windows 11 comes with `winget` pre-installed. Verify it works:
```bash
winget --version
```

If it works: "Your package manager is ready."
If it fails: Tell the student "winget should be pre-installed on Windows 11. Let's install it." Then have them open the **Microsoft Store** app and search for **App Installer** — install or update it.

---

## Phase 3 — Install Developer Tools

Tell the student: "Now I'm going to install the developer tools you need. I'll explain what each one does as I go. This part is automatic — you just watch."

For each tool below, check if it's already installed before installing.

### 3a — Git

Tell the student: "First up: Git. Think of it like version history for your code — every time you save, Git takes a snapshot you can go back to. It's what powers the /save command you'll use every day."

Check: `git --version`

**On Mac** — if not installed: `brew install git`
**On Windows** — if not installed:
```bash
winget install Git.Git --accept-package-agreements --accept-source-agreements
```

After install: "Git is ready!"

### 3b — Node.js

Tell the student: "Next: Node.js. This is the engine that actually runs your web app's code. Without it, your app can't run on your computer."

Check: `node --version`

**On Mac** — if not installed: `brew install node`
**On Windows** — if not installed:
```bash
winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements
```

After install, verify npm: `npm --version`
Tell them: "Node.js and npm are ready! npm is Node's built-in app store — it downloads code packages your app needs."

### 3c — Supabase CLI

Tell the student: "Now: Supabase CLI. Supabase is your database — it stores everything your app needs to remember, like users, content, and settings. This CLI lets me manage it for you from the command line."

Check: `supabase --version`

**On Mac** — if not installed: `brew install supabase/tap/supabase`
**On Windows** — if not installed:
```bash
npm install -g supabase
```

After install: "Supabase CLI is ready!"

### 3d — GitHub CLI

Tell the student: "Next: GitHub CLI. GitHub is like Google Drive for code — it's where your code lives online so it's never lost. This CLI lets me connect to it and push your code up automatically."

Check: `gh --version`

**On Mac** — if not installed: `brew install gh`
**On Windows** — if not installed:
```bash
winget install GitHub.cli --accept-package-agreements --accept-source-agreements
```

After install: "GitHub CLI is ready!"

### 3e — Claude Code CLI

Tell the student: "Now installing the Claude Code CLI. This lets you launch me from any terminal window — not just the desktop app."

Check: `claude --version`

If not installed (on both Mac and Windows):
```bash
npm install -g @anthropic-ai/claude-code
```

After install: "Claude Code CLI is ready!"

### 3f — Vercel CLI

Tell the student: "Last tool: Vercel CLI. Vercel is how we put your app live on the internet — it takes your code and deploys it to a public URL that anyone can visit."

Check: `vercel --version`

If not installed (on both Mac and Windows):
```bash
npm install -g vercel
```

After install: "Vercel CLI is ready!"

After all tools are installed, tell the student:
"All developer tools are installed — great work getting through this part! Here's the toolkit you now have:
- ✅ Git — tracks every change to your code
- ✅ Node.js — runs your web app
- ✅ Supabase CLI — manages your database
- ✅ GitHub CLI — connects your code to GitHub
- ✅ Claude Code CLI — launches me from any terminal
- ✅ Vercel CLI — deploys your app to the internet

Now let's install some custom commands that will make your life much easier."

---

## Phase 4 — Install Skills and Rules

### 4a — Clone this repository

```bash
git clone https://github.com/marlowetal653/iq-setup.git /tmp/iq-setup
```

On Windows, if `/tmp/` doesn't work, use:
```bash
git clone https://github.com/marlowetal653/iq-setup.git %TEMP%\iq-setup
```

### 4b — Install skill files

Create the commands directory if it doesn't exist:
```bash
mkdir -p ~/.claude/commands
```

Copy each skill file. For each one, check if it already exists first. If it does, ask the student: "You already have a [name] command. Should I update it with the latest version?"

```bash
cp /tmp/iq-setup/skills/preview.md ~/.claude/commands/preview.md
cp /tmp/iq-setup/skills/test.md ~/.claude/commands/test.md
cp /tmp/iq-setup/skills/master.md ~/.claude/commands/master.md
cp /tmp/iq-setup/skills/save.md ~/.claude/commands/save.md
cp /tmp/iq-setup/skills/sync.md ~/.claude/commands/sync.md
cp /tmp/iq-setup/skills/deploy.md ~/.claude/commands/deploy.md
cp /tmp/iq-setup/skills/commit.md ~/.claude/commands/commit.md
cp /tmp/iq-setup/skills/buildandpush.md ~/.claude/commands/buildandpush.md
cp /tmp/iq-setup/skills/install-bmad.md ~/.claude/commands/install-bmad.md
cp /tmp/iq-setup/skills/feature-dev.md ~/.claude/commands/feature-dev.md
cp /tmp/iq-setup/skills/frontend-design.md ~/.claude/commands/frontend-design.md
```

On Windows, use `copy` if `cp` doesn't work:
```bash
copy %TEMP%\iq-setup\skills\preview.md %USERPROFILE%\.claude\commands\preview.md
```
(Repeat for each file)

### 4c — Install global Claude rules

Check if `~/.claude/CLAUDE.md` already exists.

If it does NOT exist:
```bash
cp /tmp/iq-setup/config/CLAUDE.md ~/.claude/CLAUDE.md
```

If it DOES exist, append the new rules:
```bash
echo "" >> ~/.claude/CLAUDE.md
echo "---" >> ~/.claude/CLAUDE.md
echo "" >> ~/.claude/CLAUDE.md
cat /tmp/iq-setup/config/CLAUDE.md >> ~/.claude/CLAUDE.md
```

### 4d — Clean up

**On Mac:**
```bash
rm -rf /tmp/iq-setup
```

**On Windows:**
```bash
rmdir /s /q %TEMP%\iq-setup
```

### 4e — Tell the student what they got

Tell them:
"I've installed 11 custom commands you can use anytime:

**Build & Save:**
- **/commit** — Take a quick local snapshot (no push)
- **/save** — Save your work and back it up to GitHub
- **/buildandpush** — Build, then save and push in one go

**Run & Deploy:**
- **/preview** — Start your app and open it in your browser
- **/deploy** — Put your app live on the internet (Vercel)

**Plan & Build:**
- **/master** — Build your app specification step by step (start here!)
- **/feature-dev** — Guided workflow for building a new feature
- **/frontend-design** — Improve the look and feel of your app

**Maintain:**
- **/test** — Run a full test suite to check everything works
- **/sync** — Get the latest version of your code
- **/install-bmad** — Install the BMAD AI agent framework (advanced)

I also installed some rules that make me smarter and more consistent."

---

## Phase 5 — Set Permissions to Auto-Accept

Claude Code normally asks for permission before running commands. For students, this is
confusing and unnecessary — they don't know what they're approving anyway.

### On macOS

```bash
# Check if alias already exists
if grep -q 'dangerously-skip-permissions' ~/.zshrc 2>/dev/null; then
    echo "SKIP: Permission alias already configured."
else
    echo '' >> ~/.zshrc
    echo '# Claude Code: auto-accept all permissions (set by IQ Setup)' >> ~/.zshrc
    echo 'alias claude="claude --dangerously-skip-permissions"' >> ~/.zshrc
    echo "SUCCESS: Claude will now auto-accept permissions."
fi
```

Then reload the shell config:
```bash
source ~/.zshrc
```

### On Windows

Tell the student to open **PowerShell** and paste:
```
if (!(Test-Path $PROFILE)) { New-Item -Path $PROFILE -Force }
Add-Content $PROFILE 'Set-Alias claude "claude --dangerously-skip-permissions"'
```

Note: If the PowerShell alias approach doesn't work reliably on Windows, an alternative
is to tell the student to always launch Claude Code with:
```
claude --dangerously-skip-permissions
```

Tell the student: "I've configured Claude to run smoothly without asking you
technical permission questions. This makes your experience much simpler."

---

## Phase 6 — Configure MCP Servers

MCP servers give Claude extra capabilities. We need to configure them in `~/.claude.json`.

### 6a — Add Playwright MCP (no authentication needed)

Use python3 (or python on Windows) to safely modify the JSON config:

```bash
python3 << 'PYEOF'
import json, os

config_path = os.path.expanduser("~/.claude.json")

# Read existing config or start fresh
if os.path.exists(config_path):
    with open(config_path, "r") as f:
        config = json.load(f)
else:
    config = {}

# Ensure mcpServers key exists
if "mcpServers" not in config:
    config["mcpServers"] = {}

# Add Playwright if not already present
if "playwright" not in config["mcpServers"]:
    config["mcpServers"]["playwright"] = {
        "type": "stdio",
        "command": "npx",
        "args": ["-y", "@playwright/mcp@latest"],
        "env": {}
    }
    print("SUCCESS: Playwright MCP server added.")
else:
    print("SKIP: Playwright MCP server already configured.")

# Write back
with open(config_path, "w") as f:
    json.dump(config, f, indent=2)
    f.write("\n")

PYEOF
```

On Windows, if `python3` is not found, try `python` instead.
If neither works, install Python: `winget install Python.Python.3 --accept-package-agreements --accept-source-agreements`

### 6b — Set MCP Tool Permissions to Auto-Allow

So Claude never prompts the student for permission when using MCP tools, pre-approve all MCP tools in `~/.claude/settings.json`:

```bash
python3 << 'PYEOF'
import json, os

settings_dir = os.path.expanduser("~/.claude")
settings_path = os.path.join(settings_dir, "settings.json")

# Create ~/.claude/ directory if it doesn't exist
os.makedirs(settings_dir, exist_ok=True)

# Read existing settings or start fresh
if os.path.exists(settings_path):
    with open(settings_path, "r") as f:
        settings = json.load(f)
else:
    settings = {}

# Ensure permissions structure exists
if "permissions" not in settings:
    settings["permissions"] = {}
if "allow" not in settings["permissions"]:
    settings["permissions"]["allow"] = []

# Add MCP permissions if not already present
mcp_permissions = ["mcp__playwright__*", "mcp__supabase__*"]
added = []
for perm in mcp_permissions:
    if perm not in settings["permissions"]["allow"]:
        settings["permissions"]["allow"].append(perm)
        added.append(perm)

# Write back
with open(settings_path, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")

if added:
    print(f"SUCCESS: MCP permissions added: {', '.join(added)}")
else:
    print("SKIP: MCP permissions already configured.")

PYEOF
```

On Windows, use `python` instead of `python3` if needed.

Tell the student: "I've configured the Playwright browser testing tool and set all permissions to auto-allow. This means I can use my tools without interrupting you to ask for approval."

### 6c — Supabase MCP (needs token — configured later)

Do NOT add the Supabase MCP server yet. We need the student's access token first. We'll come back to this in Phase 8 after account setup.

Tell the student: "We'll connect the Supabase database tool after we create your account in the next step."

---

## Phase 7 — Account Setup

Walk the student through creating their accounts. Be extremely specific about what to click and what to type — these are non-technical people.

### Step 7a — GitHub Account

Ask the student: "Do you already have a GitHub account?"

**If NO:**
1. Tell them: "Let's create a GitHub account. GitHub is where your code will live online — think of it as Google Drive for code."
2. Tell them to open **https://github.com/signup** in their browser.
3. Walk them through each step:
   - "Enter your email address and click Continue"
   - "Create a password — make it at least 15 characters, or 8 characters with a number and a lowercase letter. Click Continue"
   - "Choose a username — I suggest something like your first name + last initial (e.g. 'marlower'). Click Continue"
   - "Type 'n' for the email preferences question and click Continue"
   - "Complete the little verification puzzle"
   - "Click 'Create account'"
   - "Check your email for a verification code — a 6-digit number. Enter it on the page"
4. Once verified: "Your GitHub account is ready!"

**If YES:**
- Tell them: "Great! Make sure you're logged in at github.com."

### Step 7b — Connect GitHub to Claude Code

🔴 INTERACTIVE COMMAND — Do NOT run `gh auth login` yourself — it will hang waiting for input you can't provide.

Tell the student: "🔴 Now let's connect your GitHub account to Claude Code. This step requires you to type a command yourself in your Terminal."

1. Tell them to open their terminal app (if not already open):
   **On Mac:** "Open Terminal (Cmd+Space, type 'Terminal', Enter)."
   **On Windows:** "Open PowerShell (press the Windows key, type 'PowerShell', Enter)."

2. Give them the exact command to paste:
   "Copy and paste this into your terminal and press Enter:"
   ```
   gh auth login
   ```

3. Walk them through each prompt they'll see:
   - "It will ask 'Where do you use GitHub?' — use the arrow keys to select **GitHub.com** and press Enter"
   - "It will ask about protocol — select **HTTPS** and press Enter"
   - "It will ask how to authenticate — select **Login with a web browser** and press Enter"
   - "It will show you a one-time code (something like ABC1-D2EF) — write it down or remember it"
   - "Press Enter — your browser will open"
   - "In the browser, paste or type the code and click **Authorize github**"
   - "Go back to your terminal — you should see 'Logged in as [your username]'"

4. Tell them: "Once you see 'Logged in as...', come back here and tell me."

5. When they confirm, verify it yourself (this command IS non-interactive):
```bash
gh auth status
```

If `gh auth status` shows they're logged in: "GitHub is connected! Now let's set up your database."
If not: Walk them through the `gh auth login` process again.

### Step 7c — Create Supabase Account

Tell the student: "Now let's create your Supabase account. Supabase is your database — it stores all the data for your app (users, content, settings). We'll use your GitHub account to log in, so you don't need another password."

1. Tell them to open **https://supabase.com/dashboard** in their browser
2. "Click **Sign In** at the top right"
3. "Click **Continue with GitHub**"
4. "On the GitHub page, click **Authorize supabase**"
5. "You should now be on the Supabase dashboard!"

### Step 7d — Create Supabase Organization and Project

Tell the student: "Now we need to create your workspace in Supabase."

1. "You might be asked to create an organization. If so:"
   - "For the name, use your company name or your own name"
   - "For the plan, select **Free**"
   - "Click **Create organization**"

2. "Now let's create a project:"
   - "Click **New project**"
   - "For the project name, you can use 'my-first-app' or the name of your app idea"
   - "For the database password, click **Generate a password**"
   - "IMPORTANT: Copy this password and save it somewhere safe (like in your Notes app). You'll need it later."
   - "For the region, pick the one closest to where you are (e.g. West EU for Paris, East US for New York)"
   - "Click **Create new project**"

3. "Wait for the project to finish setting up — you'll see a progress bar. This takes about 1-2 minutes."

Tell them: "Your database is being created! While it loads, let's get the special key that lets me talk to your database."

### Step 7e — Get Supabase Access Token

Tell the student: "We need to create an access token — this is a special key that lets Claude Code manage your database directly."

1. "Open this link in your browser: **https://supabase.com/dashboard/account/tokens**"
2. "Click **Generate new token**"
3. "For the name, type **Claude Code**"
4. "Click **Generate token**"
5. "🔴 You'll see a long string of text that starts with 'sbp_'. Click the copy button next to it RIGHT NOW."
6. "🔴 This is the ONLY time Supabase will show you this token. If you close the page without copying it, you'll have to create a new one."
7. "Paste the token here in our chat."

Wait for them to paste the token. It should start with `sbp_`.

If what they pasted doesn't start with `sbp_`:
- Tell them: "That doesn't look right — the token should start with 'sbp_'. Can you try copying it again from the Supabase page?"

### Step 7f — Create Vercel Account and Log In

Tell the student: "Now let's set up Vercel — this is the service that will put your app live on the internet. We'll use your GitHub account to sign up, so no new password needed."

1. Tell them to open **https://vercel.com/signup** in their browser
2. "Click **Continue with GitHub**"
3. "On the GitHub page, click **Authorize Vercel**"
4. "You might be asked about your team — select **Continue with Hobby (free)**"
5. "You should now be on the Vercel dashboard!"

Now log in to the Vercel CLI. 🔴 This is an INTERACTIVE command — the student needs to run it themselves.

6. Tell them to go back to their terminal app (the same one they used for `gh auth login`):
   **On Mac:** "Go back to Terminal (or open it again: Cmd+Space, type 'Terminal', Enter)."
   **On Windows:** "Go back to PowerShell (or open it again: Windows key, type 'PowerShell', Enter)."

7. Give them the command to paste:
   "Copy and paste this into your terminal and press Enter:"
   ```
   vercel login
   ```

8. Walk them through what happens:
   - "It will ask how you want to log in — use the arrow keys to select **Continue with GitHub** and press Enter"
   - "Your browser will open — click **Authorize Vercel**"
   - "Go back to your terminal — you should see 'Congratulations! You are now logged in'"

9. Tell them: "🔴 Once you see the confirmation message, come back here and tell me."

10. When they confirm, verify it yourself (this command IS non-interactive):
```bash
vercel whoami
```

If `vercel whoami` shows their username: "Vercel is connected! When you're ready to put your app online, just type /deploy."
If not: Walk them through `vercel login` again.

---

## Phase 8 — Connect Supabase to Claude

Now that we have the student's Supabase access token, add the Supabase MCP server to `~/.claude.json`.

Take the token the student pasted and use it in this script. Replace `TOKEN_HERE` with the actual token:

```bash
python3 << 'PYEOF'
import json, os

token = "TOKEN_HERE"  # Claude: replace TOKEN_HERE with the actual token the student pasted
token = token.strip().strip('"').strip("'")  # Clean up whitespace/quotes

config_path = os.path.expanduser("~/.claude.json")

with open(config_path, "r") as f:
    config = json.load(f)

if "mcpServers" not in config:
    config["mcpServers"] = {}

config["mcpServers"]["supabase"] = {
    "type": "stdio",
    "command": "npx",
    "args": [
        "-y",
        "@supabase/mcp-server-supabase@latest",
        "--access-token",
        token
    ],
    "env": {}
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)
    f.write("\n")

print("SUCCESS: Supabase MCP server configured with access token.")
PYEOF
```

On Windows, use `python` instead of `python3` if needed.

🔴 IMPORTANT: After adding the MCP server, Claude needs to restart to pick up the new configuration.

Tell the student:
"🔴 I've connected your Supabase account to Claude Code! For this to take effect, you need to restart Claude Code:

1. Close this Claude Code window completely
   **On Mac:** Cmd+Q or type 'exit'
   **On Windows:** close the window or type 'exit'
2. Open Claude Code again
3. Start a new conversation

After you restart, I'll be able to manage your database directly."

Do NOT try to test the Supabase MCP connection in the current session — it won't be available until after restart.

---

## Phase 9 — Verification Checklist

Run through this checklist and report results to the student:

```bash
echo "=== Setup Verification ==="
echo "Git: $(git --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "Node.js: $(node --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "npm: $(npm --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "Supabase CLI: $(supabase --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "GitHub CLI: $(gh --version 2>/dev/null | head -1 || echo 'NOT INSTALLED')"
echo "Vercel CLI: $(vercel --version 2>/dev/null || echo 'NOT INSTALLED')"
```

On macOS, also check:
```bash
echo "Homebrew: $(brew --version 2>/dev/null | head -1 || echo 'NOT INSTALLED')"
```

Then check GitHub connection and Claude config:
```bash
echo ""
echo "=== GitHub Connection ==="
gh auth status 2>&1 | head -3
echo ""
echo "=== Claude Skills ==="
ls -1 ~/.claude/commands/ 2>/dev/null || echo "No commands directory"
echo ""
echo "=== MCP Servers ==="
python3 -c "
import json, os
config_path = os.path.expanduser('~/.claude.json')
if os.path.exists(config_path):
    with open(config_path) as f:
        config = json.load(f)
    servers = config.get('mcpServers', {})
    if servers:
        for name in servers:
            print(f'  - {name}: configured')
    else:
        print('  No MCP servers configured')
else:
    print('  ~/.claude.json not found')
" 2>/dev/null
```

On Windows, use `python` instead of `python3` and `dir` instead of `ls` if needed.

Tell the student the results in plain language. For each item:
- If it's installed/configured: Tell them it's good
- If something is missing: Explain what needs to be fixed and help them fix it

---

## Phase 10 — Connect Your Existing Project (Bolt / Lovable)

Ask the student: "Almost done with setup! Quick question — do you already have an app you've been building on **Bolt.new** or **Lovable**?"

**If NO (or they're starting fresh):**
Tell them: "No worries! When you're ready to start building, restart Claude Code and type **/master** — I'll guide you through planning your whole app. Let's finish setup."
Then skip to Phase 11.

**If YES:** Follow the steps below.

---

Ask: "Which tool are you using — **Bolt** (bolt.new) or **Lovable** (lovable.dev)?"

### Step 10a — Export to GitHub

**If Bolt:**
1. Tell them to go to their Bolt project in the browser
2. "Look for the GitHub icon in the top right corner of the editor — it looks like a little cat"
3. "Click it. If it asks you to connect GitHub, authorize it."
4. "Then click **Push to GitHub** — it will create a new repository on your GitHub account with all your code"
5. "Once it finishes, look for the repository link — it should look like `https://github.com/yourusername/project-name`"
6. "Paste that link here."

**If Lovable:**
1. Tell them to go to their Lovable project in the browser
2. "Look for a GitHub button — usually in the top bar or in Settings"
3. "Click **Connect to GitHub** or **Export to GitHub**"
4. "Authorize Lovable to access your GitHub if asked"
5. "It will create a new repository with your code"
6. "Once done, copy the GitHub repository URL and paste it here."

Wait for them to paste the GitHub URL.

### Step 10b — Clone the Project

Tell the student: "I have the URL — let me get your project onto your computer now."

1. Determine where to save it. Ask: "Where would you like to save your project? I suggest your Desktop for easy access." Wait for their answer.
2. Clone the repo to their chosen location:
   **On Mac:**
   ```bash
   git clone <their-github-url> ~/Desktop/<project-name>
   ```
   Replace `<project-name>` with the actual repo name from their URL.
   **On Windows:**
   ```bash
   git clone <their-github-url> %USERPROFILE%\Desktop\<project-name>
   ```
3. Tell them: "Your project is now on your computer! Let me get it running."

### Step 10c — Get the .env File

Tell the student: "Your app needs a secret settings file called `.env` — it contains the keys that connect your app to your database and other services. We need to copy it from Bolt or Lovable."

🔴 Explain: "🔴 The .env file contains sensitive keys. Never share it publicly or put it on GitHub — it's like a password for your app."

**If Bolt:**
1. "Go back to your Bolt project"
2. "Look for a lock icon or click on **Settings** → **Environment Variables**"
3. "You'll see a list of variables like `VITE_SUPABASE_URL=...`. Click **Copy all** or select all the text"
4. "Paste everything here in the chat"

**If Lovable:**
1. "Go back to your Lovable project"
2. "Click on **Settings** (gear icon) → **Environment Variables**"
3. "You may also find Supabase keys under the Supabase integration panel"
4. "Copy all the environment variables and paste them here"

Wait for them to paste the .env content. Then:
- Create the file: Write the pasted content to `<project-dir>/.env`
- Tell them: "I've saved your .env file. Your app can now connect to your database."

### Step 10d — Install Dependencies and Preview

Tell the student: "One last thing — I need to install your app's packages. This is like installing all the ingredients before cooking."

```bash
cd <project-dir> && npm install
```

If `npm install` has errors, fix them before continuing.

Once done, tell the student: "Everything is installed! Type **/preview** to start your app and see it running on your computer."

---

## Phase 11 — Wrap-Up

Tell the student:

"Setup is complete — you crushed it! Here's everything we installed and configured:

**Developer Tools:**
- Git (tracks every change to your code)
- Node.js + npm (runs your web app)
- Supabase CLI (manages your database)
- GitHub CLI (connects to GitHub)
- Claude Code CLI (launches me from any terminal)
- Vercel CLI (deploys your app to the internet)

**Claude Superpowers:**
- Playwright (I can browse the web and test your app)
- Supabase MCP (I can manage your database directly)

**Custom Commands (type these anytime):**
- **/master** — Plan your app step by step (start here!)
- **/feature-dev** — Build a new feature with guidance
- **/frontend-design** — Improve the look and feel
- **/preview** — Start your app and open it in your browser
- **/commit** — Take a quick local snapshot
- **/save** — Save your work and back it up to GitHub
- **/buildandpush** — Build, commit, and push in one go
- **/sync** — Get the latest version of your code
- **/deploy** — Put your app live on the internet
- **/test** — Run a full test to check everything works
- **/install-bmad** — Install the BMAD AI agent framework

**Accounts:**
- GitHub (your code lives here)
- Supabase (your database lives here)
- Vercel (your app goes live here)

🔴 Remember to restart Claude Code to activate the Supabase connection!

After restarting, open a new conversation and type **/master** to start building your app — or if you already have one on Bolt or Lovable, let me know and I'll help you connect it."
