# AniEye

**Which order should I watch it? AniEye is a fully offline anime watch-order
guide.**

AniEye is a small, single-purpose Android reference app: pick a series and see
its recommended viewing order — seasons, arcs, films and optional entries,
numbered step by step. No backend, **no permissions, no INTERNET permission**,
no ads, no analytics, and it stores no data at all.

- Package: `com.animeye.watchanimetv`
- Privacy policy: https://codex-zubair.github.io/all_privacy_policy/animeye/
- Category: Entertainment
- Platform: Android (min SDK 24)

## Features

- **14 popular series** with step-by-step watch orders (Monogatari, Fate,
  Haruhi, JoJo, Gintama, One Piece, Studio Ghibli, and more).
- **89 numbered steps** with order types (release, season, part, saga).
- **Optional steps** (films/OVAs/spinoffs) clearly flagged.
- **Instant search** by series name.
- **Zero permissions**, no network, no ads, no tracking, no stored data.

## Privacy

- No `INTERNET` permission (removed at build time).
- No Android permissions requested at all.
- The app writes nothing to disk — no history, no profile.

## Architecture

```
lib/
  core/       Pure Dart: models, catalogue, lookup/search engine
  state/      EyeState (ChangeNotifier + provider)
  screens/    root_shell, series_list, detail, about
  widgets/    brand
  theme/      app_theme
```

`lib/core` has no Flutter imports, so the data and search logic are fully
unit-testable.

## Development

```bash
flutter pub get
flutter analyze          # 0 issues
flutter test             # 12 tests
flutter run

flutter build appbundle --release   # AAB for Play
flutter build apk --release         # APK for sideload
```

Generate branding and store graphics:

```bash
python3 tool/gen_icons.py
dart run flutter_launcher_icons
dart run flutter_native_splash:create
python3 tool/make_graphics.py
```

## License

MIT — see [LICENSE](LICENSE).
