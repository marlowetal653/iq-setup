Install the BMAD Method framework — a set of AI agent personas and workflows that give Claude specialized modes for planning, architecture, and development.

Steps:
1. Tell the student: "Installing BMAD Method. This gives me specialized modes — like an Architect mode for planning your app's structure, a Developer mode for writing code, and a QA mode for testing. It makes me much more effective at complex projects."

2. Clone the BMAD-METHOD repo temporarily:
   **On Mac:**
   ```bash
   git clone https://github.com/bmadcode/BMAD-METHOD /tmp/bmad
   ```
   **On Windows:**
   ```bash
   git clone https://github.com/bmadcode/BMAD-METHOD %TEMP%\bmad
   ```

3. Explore the repo structure to find agent/persona files:
   **On Mac:** `ls -la /tmp/bmad/`
   **On Windows:** `dir %TEMP%\bmad`

4. Copy agent and prompt markdown files to the Claude commands directory.
   Look for directories named `agents`, `personas`, `prompts`, or `.bmad-core`.
   Copy all `.md` files found there:
   **On Mac:**
   ```bash
   find /tmp/bmad -name "*.md" ! -name "README.md" ! -name "CHANGELOG.md" | while read f; do
     cp "$f" ~/.claude/commands/bmad-$(basename "$f")
   done
   ```
   **On Windows** (in PowerShell):
   ```powershell
   Get-ChildItem -Path "$env:TEMP\bmad" -Recurse -Filter "*.md" |
     Where-Object { $_.Name -notmatch "README|CHANGELOG" } |
     ForEach-Object { Copy-Item $_.FullName "$env:USERPROFILE\.claude\commands\bmad-$($_.Name)" }
   ```

5. Clean up:
   **On Mac:** `rm -rf /tmp/bmad`
   **On Windows:** `rmdir /s /q %TEMP%\bmad`

6. Show the student what was installed:
   **On Mac:** `ls ~/.claude/commands/ | grep bmad`
   **On Windows:** `dir %USERPROFILE%\.claude\commands\ | findstr bmad`

7. Tell the student: "BMAD Method is installed! You now have access to specialized AI agent modes. Type /bmad- and press Tab to see all the new commands available."
