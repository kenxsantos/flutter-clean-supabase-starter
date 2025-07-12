# 🚀 Flutter Starter App – Setup Instructions

This guide helps you set up the starter app project with Supabase authentication (Google & Facebook) from scratch.

---

## 📁 Project Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/flutter-clean-supabase-starter.git
   cd flutter-clean-supabase-starter
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

---

## 🧪 Supabase Setup

1. **Create a project on [Supabase](https://supabase.com).**

2. **Go to your project's settings > API** and copy:

   * `SUPABASE_URL`
   * `SUPABASE_ANON_KEY`

3. **Enable Auth Providers:**

   * Go to `Authentication > Providers`.
   * Enable **Google** and **Facebook**, and provide their respective credentials.

---

## 🔐 .env Setup

Create a `.env` file at the root of your project:

```env
SUPABASE_URL=your-supabase-url
SUPABASE_ANON_KEY=your-anon-key

GOOGLE_WEB_CLIENT_ID=your-google-web-client-id
GOOGLE_IOS_CLIENT_ID=your-google-ios-client-id

```

---

## 🤭 Android Configuration

Edit your `android/app/src/main/AndroidManifest.xml` and add this inside `<activity>`:

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="com.presyowise"
        android:host="auth-callback" />
</intent-filter>
```

---

## ☁️ Google Cloud Console

1. Go to [Google Cloud Console](https://console.cloud.google.com/).
2. Create a project or use an existing one.
3. Go to **APIs & Services > Credentials**.
4. Click **Create Credentials > OAuth Client ID**:

   * Create each Application Type: **Android**, **Web**, **IOS**
   * Provide your **SHA-1** certificate fingerprint (use `./gradlew signingReport` in Android Studio).
   * Add your Android package name (e.g., `com.example.app`).
5. Folow this step [Sign in with Google](https://supabase.com/docs/guides/auth/social-login/auth-google?queryGroups=platform&platform=flutter&queryGroups=environment&environment=client).
6. Add **Authorized redirect URI** in Supabase:

   ```
   <package-name>://auth-callback
   ```

---

## 📘 Facebook App Setup

1. Go to [Facebook for Developers](https://developers.facebook.com/).

2. Follow the Supabase [Login with Facebook](https://supabase.com/docs/guides/auth/social-login/auth-facebook?queryGroups=language&language=flutter&queryGroups=environment&environment=client).

---

## 🧠 Supabase Auth Configuration

In your `auth_datasource.dart`, ensure you handle social sign-in:

```dart
  Future<AuthResponse> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      clientId: _iosClientId,
      serverClientId: _webClientId,
    );

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception("User cancelled sign in");

    final googleAuth = await googleUser.authentication;

    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw Exception("Missing Google Auth Tokens");
    }

    return _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken!,
    );
  }
```

For Facebook:

```dart
  Future<bool> signInWithFacebook() async {
    return await _supabase.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: kIsWeb
          ? 'https://<project-ref>.supabase.co/auth/v1/callback'
          : '<package-name>://auth-callback',
      authScreenLaunchMode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
  }
```

---

## 📦 Run the App

```bash
flutter pub get
flutter run
```

---

## ✅ Troubleshooting Tips

* Make sure your Supabase project has social login providers **enabled**.
* Ensure all redirect URLs are added in both Supabase and the third-party providers.
* Confirm that your SHA-1 key and Android package name are correct in Google Console.
* If `flutter pub get` fails, try running `flutter clean` then retry.

---

## 🛠️ Tech Stack

* Flutter
* Supabase (Auth, DB)
* Google & Facebook OAuth2
* dotenv for config management

---
