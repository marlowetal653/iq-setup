Update all IQ skills (the /iq-* commands) to the latest version from the iq-setup GitHub repo. Use this whenever the user says any of: "update my skills", "update the iq skills", "update skills from the main repo", "refresh skills", "sync skills", "get latest skills", "/iq-update-skills".

🔴 **DO NOT ASK CLARIFYING QUESTIONS.** This skill is fully self-contained and unambiguous. Do not ask the student where the repo is, which skills to update, or what they meant. The repo is `https://github.com/marlowetal653/iq-setup`. The skills to update are everything in `skills/*.md` plus the `deploy-to-vercel/` subdirectory plus `config/CLAUDE.md`. Just run the steps below.

Steps:

1. Tell the student: "Updating your IQ skills to the latest version — give me a few seconds." Detect the OS (Mac vs Windows) once at the start using `uname -s 2>/dev/null || echo WINDOWS`. Use the matching commands below from then on.

2. Make sure git is available:
   ```bash
   git --version
   ```
   If this fails, tell the student: "Git isn't installed — type /iq-master to run setup, or install Git from https://git-scm.com first." Then stop.

3. Remove any stale clone, then clone the repo fresh.

   **On Mac:**
   ```bash
   rm -rf /tmp/iq-setup
   git clone --depth 1 https://github.com/marlowetal653/iq-setup.git /tmp/iq-setup
   ```

   **On Windows:**
   ```bash
   rmdir /s /q %TEMP%\iq-setup 2>nul
   git clone --depth 1 https://github.com/marlowetal653/iq-setup.git %TEMP%\iq-setup
   ```

   If the clone fails (network, GitHub rate limit, etc.), tell the student exactly what the error said and stop. Do not proceed with stale files.

4. Make sure the destination directories exist before copying.

   **On Mac:**
   ```bash
   mkdir -p ~/.claude/commands
   mkdir -p ~/.claude/skills/deploy-to-vercel
   ```

   **On Windows:**
   ```bash
   if not exist "%USERPROFILE%\.claude\commands" mkdir "%USERPROFILE%\.claude\commands"
   if not exist "%USERPROFILE%\.claude\skills\deploy-to-vercel" mkdir "%USERPROFILE%\.claude\skills\deploy-to-vercel"
   ```

5. Copy every skill file from the repo, overwriting existing copies.

   **On Mac:**
   ```bash
   cp -f /tmp/iq-setup/skills/*.md ~/.claude/commands/
   ```

   **On Windows:**
   ```bash
   copy /Y %TEMP%\iq-setup\skills\*.md %USERPROFILE%\.claude\commands\
   ```

6. Copy the bundled Vercel deploy skill (the SKILL.md and any siblings).

   **On Mac:**
   ```bash
   cp -rf /tmp/iq-setup/skills/deploy-to-vercel/. ~/.claude/skills/deploy-to-vercel/
   ```

   **On Windows:**
   ```bash
   xcopy /E /Y /I %TEMP%\iq-setup\skills\deploy-to-vercel %USERPROFILE%\.claude\skills\deploy-to-vercel
   ```

7. Update the global Claude rules file. This adds rules like the Cloudflare/deploy ban — important.

   **On Mac:**
   ```bash
   cp -f /tmp/iq-setup/config/CLAUDE.md ~/.claude/CLAUDE.md
   ```

   **On Windows:**
   ```bash
   copy /Y %TEMP%\iq-setup\config\CLAUDE.md %USERPROFILE%\.claude\CLAUDE.md
   ```

8. Clean up the temp clone.

   **On Mac:**
   ```bash
   rm -rf /tmp/iq-setup
   ```

   **On Windows:**
   ```bash
   rmdir /s /q %TEMP%\iq-setup
   ```

9. Verify the install by listing what's now in commands.

   **On Mac:**
   ```bash
   ls ~/.claude/commands/iq-*.md 2>/dev/null
   ```

   **On Windows:**
   ```bash
   dir /B "%USERPROFILE%\.claude\commands\iq-*.md"
   ```

   Count how many `iq-*.md` files are present. If the count is zero, something went wrong — tell the student the copy failed and to try again. If the count looks reasonable (8+ files), continue.

10. Tell the student: "All IQ skills are updated to the latest version. 🔴 Restart Claude Code (close this window and reopen it) so the new skills load — you'll be ready to go after that."

    Do NOT continue with any other task in this session. The new skills only take effect after restart.
