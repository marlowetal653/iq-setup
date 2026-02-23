# IQ Setup

A one-prompt setup tool for vibe coding students. Students paste a single prompt into Claude Code, and it automatically installs everything they need to start building web apps.

## What is this?

This repo contains setup instructions that **Claude Code reads and executes**. The `README.md` at the root is written for Claude, not for humans. You're reading the human version.

## How students use it

1. Open Claude Code on their Mac
2. Paste this prompt:

```
Read https://raw.githubusercontent.com/marlowetal653/iq-setup/main/README.md and follow every instruction in it step by step. I am a new student setting up my machine for the first time.
```

3. Claude walks them through everything step by step

## What gets installed

### Developer Tools
- **Homebrew** — Mac package manager
- **Git** — Code version control
- **Node.js + npm** — JavaScript runtime
- **Supabase CLI** — Database management
- **GitHub CLI** — Code hosting integration

### MCP Servers (Claude superpowers)
- **Playwright** — Browser automation and testing
- **Supabase** — Direct database management

### Custom Commands
| Command | What it does |
|---------|-------------|
| `/preview` | Start the app and open it in the browser |
| `/test` | Run a full test suite (linting, unit tests, E2E) |
| `/master` | Build an app specification step by step (in French) |
| `/save` | Git add + commit + push in one command |
| `/sync` | Pull latest changes + update dependencies |
| `/deploy` | Deploy to Vercel or Netlify |

### Accounts Created
- **GitHub** — Where code lives
- **Supabase** — Where the database lives

## How to modify

All setup instructions live in `README.md`. Edit it to change what gets installed or how Claude walks students through the process.

Skills live in `skills/`. Edit or add `.md` files to change the custom commands.

Global Claude rules live in `config/CLAUDE.md`.

## Requirements

- macOS (Apple Silicon or Intel)
- Claude Code installed and logged in
- An internet connection
