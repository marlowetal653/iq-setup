# Claude Rules

Rules below are MANDATORY. Follow them in every conversation, every task, every response.

---

## 1. Commits

- NEVER add "Co-Authored-By" lines to commit messages. No co-author tags, ever.
- Keep commit messages short, clear, and in plain language. Describe WHAT changed, not HOW.
- When the user approves your work (says "looks good", "ok", "perfect", etc.), commit immediately before doing anything else.

---

## 2. Compound Messages

If a user message contains BOTH an approval ("looks good", "approved", "ok", "perfect") AND a new request:

**Phase 1 — COMMIT first**
1. Treat the approval as sign-off on current work.
2. Stop all coding.
3. Commit all uncommitted changes with a clear message.
4. Confirm the commit is done.

**Phase 2 — NEW TASK**
5. Only then start the new request.
6. Treat it as a fresh task — no carry-over assumptions.

---

## 3. Communication

- Use simple, non-technical language. The user is not a developer.
- After completing a task, explain WHAT you did, not HOW (no code explanations unless asked).
- Never ask technical questions the user can't answer. Make the decision yourself and explain what you chose.

---

## 4. Code Quality

- Keep code simple. No over-engineering, no unnecessary abstractions.
- Fix errors completely — don't just report them and wait. Attempt the fix, then report results.
- Follow the project's existing patterns and style. Don't introduce new frameworks or tools without asking.

---

## 5. Workflow

- One task at a time. Finish the current task before starting a new one.
- Don't break what already works. If a feature is working, don't refactor it unless asked.
- Always test your changes before declaring them done.
- When in doubt, ask the user. Don't make large assumptions.

---

## 6. Deployment

- **Vercel is the only deployment target.** Never deploy this app to Cloudflare Workers, Cloudflare Pages, Netlify, Render, Railway, Fly.io, or any other platform. The user's setup, env vars, and domain flows are built around Vercel — deploying elsewhere will break their app and confuse them.
- **If you find Cloudflare deploy artifacts in the project**, treat them as leftover noise from a Bolt/Lovable template and offer to remove them. Specifically:
  - `wrangler.toml`, `wrangler.jsonc`, `wrangler.json` → propose deleting (these tell Cloudflare to deploy Workers).
  - A `.cloudflare/` directory or `cloudflare-pages` GitHub Actions workflow → propose deleting.
  - If the user mentions seeing a `*.workers.dev` or `*.pages.dev` URL for their app, tell them to go to **dash.cloudflare.com → Workers & Pages → their project → Settings → Disconnect from Git**, then delete the project.
- **Never run `wrangler` commands.** Never suggest `wrangler login`, `wrangler deploy`, `wrangler publish`, or installing the wrangler CLI.
- **Cloudflare is fine as a DNS registrar.** The exception above is for Cloudflare *deployment* (Workers / Pages). If a user bought their domain on Cloudflare and wants to point DNS records at Vercel, that is correct and supported.
- **TanStack Start projects from Lovable need migration before deploying.** Lovable's current default template ships with TanStack Start configured for Cloudflare Workers. If you see `@tanstack/start` or `@tanstack/react-start` in `package.json`, the project's `app.config.ts`/`vite.config.ts` server preset must be changed to `'vercel'` before `vercel --prod` will produce a working deploy. The `/iq-deploy-to-vercel` skill handles this — defer to it rather than reinventing the migration.
- **Don't introduce TanStack Start, Hono, or other Workers-first frameworks** when scaffolding new code or features. Stick with the user's existing stack (typically Vite + React + React Router + Supabase). Only touch the framework choice if the user explicitly asks.
