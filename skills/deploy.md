Deploy the app to the internet so anyone can access it.

Steps:

1. First, make sure all work is saved (run /save if there are uncommitted changes).

2. Check if Vercel CLI is installed and the student is logged in:
   ```bash
   vercel whoami
   ```
   - If this fails, tell the student: "You need to set up Vercel first. Type /install-vercel and we'll get that done." Then stop here.

3. Check if the project is already linked to Vercel:
   - Look for a `.vercel/` directory in the project.
   - If not linked, run `vercel link` and walk the student through the prompts (create new project, confirm settings).

4. Deploy to production:
   ```bash
   vercel --prod
   ```

5. Wait for the deployment to complete. Capture the live URL from the output.

6. Give the student their live URL and open it:
   - **Mac:** `open <URL>`
   - **Windows:** `start <URL>`
   - Tell the student: "Your app is now live on the internet! Anyone with this link can use it."

7. Check the URL type. If the URL is a free Vercel subdomain (ends in `.vercel.app`), tell the student:

   "Right now your app is on a free Vercel URL — something like `your-app.vercel.app`. This works great and is totally fine to use! But if you want a custom domain like `yourname.com` or `myapp.io`, we can set that up too."

   Ask: "Would you like to get your own custom domain, or is the free URL good for now?"

   - If the student says the free URL is fine, say: "You're all set! You can always add a custom domain later by typing /deploy and asking about it." Then stop here.
   - If the student wants a custom domain, continue to step 8.

   If the URL is already on a custom domain (not `.vercel.app`), tell the student: "Your app is live on your custom domain!" Then stop here.

8. Ask the student:

   "Do you want to **purchase a new domain**, or do you **already own a domain** you'd like to connect?"

9. If the student wants to **purchase a new domain**:

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

10. If the student **already owns a domain**:

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
