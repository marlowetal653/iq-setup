# Troubleshooting

Common issues students encounter during setup and how to fix them.

## Homebrew

### "brew: command not found" after installation
Homebrew was installed but not added to your PATH. Run:
```bash
# Apple Silicon Macs (M1/M2/M3/M4)
eval "$(/opt/homebrew/bin/brew shellenv)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# Intel Macs
eval "$(/usr/local/bin/brew shellenv)"
```

### Xcode Command Line Tools popup
When installing Homebrew or Git, macOS might show a popup asking to install "Xcode Command Line Tools". Click **Install** and wait 5-10 minutes. Then retry the original command.

### Password prompt shows nothing when typing
This is normal. macOS hides your password completely when typing in the terminal — no dots, no stars, nothing. Just type your password and press Enter.

## Git & GitHub

### "gh: command not found"
GitHub CLI isn't installed. Run: `brew install gh`

### "gh auth login" fails
Make sure you:
1. Selected "GitHub.com"
2. Selected "HTTPS"
3. Selected "Login with a web browser"
4. Copied the one-time code correctly
5. Authorized in the browser

Try again: `gh auth login`

### "git push" is rejected
This usually means you need to set the upstream branch first:
```bash
git push -u origin main
```

## Node.js & npm

### "npm ERR!" errors
Try clearing the cache and retrying:
```bash
npm cache clean --force
npm install
```

### "node: command not found" after install
Close and reopen your terminal, or run:
```bash
source ~/.zshrc
```

## Supabase

### "Token doesn't start with sbp_"
You might have copied the wrong thing. Go back to:
https://supabase.com/dashboard/account/tokens
Generate a new token and copy it carefully. It should start with `sbp_`.

### "Supabase MCP not working"
After adding the Supabase token, you MUST restart Claude Code:
1. Close Claude Code completely (Cmd+Q or type `exit`)
2. Open Claude Code again
3. Start a new conversation

MCP servers are only loaded when Claude Code starts.

### Supabase token expired
Tokens can expire. Generate a new one at:
https://supabase.com/dashboard/account/tokens

Then update it in `~/.claude.json` — find the `supabase` entry under `mcpServers` and replace the old token in the `args` array.

## Claude Code

### Skills/commands not showing up
Make sure the skill files are in the right directory:
```bash
ls ~/.claude/commands/
```
You should see: `preview.md`, `test.md`, `master.md`, `save.md`, `sync.md`, `deploy.md`

If missing, re-run the setup prompt to reinstall them.

### "Permission denied" errors
If Claude Code can't run a command, try running it manually in Terminal with `sudo`:
```bash
sudo <command>
```
Enter your Mac password when prompted.

## General

### Everything is broken, start over
You can safely re-run the setup prompt. It checks if things are already installed before reinstalling, so it won't break anything. It will just fix what's missing.

```
Read https://raw.githubusercontent.com/marlowetal653/iq-setup/main/README.md and follow every instruction in it step by step. I am a new student setting up my machine for the first time.
```
