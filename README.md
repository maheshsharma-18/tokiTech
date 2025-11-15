# tokiTech

This repository now contains the Flutter + Firebase codebase for the Toki Tech staff web portal alongside requirements and design references stored under `docs/`.

## Repo Layout

- `docs/`: Product requirements, workflows, and exported Figma screens per role. Treat `docs/prd.md` as the canonical scope reference.
- `tokitech_web/`: Flutter Web project that powers the OTP login flow and admin dashboard shell.

## Prerequisites

- Flutter 3.24+ with web support enabled.
- Firebase CLI + access to the target Firebase project (for Auth/Firestore/Storage).
- Translation microservice endpoint + API token (used to fetch Telugu strings at runtime).

## Local Setup

```bash
cd tokitech_web
flutter pub get
# Configure Firebase (replace with actual project when ready)
flutterfire configure --project <firebase-project-id>
```

`lib/firebase_options.dart` currently carries placeholder values. After running `flutterfire configure`, replace the generated file or update the placeholders with the real credentials.

### Translation Service

The Flutter app expects a translation API exposed via `TRANSLATION_BASE_URL` and `TRANSLATION_API_KEY` Dart defines. When running the app, pass:

```bash
flutter run -d chrome \
	--dart-define=TRANSLATION_BASE_URL=https://translator.example.com/translate \
	--dart-define=TRANSLATION_API_KEY=your-token
```

If these defines are omitted, the UI falls back to English copy.

## Running & Testing

```bash
cd tokitech_web
flutter run -d chrome
```

### Run with the Flutter web server (local machine)

Use this when you want to access the app from any browser, not just Chrome with the Dart debug extension:

```bash
cd tokitech_web
flutter clean
flutter pub get
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
```

Then open `http://localhost:8080/` in your browser once the console prints `lib/main.dart is being served at http://0.0.0.0:8080`.

If you define translation/secret env vars, append `--dart-define` flags to the command above.

```bash
cd tokitech_web
flutter test
```

Both commands currently exercise the login UI, OTP entry screen, and admin dashboard shell (routing + localization chrome). Additional modules should be added in `tokitech_web/lib/features/` following the plan captured in `docs/planDocs/loginAndAdmin/LoginAndAdmin_forntend.md`.

## Viewing the Frontend in GitHub Codespaces

1. Start the dev server inside the Codespace:

	```bash
	cd /workspaces/tokiTech/tokitech_web
	flutter clean
	flutter pub get
	flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
	```

2. Open the **Ports** panel in VS Code → locate port `8080`. Click the lock icon and choose **Public** visibility. This is required so the forwarded URL can fetch `manifest.json` and `web_entrypoint.dart.js` without being redirected through GitHub’s auth proxy.

3. Click the generated `https://*.app.github.dev` link for port `8080`. Wait until the terminal shows `lib/main.dart is being served at http://0.0.0.0:8080` before loading the page.

4. If you must keep the port private, open the forwarded URL once, sign in to GitHub when prompted, and then reload; the goal is to avoid the `github.dev/pf-signin` redirect that blocks the manifest. Public visibility is the easiest workaround.

5. You may see a second forwarded port (random number). That is Flutter’s debug WebSocket endpoint—ignore it; only open the 8080 link.
