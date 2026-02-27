# IQ Setup

A one-prompt setup tool for vibe coding students. Students paste a single prompt into Claude Code, and it automatically installs everything they need to start building web apps.

## What is this?

This repo contains setup instructions that **Claude Code reads and executes**. The `README.md` at the root is written for Claude, not for humans. You're reading the human version.

## Before you start

You need the **Claude desktop app** installed and signed in. Download it at https://claude.ai/download — you'll need a Claude Pro or Max subscription.

Once the app is open, you can access Claude Code from the terminal inside it.

## How students use it

1. Open the Claude desktop app and launch Claude Code
2. Paste this prompt:

```
Read https://raw.githubusercontent.com/marlowetal653/iq-setup/main/README.md and follow every instruction in it step by step. I am a new student setting up my machine for the first time.
```

3. Claude walks them through everything step by step

## What gets installed

### Developer Tools
- **Homebrew** (Mac) / **winget** (Windows) — Package manager
- **Git** — Code version control
- **Node.js + npm** — JavaScript runtime
- **Supabase CLI** — Database management
- **GitHub CLI** — Code hosting integration
- **Netlify CLI** — App deployment

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
| `/deploy` | Deploy to Netlify |

### Accounts Created
- **GitHub** — Where code lives
- **Supabase** — Where the database lives
- **Netlify** — Where the app goes live

## How to modify

All setup instructions live in `README.md`. Edit it to change what gets installed or how Claude walks students through the process.

Skills live in `skills/`. Edit or add `.md` files to change the custom commands.

Global Claude rules live in `config/CLAUDE.md`.

## Requirements

- macOS (Apple Silicon or Intel) or Windows 10/11
- Claude desktop app installed and signed in (https://claude.ai/download)
- A Claude Pro or Max subscription
- An internet connection
