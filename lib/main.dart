import 'package:flutter/material.dart';
import 'core/color_manager.dart';
import 'core/l10n/translation/app_localizations.dart';
import 'features/auth/login/screen/login_screen.dart';
import 'features/auth/register/screen/register_screen.dart';
import 'features/onboarding/screen/onboarding_screen.dart';
import 'features/user/home/screen/home_screen.dart';

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
        OnboardingScreen.routeName:(_)=>OnboardingScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.routename:(_)=>HomeScreen(),
      },
      initialRoute: OnboardingScreen.routeName,
    );
  }
}
