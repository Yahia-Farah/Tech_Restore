import 'package:flutter/material.dart';
import 'package:tech_restore/ui/home/screen/home_screen.dart';
import 'package:tech_restore/ui/login/screen/login_screen.dart';
import 'package:tech_restore/ui/register/screen/register_screen.dart';
import 'package:tech_restore/ui/start_screen/screen/start_screen.dart' show StartScreen;
import 'core/color_manager.dart';
import 'core/l10n/translation/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale("en"),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorManager.background,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
      )
      ),
      routes: {
        StartScreen.routeName:(_)=>StartScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.routename:(_)=>HomeScreen(),
      },
      initialRoute: StartScreen.routeName,
    );
  }
}
