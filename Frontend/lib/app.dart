import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redact/utils/Themes/theme.dart';
import 'package:redact/utils/Themes/theme_provider.dart';
import './UIs/SplashScreen/SplashScreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.theme,
            theme: FAppTheme.lightTheme,
            darkTheme: FAppTheme.darkTheme,
            home: const SplashScreen(),
          );
        }
    );
  }
}
