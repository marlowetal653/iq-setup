# IQ Setup — Instructions for Claude

> **What is this?** This file contains setup instructions that Claude Code
> reads and executes. A student pastes a one-line prompt into Claude Code,
> Claude fetches this file, and walks the student through full environment
> setup. If you're a human reading this, see [docs/HUMAN_README.md](docs/HUMAN_README.md).

---

## RULES FOR CLAUDE

Before you begin, follow these rules throughout the entire setup:

1. **Talk to the student.** After every major step, tell them what you just did and what's coming next. Use plain, simple language. They are completely non-technical.
2. **Be idempotent.** Before installing anything, check if it's already installed. If it is, skip it and say so.
3. **Ask before acting.** Before running install commands, briefly tell the student what you're about to install and why. Wait for their OK.
4. **Handle errors gracefully.** If something fails, explain what went wrong in plain language and suggest a fix.
5. **One step at a time.** Do not rush. Complete each phase fully before moving to the next.
6. **macOS only.** If the student is not on macOS, stop and explain that this setup currently only supports Mac.
7. **Be encouraging.** These are beginners. Celebrate small wins. Never make them feel dumb.
8. **Never run interactive commands.** Some commands need the student to type, select options, or enter passwords. You CANNOT do this for them — Claude Code's terminal doesn't support interactive input. For these commands, tell the student to open their **Terminal** app (Cmd+Space, type "Terminal", press Enter) and type the command themselves. Walk them through every prompt they'll see. Wait for them to tell you they're done before continuing.

---

## Phase 1 — System Check

Run `uname -s` to confirm the student is on macOS (should return "Darwin").
If not macOS, stop and tell them: "This setup is designed for Mac. We'll need a different approach for your operating system."

Also run `uname -m` to detect architecture:
- `arm64` = Apple Silicon (M1/M2/M3/M4) — Homebrew installs to `/opt/homebrew/`
- `x86_64` = Intel Mac — Homebrew installs to `/usr/local/`

Remember which architecture this is — it matters for Homebrew PATH setup.

Tell the student: "Your Mac is ready. Let's start installing the tools you need."

---

## Phase 2 — Install Homebrew

Check if Homebrew is installed:
```bash
which brew
```

**If NOT installed:**

1. Tell the student: "I need to install Homebrew. It's like an app store for developer tools — it's the standard way to install things on a Mac. It's safe and used by millions of developers."

2. IMPORTANT — This is an INTERACTIVE install. You cannot run it yourself.
   Tell the student to open their **Terminal** app:
   "I need you to open the Terminal app on your Mac. Press Cmd+Space, type 'Terminal', and press Enter."

