import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redact/utils/Themes/theme_model.dart';
import 'package:redact/utils/Themes/theme_provider.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final themeModel = ThemeModel();
  await themeModel.loadThemePreference();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeModel),
        ChangeNotifierProvider(create: (_) => ThemeProvider(themeModel)),
      ],
      child: const App(),
    ),
  );
}
