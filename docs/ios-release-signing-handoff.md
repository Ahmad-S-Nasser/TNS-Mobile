# iOS Release Signing — Handoff

**Status:** Blocked on an Apple Developer Program account. Pick this back up once
that account (and the credentials below) exist.

## Where things stand today

`.github/workflows/mobile-build.yml` has a `build-ios` job that runs
`flutter build ios --release --no-codesign` on `macos-latest`. This proves the
iOS/Swift/CocoaPods side compiles, but it produces an unsigned `Runner.app`,
**not** an installable `.ipa`. Nothing further can be done on iOS signing
without an Apple Developer account — this doc is the checklist for once one
exists.

The `build-android` job in the same workflow already produces a real,
installable APK (signed with the debug key — fine for sideloading/testing, not
for Play Store) — that part needs no further action.

## Before touching CI: fix the placeholder bundle identifiers

Neither platform has been re-branded from the `flutter create` template yet:

| Platform | File | Current value |
|---|---|---|
| iOS | `ios/Runner.xcodeproj/project.pbxproj` (`PRODUCT_BUNDLE_IDENTIFIER`) | `com.example.tipsNSteps` |
| Android | `android/app/build.gradle.kts` (`applicationId`) | `com.example.tips_n_steps` |

`com.example.*` cannot be registered for real distribution. Pick one real,
owned reverse-domain identifier (e.g. `com.tipsnsteps.app`) and use it
consistently on **both** platforms before registering anything with Apple —
changing it later means re-registering the App ID and re-issuing the
provisioning profile.

## What to gather once the Apple Developer account exists

1. **Team ID** — found on [developer.apple.com](https://developer.apple.com/account) under Membership details.
2. **An App ID registered** in the Developer Portal matching the real bundle identifier chosen above.
3. **Signing credentials** — two ways to get these, pick one:
   - **Manual**: create a Distribution certificate in the Developer Portal, download it, export it from Keychain Access as a `.p12` (set a password when exporting — you'll need it later), and create + download an App Store (or Ad Hoc, for direct-install testing) provisioning profile for the App ID.
   - **fastlane match** (recommended if this will be maintained long-term): stores certs/profiles encrypted in a private git repo and syncs them across machines/CI automatically — much less fiddly than hand-managing `.p12` files. See [fastlane match docs](https://docs.fastlane.tools/actions/match/).
4. **An App Store Connect API Key** (recommended over an Apple ID + app-specific password for CI) — create one at [App Store Connect > Users and Access > Integrations](https://appstoreconnect.apple.com/access/integrations/api), download the `.p8` key file once (Apple only shows it once), and note the Key ID and Issuer ID.

## Wiring it into GitHub Actions

Once the above exists, add these as **encrypted repo secrets**
(Settings → Secrets and variables → Actions, on `Ahmad-S-Nasser/TNS-Mobile`):

| Secret name | Contents |
|---|---|
| `IOS_DIST_CERTIFICATE_BASE64` | `base64 -i Certificates.p12` output |
| `IOS_DIST_CERTIFICATE_PASSWORD` | the password set when exporting the `.p12` |
| `IOS_PROVISIONING_PROFILE_BASE64` | `base64 -i YourProfile.mobileprovision` output |
| `APPSTORE_API_KEY_BASE64` | `base64 -i AuthKey_XXXX.p8` output |
| `APPSTORE_API_KEY_ID` | the Key ID from App Store Connect |
| `APPSTORE_API_ISSUER_ID` | the Issuer ID from App Store Connect |

Then change the `build-ios` job in `.github/workflows/mobile-build.yml`:

1. Add a step **before** the build that decodes the cert/profile secrets, imports the `.p12` into a temporary keychain (`security create-keychain` / `security import` / `security list-keychains`), and copies the provisioning profile into `~/Library/MobileDevice/Provisioning Profiles/`.
2. Add an `ExportOptions.plist` to the repo (under `ios/`) describing the export method (`app-store` or `ad-hoc`) and the Team ID.
3. Replace `flutter build ios --release --no-codesign` with:
   ```
   flutter build ipa --export-options-plist=ios/ExportOptions.plist
   ```
4. Change the artifact upload step's `path:` from `build/ios/iphoneos/Runner.app.zip` to `build/ios/ipa/*.ipa`, and drop the now-unnecessary "zip the .app" step.

GitHub Actions' own docs on [encrypted secrets](https://docs.github.com/actions/security-guides/encrypted-secrets) and [Xcode code signing in Actions](https://docs.github.com/actions/deployment/deploying-xcode-applications/installing-an-apple-certificate-on-macos-runners-for-xcode-development) cover the exact keychain-import step commands — that GitHub doc's script can be copied close to verbatim into the new step.

## Simpler alternative worth considering

Hand-rolling the keychain import in raw YAML is fiddly and easy to get subtly
wrong (keychain not unlocked, profile UUID mismatch, etc.). **Codemagic** has
a free tier built specifically for Flutter and a UI for uploading the `.p12`/
profile (or it can auto-provision via App Store Connect API key alone,
skipping manual certs entirely) — worth trying first if this keeps being
troublesome by hand.

## Next steps checklist

- [ ] Get Apple Developer Program membership ($99/yr)
- [ ] Decide the real bundle identifier and update both `project.pbxproj` and `build.gradle.kts`
- [ ] Register the App ID in the Developer Portal
- [ ] Generate distribution cert + provisioning profile (manual or fastlane match)
- [ ] Create an App Store Connect API key
- [ ] Add the 6 secrets above to the `TNS-Mobile` repo
- [ ] Add `ios/ExportOptions.plist`
- [ ] Update `build-ios` job to import signing assets and run `flutter build ipa`
- [ ] Verify a real signed `.ipa` comes out of the Actions artifact
