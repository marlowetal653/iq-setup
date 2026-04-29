#!/usr/bin/env bash
# IQ Setup — bootstrap updater for /iq-* skills, the deploy-to-vercel skill,
# and the global CLAUDE.md rules. Run when the /iq-update-skills slash
# command is broken or missing.
#
# Usage:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/marlowetal653/iq-setup/main/scripts/update-skills.sh)"

set -euo pipefail

REPO_URL="https://github.com/marlowetal653/iq-setup.git"
TMP_DIR="${TMPDIR:-/tmp}/iq-setup-update-$$"
COMMANDS_DIR="$HOME/.claude/commands"
SKILLS_DIR="$HOME/.claude/skills"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"

echo "→ Updating IQ skills from $REPO_URL"

if ! command -v git >/dev/null 2>&1; then
  echo "✗ git is not installed. Install it from https://git-scm.com first." >&2
  exit 1
fi

trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1 || {
  echo "✗ git clone failed. Check your internet connection and try again." >&2
  exit 1
}

mkdir -p "$COMMANDS_DIR"
mkdir -p "$SKILLS_DIR/deploy-to-vercel"

cp -f "$TMP_DIR"/skills/*.md "$COMMANDS_DIR"/

if [ -d "$TMP_DIR/skills/deploy-to-vercel" ]; then
  cp -rf "$TMP_DIR"/skills/deploy-to-vercel/. "$SKILLS_DIR"/deploy-to-vercel/
fi

if [ -f "$TMP_DIR/config/CLAUDE.md" ]; then
  cp -f "$TMP_DIR/config/CLAUDE.md" "$CLAUDE_MD"
fi

skill_count=$(find "$COMMANDS_DIR" -maxdepth 1 -name 'iq-*.md' | wc -l | tr -d ' ')
echo "✓ Installed $skill_count IQ skills."
echo "✓ Updated deploy-to-vercel skill and global CLAUDE.md."
echo ""
echo "🔴 Restart Claude Code (close this window and reopen it) so the new skills load."
