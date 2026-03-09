Start the Expo development server so the student can preview their mobile app on their phone using Expo Go.

Steps:
1. Check if this is an Expo project:
   - Look for `expo` in `package.json` dependencies or devDependencies
   - If not an Expo project, tell the student: "This doesn't look like an Expo project. This command is for React Native apps built with Expo." Then stop.

2. Make sure dependencies are installed:
   ```bash
   npm install
   ```

3. Start the Expo dev server with tunnel mode (so it works even if phone and computer are on different networks):
   ```bash
   npx expo start --tunnel
   ```
   If `@expo/ngrok` is not installed, it will prompt to install it — that's fine, let it install.

4. The terminal will display a QR code and a URL like `exp://u.expo.dev/...`. Tell the student:

   "Your app is running! Here's how to see it on your phone:

   **Step 1: Download Expo Go**
   - **iPhone:** Open the App Store, search for **Expo Go**, and install it
   - **Android:** Open the Google Play Store, search for **Expo Go**, and install it

   **Step 2: Open the app on your phone**
   - **iPhone:** Open your **Camera app** and point it at the QR code above. Tap the notification that appears — it will open in Expo Go.
   - **Android:** Open the **Expo Go app** and tap **Scan QR code**, then point it at the QR code above.

   Your app should load on your phone! Every time you make changes, the app will update automatically."

5. Keep the server running. If the student says they're done previewing, stop the server with Ctrl+C.
