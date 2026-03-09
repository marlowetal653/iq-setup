Update all IQ skills to the latest version from GitHub.

Steps:
1. Tell the student: "Updating your IQ skills to the latest version..."

2. Remove old clone if it exists, then clone fresh:
   **On Mac:**
   ```bash
   rm -rf /tmp/iq-setup && git clone https://github.com/marlowetal653/iq-setup.git /tmp/iq-setup
   ```
   **On Windows:**
   ```bash
   rmdir /s /q %TEMP%\iq-setup 2>nul & git clone https://github.com/marlowetal653/iq-setup.git %TEMP%\iq-setup
   ```

3. Copy all skill files, overwriting existing ones:
   **On Mac:**
   ```bash
   cp /tmp/iq-setup/skills/*.md ~/.claude/commands/
   ```
   **On Windows:**
   ```bash
   copy /Y %TEMP%\iq-setup\skills\*.md %USERPROFILE%\.claude\commands\
   ```

4. Update the Vercel deploy skill:
   **On Mac:**
   ```bash
   mkdir -p ~/.claude/skills/deploy-to-vercel
   cp -r /tmp/iq-setup/skills/deploy-to-vercel/* ~/.claude/skills/deploy-to-vercel/
   ```
   **On Windows:**
   ```bash
   mkdir %USERPROFILE%\.claude\skills\deploy-to-vercel 2>nul
   xcopy %TEMP%\iq-setup\skills\deploy-to-vercel\* %USERPROFILE%\.claude\skills\deploy-to-vercel\ /E /Y
   ```

5. Also update global Claude rules if the config file exists in the repo:
   **On Mac:**
   ```bash
   cp /tmp/iq-setup/config/CLAUDE.md ~/.claude/CLAUDE.md
   ```
   **On Windows:**
   ```bash
   copy /Y %TEMP%\iq-setup\config\CLAUDE.md %USERPROFILE%\.claude\CLAUDE.md
   ```

6. Clean up:
   **On Mac:**
   ```bash
   rm -rf /tmp/iq-setup
   ```
   **On Windows:**
   ```bash
   rmdir /s /q %TEMP%\iq-setup
   ```

7. List the installed skills:
   ```bash
   ls ~/.claude/commands/iq-*.md
   ```

8. Tell the student: "All IQ skills updated! You now have the latest versions of every command."
