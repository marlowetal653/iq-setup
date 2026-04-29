Deploy the app to the internet so anyone can access it.

Steps:

1. First, make sure all work is saved (run /save if there are uncommitted changes).

2. 🔴 **MANDATORY — Check for stray Cloudflare deploy hooks before doing anything else.**

   Vercel is the only supported deploy target. Cloudflare Workers/Pages deploys often slip in via Bolt/Lovable templates and silently double-deploy the student's app to a `*.workers.dev` or `*.pages.dev` URL. Catch this now.

   a. Look for Cloudflare deploy artifacts in the project root:
      ```bash
      ls wrangler.toml wrangler.jsonc wrangler.json 2>/dev/null
      ls -la .cloudflare 2>/dev/null
      ls .github/workflows 2>/dev/null | grep -i cloudflare
      ```

   b. If any of those return a match, tell the student:

      "I found a leftover Cloudflare deploy file in your project (`<filename>`). This came from your Bolt/Lovable template and is silently deploying your app to Cloudflare in addition to Vercel — which is why you might see your app on a `*.workers.dev` or `*.pages.dev` URL.

      Want me to remove it so Vercel is the only place your app deploys to?"

      If they say yes, delete the file(s):
      ```bash
      rm -f wrangler.toml wrangler.jsonc wrangler.json
      rm -rf .cloudflare
      # If a Cloudflare GitHub Action workflow exists, delete it too:
      # rm .github/workflows/<the-cloudflare-workflow>.yml
      ```

   c. Also ask the student: "Have you ever seen your app at a URL ending in `.workers.dev` or `.pages.dev`?"
      - If YES: Tell them "That's a Cloudflare Pages project still connected to your GitHub repo. Even after I remove the local files, Cloudflare will keep redeploying on every push until you disconnect it. Here's how:
        1. Go to **https://dash.cloudflare.com**
        2. Click **Workers & Pages** in the left sidebar
        3. Find your project in the list and click on it
        4. Go to **Settings → Builds & deployments** (or **Git integration**)
        5. Click **Disconnect** next to the GitHub connection
        6. Then go back to the project list, click the **...** menu next to the project, and click **Delete**
        Let me know when that's done."
      - If NO: continue.

   d. 🔴 **AUTONOMOUSLY convert the project to Vercel-compatible if it uses TanStack Start.** Do not ask the student to make code changes. Make every edit yourself with the Edit/Write tool, run the build, and only surface a problem if the build actually fails after retrying.

      First, detect TanStack Start (Lovable's current default ships with this framework configured for Cloudflare Workers):
      ```bash
      grep -E '"@tanstack/(react-)?start"' package.json 2>/dev/null
      ```
      If no match, skip the rest of step 2d and continue to step 3. If matched:

      i. Tell the student: "Your project was set up by Lovable to deploy to Cloudflare. I'm converting it to Vercel — give me a minute. Your app's features won't change."

      ii. **Edit the TanStack Start config to use the Vercel preset.** Check for `app.config.ts`, `app.config.js`, `vite.config.ts`, `vite.config.js` in the project root.
         - If a config file exists and contains `preset:` set to any `cloudflare*` value (`'cloudflare-workers'`, `'cloudflare-pages'`, `'cloudflare'`, `'cloudflare-module'`) → use Edit to replace that string with `'vercel'`.
         - If a config file exists with `defineConfig({ ... })` but no `server:` block → use Edit to add `server: { preset: 'vercel' },` inside the config object.
         - If no `app.config.*` exists, use Write to create `app.config.ts`:
           ```ts
           import { defineConfig } from '@tanstack/start/config'

           export default defineConfig({
             server: { preset: 'vercel' }
           })
           ```
         Apply these edits directly. Do not paste config to the student or ask for permission.

      iii. **Remove Cloudflare dependencies from `package.json`.** Edit `package.json` directly to delete these entries from `dependencies` and `devDependencies` if present: `wrangler`, `@cloudflare/workers-types`, `@cloudflare/vite-plugin`, `miniflare`, `wrangler-action`. Then refresh the lockfile:
         ```bash
         npm install
         ```

      iv. **Rewrite Cloudflare-specific imports in source code.** Find them:
         ```bash
         grep -rln "cloudflare:workers\|@cloudflare/workers-types\|@cloudflare/vite-plugin" src app server 2>/dev/null
         ```
         For each matching file, use Edit autonomously:
         - Delete any `import ... from 'cloudflare:workers'` and `import type ... from '@cloudflare/workers-types'` lines.
         - Replace `env.X` (Workers binding access) with `process.env.X`. Vercel reads env vars via `process.env`.
         - If a file uses KV/D1/R2 bindings AND the project already has Supabase (check `package.json` for `@supabase/supabase-js`), rewrite the binding call to use the existing Supabase client (table query for KV/D1, Storage for R2). If Supabase isn't present, comment out the binding usage with `// TODO: replace with Vercel storage` so the file still compiles.

      v. **Build to verify the migration:**
         ```bash
         npm run build
         ```

         - If the build succeeds → tell the student "Migration done — your project now builds for Vercel." Continue to step 3.
         - If the build fails → read the error output, fix the file yourself, and re-run `npm run build`. Iterate up to 3 times. Common fixes: install the Vercel preset (`npm install @tanstack/start@latest`), remove a leftover `cloudflare:` import you missed, fix a `process.env` typo. Only ask the student for help if the same root cause recurs after 3 fix attempts.

3. Check if Vercel CLI is installed and the student is logged in:
   ```bash
   vercel whoami
   ```
   - If this fails, tell the student: "You need to set up Vercel first. Type /install-vercel and we'll get that done." Then stop here.

4. Check if the project is already linked to Vercel:
   - Look for a `.vercel/` directory in the project.
   - If not linked, run `vercel link` and walk the student through the prompts (create new project, confirm settings).

5. 🔴 **MANDATORY — Push environment variables to Vercel.**

   Before deploying, you MUST sync the local `.env` file to the Vercel project. Without this, the deployed app will be broken (no database connection, no API keys). Never skip this step.

   a. Check if `.env` exists in the project root:
      ```bash
      test -f .env && echo "FOUND" || echo "MISSING"
      ```
      - If MISSING: Tell the student "I don't see a `.env` file — your app might not need one, or it might be named differently. If your app uses Supabase or any API keys, we need to add them to Vercel manually." If they confirm there are no env vars, continue to step 6.
      - If FOUND: continue.

   b. Tell the student: "I'm copying your secret keys from `.env` over to Vercel — this is what lets your live app connect to your database, just like it does on your computer."

   c. For each variable in `.env`, push it to all three Vercel environments (production, preview, development). Run from the project root:
      ```bash
      while IFS= read -r line || [ -n "$line" ]; do
        [ -z "$line" ] && continue
        case "$line" in \#*) continue ;; esac
        name="${line%%=*}"
        value="${line#*=}"
        name=$(echo "$name" | xargs)
        [ -z "$name" ] && continue
        value="${value%\"}"; value="${value#\"}"
        value="${value%\'}"; value="${value#\'}"
        for target in production preview development; do
          vercel env rm "$name" "$target" --yes >/dev/null 2>&1
          printf '%s' "$value" | vercel env add "$name" "$target" >/dev/null 2>&1
        done
        echo "Synced: $name"
      done < .env
      ```

   d. Verify the push worked:
      ```bash
      vercel env ls
      ```
      Confirm each variable from `.env` appears. If any are missing, retry that variable individually.

   e. Tell the student: "Your secret keys are now on Vercel. Your live app will use the same database and settings as your local version."

6. Deploy to production:
   ```bash
   vercel --prod
   ```

7. Wait for the deployment to complete. Capture the live URL from the output.

8. Give the student their live URL and open it:
   - **Mac:** `open <URL>`
   - **Windows:** `start <URL>`
   - Tell the student: "Your app is now live on the internet! Anyone with this link can use it."

9. Check the URL type. If the URL is a free Vercel subdomain (ends in `.vercel.app`), tell the student:

   "Right now your app is on a free Vercel URL — something like `your-app.vercel.app`. This works great and is totally fine to use! But if you want a custom domain like `yourname.com` or `myapp.io`, we can set that up too."

   Ask: "Would you like to get your own custom domain, or is the free URL good for now?"

   - If the student says the free URL is fine, say: "You're all set! You can always add a custom domain later by typing /iq-deploy-to-vercel and asking about it." Then stop here.
   - If the student wants a custom domain, continue to step 10.

   If the URL is already on a custom domain (not `.vercel.app`), tell the student: "Your app is live on your custom domain!" Then stop here.

10. Ask the student:

    "Do you want to **purchase a new domain**, or do you **already own a domain** you'd like to connect?"

11. If the student wants to **purchase a new domain**:

   Walk them through buying directly on Vercel:
   "1. Go to your Vercel dashboard at **https://vercel.com** in your browser."
   "2. Click **Add New...** in the top right, then click **Domain**."
   "3. Search for the domain name you want (like `yourname.com`)."
   "4. If it's available, click **Buy** and follow the checkout."
   "5. Vercel will automatically connect it to your project — that's it!"

   After they confirm the purchase, verify:
   ```bash
   vercel domains ls
   ```
   Tell the student: "Your custom domain is connected! Your app should be live at `yourdomain.com` in a few minutes."

12. If the student **already owns a domain**:

    - Ask: "What's your domain?" (e.g., `mycoolapp.com`)
    - Add it to the Vercel project:
      ```bash
      vercel domains add <domain>
      ```
    - Vercel will output the DNS records needed. Tell the student:

      "Now we need to point your domain to Vercel. Here's what to do:"
      "1. Log in to the site where you bought the domain (Namecheap, Cloudflare, GoDaddy, etc.) and find the DNS settings."
      "2. Add these records:"

      Show the records from the `vercel domains add` output. Typically:
      - "Add an **A record**: Name = `@`, Value = `76.76.21.21`"
      - "Add a **CNAME record**: Name = `www`, Value = `cname.vercel-dns.com`"

      "3. Save the changes. DNS can take a few minutes to update (sometimes up to an hour, but usually much faster)."

    - After the student confirms they've updated DNS, verify:
      ```bash
      vercel domains verify <domain>
      ```
    - If verified: "Your custom domain is connected! Your app is now live at `yourdomain.com`."
    - If not yet verified: "DNS is still propagating — this is normal. Try visiting your domain in a few minutes. If it's still not working after an hour, come back and we'll troubleshoot."
