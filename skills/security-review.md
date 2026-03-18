Quick security review of the student's app — checks database RLS policies and scans frontend code for common security issues.

Steps:

1. Tell the student: "Let's do a quick security check on your app — I'll review both your database and your frontend code to make sure everything is locked down."

2. Figure out the Supabase project ID. Check for it in these places:
   - `.env` or `.env.local` — look for `SUPABASE_URL` or `NEXT_PUBLIC_SUPABASE_URL` and extract the project ref from the URL (the subdomain before `.supabase.co`)
   - If not found, ask the student: "What's your Supabase project URL or project ID?"

3. Run the Supabase security advisor using the MCP tool `get_advisors` with type `security` and the project ID.

4. Check which public tables have RLS enabled by running this SQL via the `execute_sql` MCP tool:
   ```sql
   SELECT tablename, rowsecurity
   FROM pg_tables
   WHERE schemaname = 'public'
   ORDER BY tablename;
   ```

5. For any table where `rowsecurity` is `false`, flag it clearly:
   "These tables do NOT have Row Level Security enabled — anyone with your API key could read or modify this data:"
   List each unprotected table.

6. Check for tables that have RLS enabled but no policies defined (enabled but empty = blocks everything, which might be unintentional):
   ```sql
   SELECT t.tablename
   FROM pg_tables t
   LEFT JOIN pg_policies p ON t.tablename = p.tablename AND t.schemaname = p.schemaname
   WHERE t.schemaname = 'public'
     AND t.rowsecurity = true
   GROUP BY t.tablename
   HAVING COUNT(p.policyname) = 0;
   ```
   If any tables show up: "These tables have RLS turned on but no policies defined — this means ALL access is blocked, even for logged-in users. If that's intentional, great. If not, you'll need to add policies."

7. Show a summary to the student. Use a simple checklist format:

   For each public table, show:
   - Table name
   - RLS enabled? (yes/no)
   - Has policies? (yes/no)
   - Status: "Secured", "No RLS — exposed!", or "RLS on but no policies — fully blocked"

8. If everything looks good (all tables have RLS + policies), tell the student:
   "Your database security looks solid! All your tables have Row Level Security enabled with policies in place."

9. If there are issues, ask the student:
   "Would you like me to help fix these security issues? I can enable RLS and set up basic policies for the unprotected tables."

   If yes, help them fix the issues. For each unprotected table:
   - Enable RLS: `ALTER TABLE public.<table> ENABLE ROW LEVEL SECURITY;`
   - Ask what access pattern makes sense (e.g., "Should logged-in users be able to read all rows, or only their own?")
   - Create appropriate policies based on their answer.

10. After fixes, re-run the checks from steps 4-6 to confirm everything is now secured. Show the updated summary.

--- FRONTEND CODE REVIEW ---

11. Scan the codebase for exposed secrets. Search all source files (excluding `node_modules`, `.next`, `dist`, `build`) for patterns that should NOT be in frontend code:
    - `service_role` or `serviceRole` or `SERVICE_ROLE` — the Supabase service role key should NEVER be in client-side code
    - `secret` or `SECRET` in variable names near API keys
    - Hardcoded API keys or tokens (long alphanumeric strings assigned to variables with names like `key`, `token`, `secret`, `password`)
    - Private keys or credentials committed to the repo

    If found, flag immediately: "Your service role key (or secret) is exposed in client-side code. This key bypasses all RLS policies — anyone who views your site's source code could get full access to your database. Move it to a server-side API route or environment variable that is NOT prefixed with `NEXT_PUBLIC_`."

12. Check environment variable usage. Look at `.env`, `.env.local`, and `.env.example` files:
    - Any `NEXT_PUBLIC_` variable is exposed to the browser — flag if it contains anything other than the Supabase URL and anon key
    - Check that `.env` and `.env.local` are in `.gitignore` — if not: "Your environment files are not in .gitignore — they could get pushed to GitHub and expose your keys!"
    - Check if `.env` or `.env.local` have been committed to git history:
      ```bash
      git log --all --oneline -- .env .env.local
      ```
      If any commits show up: "Your .env file was committed to git at some point. Even if you removed it later, the keys are still in your git history. You should rotate (regenerate) your Supabase keys in the Supabase dashboard."

13. Check for Supabase client usage. Find where the Supabase client is created and verify:
    - It uses `createClient` or `createBrowserClient` with only the anon key (not the service role key)
    - If using `createServerClient` or `createRouteHandlerClient`, that's fine — server-side code can use the service role key
    - If the service role key is used in any file under `app/`, `pages/`, `components/`, or `src/` that runs in the browser, flag it

14. Check auth protection on routes/pages. Look for:
    - Pages or routes that fetch user-specific data but don't check if the user is logged in first
    - Missing auth middleware or route guards — if the app has protected pages, there should be some check like `getUser()`, `getSession()`, or an auth middleware/layout that redirects unauthenticated users
    - If no auth checks exist anywhere but the app uses Supabase auth: "Your app doesn't seem to check if users are logged in before showing protected pages. Someone could access protected routes directly."

15. Check for client-side data exposure:
    - Look for `console.log` statements that output user data, tokens, or full database responses in components (these show up in the browser console for anyone to see)
    - Check if any API responses return more data than needed (e.g., fetching `SELECT *` when only a few fields are displayed)

16. Show a frontend security summary:

    **Secrets & Environment:**
    - Service role key exposed in client code? (yes/no)
    - .env in .gitignore? (yes/no)
    - .env ever committed to git? (yes/no)
    - NEXT_PUBLIC_ vars look safe? (yes/no)

    **Auth & Access:**
    - Protected routes have auth checks? (yes/no)
    - Supabase client uses anon key only? (yes/no)

    **Code Hygiene:**
    - Console.log leaking sensitive data? (yes/no)
    - Over-fetching data from database? (yes/no)

17. Give the student an overall verdict:
    - If all checks pass: "Your app looks secure! Both your database and frontend code are following good security practices."
    - If there are issues, list them clearly and offer to help fix each one.
