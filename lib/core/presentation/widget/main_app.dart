import 'package:drink_picker/core/presentation/theme/theme.dart';
import 'package:drink_picker/core/presentation/widget/debug_or_release_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: PlaifTheme.light,
        darkTheme: PlaifTheme.dark,
        themeMode: ThemeMode.system,
        home: const DebugOrReleaseScreen(),
      ),
    );
  }
}
