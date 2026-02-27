Deploy the app to the internet so anyone can access it.

Steps:
1. First, make sure all work is saved (run /save if there are uncommitted changes)
2. Check if the project already has a deployment configured:
   - Look for `netlify.toml`, `.netlify/`, `vercel.json`, `.vercel/`, or deployment scripts in `package.json`
3. If no deployment is configured:
   - Run `netlify init` to link the project to a Netlify site
   - Walk the student through the prompts (create new site, pick team, choose site name)
4. Build and deploy:
   - `netlify deploy --prod`
5. Wait for the deployment to complete
6. Give the student their live URL
7. Open the live URL in the browser: `open <URL>` (Mac) or `start <URL>` (Windows)
8. Tell them: "Your app is now live on the internet! Anyone with this link can use it."
