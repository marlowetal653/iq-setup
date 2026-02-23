Deploy the app to the internet so anyone can access it.

Steps:
1. First, make sure all work is saved (run /save if there are uncommitted changes)
2. Check if the project already has a deployment configured:
   - Look for `vercel.json`, `.vercel/`, `netlify.toml`, or deployment scripts in `package.json`
3. If no deployment is configured, ask the student which platform they prefer:
   - **Vercel** (recommended for most projects) — run `npx vercel` and walk through the login + setup
   - **Netlify** — run `npx netlify-cli deploy --prod` and walk through the login + setup
4. If deployment is already configured:
   - For Vercel: `npx vercel --prod`
   - For Netlify: `npx netlify-cli deploy --prod`
5. Wait for the deployment to complete
6. Give the student their live URL
7. Open the live URL in the browser: `open <URL>`
8. Tell them: "Your app is now live on the internet! Anyone with this link can use it."
