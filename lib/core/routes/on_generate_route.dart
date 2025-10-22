import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/routes/route_names.dart';
import 'package:tech_restore/features/auth/login/screen/login_screen.dart';
import 'package:tech_restore/features/auth/register/screen/register_screen.dart';
import 'package:tech_restore/features/onboarding/screen/onboarding_screen.dart';


import '../../features/auth/domain/usecases/sign_up_use_case.dart';
import '../../features/auth/register/viewmodel/register_viewmodel.dart';
import '../config/di.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.startScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegisterCubit(getIt<SignUpUseCase>()),
            child: const RegisterScreen(),
          ),
        );


      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No route defined")),
          ),
        );
    }
  }
}
