Deploy the app to the internet so anyone can access it.

Steps:
1. First, make sure all work is saved (run /save if there are uncommitted changes)
2. Check if the project already has a Vercel deployment configured:
   - Look for `vercel.json` or `.vercel/` in the project
3. If no deployment is configured yet:
   - Run `vercel link` to connect the project to a Vercel site
   - Walk the student through the prompts: create new project, confirm settings
4. Deploy to production:
   - Run `vercel --prod`
5. Wait for the deployment to complete
6. Give the student their live URL
7. Open the live URL in the browser: `open <URL>` (Mac) or `start <URL>` (Windows)
8. Tell the student: "Your app is now live on the internet! Anyone with this link can use it."
