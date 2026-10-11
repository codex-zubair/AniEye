import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/root_shell.dart';
import 'state/eye_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AniEyeApp());
}

/// AniEye — a fully offline, ad-free anime watch-order helper.
class AniEyeApp extends StatelessWidget {
  const AniEyeApp({super.key, this.state});

  final EyeState? state;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EyeState>(
      create: (_) => state ?? EyeState(),
      child: MaterialApp(
        title: 'AniEye',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
        home: const RootShell(),
      ),
    );
  }
}