3. Once they confirm Terminal is open, give them the command to paste:
   "Copy and paste this command into Terminal, then press Enter:"
   ```
   NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. Warn them about the password prompt:
   "Your Mac will ask for your password. This is your computer login password. When you type it, you won't see any dots or stars — that's completely normal. Just type it and press Enter."

5. Tell them to let you know when they see "Installation successful!" or similar.
   Wait for them to confirm before continuing.

6. CRITICAL — After install, Homebrew needs to be added to PATH.
   Tell the student to also paste this into their Terminal:
   On Apple Silicon Macs (arm64):
   ```
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```
   On Intel Macs (x86_64): No action needed — tell them to skip this step.

7. If the install triggered a popup asking to install "Xcode Command Line Tools":
   Tell the student: "A popup appeared asking to install developer tools. Click 'Install' and wait — it can take 5-10 minutes. Let me know when it's done."
   Wait for them to confirm, then have them retry the Homebrew install command.

8. Once they confirm it's done, come back to Claude Code and verify yourself:
   `brew --version`

**If already installed:**
- Tell the student: "Homebrew is already installed. Skipping."
- Run `brew update` to make sure it's current.

---

## Phase 3 — Install Developer Tools

For each tool below, check if it's already installed before installing. After each install, explain what the tool does in one simple sentence.

### 3a — Git
```bash
which git && git --version
```
If not installed: `brew install git`
Tell them: "Git is how we track changes to your code — like version history in Google Docs."

### 3b — Node.js
```bash
which node && node --version
```
If not installed: `brew install node`
After install, also verify npm: `which npm && npm --version`
Tell them: "Node.js runs JavaScript, which is the language your web app will use."

### 3c — Supabase CLI
```bash
which supabase
```
If not installed: `brew install supabase/tap/supabase`
Tell them: "Supabase is your database — it stores all the data for your app, like user accounts and content."

### 3d — GitHub CLI
```bash
which gh
```
If not installed: `brew install gh`
Tell them: "GitHub CLI lets me connect your code to GitHub, which is like Google Drive for code."

After all tools are installed, tell the student:
"All developer tools are installed. Here's what we set up:
- Git (track code changes)
- Node.js (run your app)
- Supabase CLI (manage your database)
- GitHub CLI (connect to GitHub)

Now let's install some custom commands that will make your life easier."

---

## Phase 4 — Install Skills and Rules

### 4a — Clone this repository

```bash
git clone https://github.com/marlowetal653/iq-setup.git /tmp/iq-setup
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
```

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
```bash
rm -rf /tmp/iq-setup
```

### 4e — Tell the student what they got

Tell them:
"I've installed 6 custom commands you can use anytime:

- **/preview** — Start your app and open it in your browser
- **/test** — Run a full test suite to check everything works
- **/master** — Build your app specification step by step (this is the main one!)
- **/save** — Save your work and back it up to GitHub
- **/sync** — Get the latest version of your code
- **/deploy** — Put your app live on the internet

I also installed some rules that make me work better — like automatically saving your work when you approve something."

---

## Phase 5 — Set Permissions to Auto-Accept

Claude Code normally asks for permission before running commands. For students, this is
confusing and unnecessary — they don't know what they're approving anyway.

Set up a shell alias so Claude always runs in auto-accept mode:

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

Tell the student: "I've configured Claude to run smoothly without asking you
technical permission questions. This makes your experience much simpler."

---

## Phase 6 — Configure MCP Servers

MCP servers give Claude extra capabilities. We need to configure them in `~/.claude.json`.

### 6a — Add Playwright MCP (no authentication needed)

Use python3 to safely modify the JSON config:

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

Tell the student: "I've configured the Playwright browser testing tool. This lets me browse the web and test your app automatically."

### 6b — Supabase MCP (needs token — configured later)

Do NOT add the Supabase MCP server yet. We need the student's access token first. We'll come back to this in Phase 7 after account setup.

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

IMPORTANT: `gh auth login` is an INTERACTIVE command. Do NOT run it yourself — it will hang.

Tell the student: "Now let's connect your GitHub account to Claude Code. This requires you to type a command yourself."

1. Tell them to open their **Terminal** app (if not already open):
   "Open Terminal again (Cmd+Space, type 'Terminal', Enter)."

2. Give them the exact command to paste:
   "Copy and paste this into Terminal and press Enter:"
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
   - "Go back to Terminal — you should see 'Logged in as [your username]'"

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
5. "IMPORTANT: You'll see a long string of text that starts with 'sbp_'. Click the copy button next to it."
6. "This is the ONLY time you can see this token. If you lose it, you'll have to create a new one."
7. "Now paste the token here in our chat."

Wait for them to paste the token. It should start with `sbp_`.

If what they pasted doesn't start with `sbp_`:
- Tell them: "That doesn't look right — the token should start with 'sbp_'. Can you try copying it again from the Supabase page?"

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

IMPORTANT: After adding the MCP server, Claude needs to restart to pick up the new configuration.

Tell the student:
"I've connected your Supabase account to Claude Code! For this to take effect, you need to restart Claude Code:

1. Close this Claude Code window completely (Cmd+Q or type 'exit')
2. Open Claude Code again
3. Start a new conversation

After you restart, I'll be able to manage your database directly."

Do NOT try to test the Supabase MCP connection in the current session — it won't be available until after restart.

---

## Phase 9 — Verification Checklist

Run through this checklist and report results to the student:

```bash
echo "=== Setup Verification ==="
echo "Homebrew: $(brew --version 2>/dev/null | head -1 || echo 'NOT INSTALLED')"
echo "Git: $(git --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "Node.js: $(node --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "npm: $(npm --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "Supabase CLI: $(supabase --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "GitHub CLI: $(gh --version 2>/dev/null | head -1 || echo 'NOT INSTALLED')"
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

Tell the student the results in plain language. For each item:
- If it's installed/configured: Tell them it's good
- If something is missing: Explain what needs to be fixed and help them fix it

---

## Phase 10 — Wrap-Up

Tell the student:

"Setup is complete! Here's everything we installed and configured:

**Developer Tools:**
- Homebrew (package manager — installs other tools)
- Git (tracks changes to your code)
- Node.js + npm (runs your web app)
- Supabase CLI (manages your database)
- GitHub CLI (connects to GitHub)

**Claude Superpowers:**
- Playwright (I can browse the web and test your app)
- Supabase MCP (I can manage your database directly)

**Custom Commands (type these anytime):**
- /preview — Start your app and open it in your browser
- /test — Run a full test to check everything works
- /master — Build your app specification step by step
- /save — Save your work and back it up online
- /sync — Get the latest version of your code
- /deploy — Put your app live on the internet

**Accounts:**
- GitHub (your code lives here)
- Supabase (your database lives here)

Remember to restart Claude Code to activate the Supabase connection!

You're ready to start building! After restarting, open a new conversation and type **/master** to start defining your app."
