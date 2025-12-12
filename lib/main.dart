import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/config/di.dart';
import 'package:tech_restore/core/theme/app_theme.dart';
import 'core/contants/secure_storage.dart';
import 'core/l10n/translation/app_localizations.dart';
import 'core/routes/on_generate_route.dart';
import 'core/theme/app_colors.dart';
import 'features/auth/logout/viewmodel/app_navigator.dart';
import 'features/localization/data/localization_preference.dart';
import 'features/localization/localization_controller/localization_cubit.dart';
import 'features/localization/localization_controller/localization_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecureStorage.initialize();
  await configureDependencies();
  String savedLang = await LocalizationPreference.getLanguage();

  runApp(
    BlocProvider(
      create:
          (_) =>
              LocalizationCubit(language: savedLang == "ar" ? "ar" : "en")
                ..selectLanguage(savedLang == "ar" ? "Arabic" : "English"),
      child: const MyApp(initialRoute: "/start"),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        Locale currentLocale;

        if (state is ArabicLanguage) {
          currentLocale = const Locale("ar");
        } else {
          currentLocale = const Locale("en");
        }

        return MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          title: 'Tech Restore',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.lightTheme,
          initialRoute: initialRoute,
          onGenerateRoute: Routes.onGenerateRoute,
        );
      },
    );
  }
}
