import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/routes/route_names.dart';
import 'package:tech_restore/features/admin/admin_layout.dart';
import 'package:tech_restore/features/auth/login/screen/login_screen.dart';
import 'package:tech_restore/features/auth/register/screen/register_screen.dart';
import 'package:tech_restore/features/onboarding/screen/onboarding_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/shop_layout.dart';
import 'package:tech_restore/features/user/home/screen/home_screen.dart';
import 'package:tech_restore/features/user/profile/data/models/profile_response.dart';
import 'package:tech_restore/features/user/profile/presentation/view/screens/edit_profile_screen.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_use_case.dart' as user_signup;
import '../../features/auth/domain/usecases/shop_signup_usecase.dart' as shop_signup;
import '../../features/auth/domain/usecases/delivery_signup_usecase.dart' as delivery_signup;
import '../../features/auth/domain/usecases/assigner_signup_usecase.dart' as assigner_signup;
import '../../features/auth/forget_password/presentation/viewmodel/forget_password_viewmodel.dart';
import '../../features/auth/forget_password/presentation/viewmodel/reset_password_viewmodel.dart';
import '../../features/auth/forget_password/presentation/viewmodel/verify_code_viewmodel.dart';
import '../../features/auth/forget_password/presentation/views/screens/ResetPasswordScreen.dart';
import '../../features/auth/forget_password/presentation/views/screens/email_verificationScreen.dart';
import '../../features/auth/forget_password/presentation/views/screens/forgertPasswordScreen.dart';
import '../../features/auth/login/viewmodel/login_viewmodel.dart';
import '../../features/auth/register/screen/assigner_register_screen.dart';
import '../../features/auth/register/screen/delivery_register_screen.dart';
import '../../features/auth/register/screen/shop_register_screen.dart';
import '../../features/auth/register/viewmodel/assigner_register_viewmodel.dart';
import '../../features/auth/register/viewmodel/delivery_register_viewmodel.dart';
import '../../features/auth/register/viewmodel/register_viewmodel.dart';
import '../../features/auth/register/viewmodel/shop_register_viewmodel.dart';
import '../../features/delivery/delivery-main.dart';
import '../../features/user/profile/presentation/viewmodel/edit_profile_cubit.dart';
import '../config/di.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.startScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.login:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => LoginViewModel(getIt<LoginUseCase>()),
                child: const LoginScreen(),
              ),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => RegisterCubit(getIt<user_signup.SignUpUseCase>()),
                child: const RegisterScreen(),
              ),
        );

      case AppRoutes.shopRegister:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ShopRegisterCubit(getIt<shop_signup.SignUpUseCase>()),
            child: const ShopRegisterScreen(),
          ),
        );

      case AppRoutes.deliveryRegister:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => DeliveryRegisterCubit(getIt<delivery_signup.DeliverySignUpUseCase>()),
            child: const DeliveryRegisterScreen(),
          ),
        );

      case AppRoutes.assignerRegister:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AssignerRegisterCubit(getIt<assigner_signup.AssignerSignupUseCase>()),
            child: const AssignerRegisterScreen(),
          ),
        );

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (_) => getIt<ForgetPasswordCubit>(),
                child: const ForgetPasswordScreen(),
              ),
        );

      case AppRoutes.emailVerification:
        final args = settings.arguments as VerifyEmailData;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (_) => getIt<VerifyCodeCubit>(),
                child: EmailVerificationScreen(
                  email: args.email,
                  isRegister: args.isRegister,
                ),
              ),
        );

      case AppRoutes.resetPassword:
        final args = settings.arguments as ResetPasswordData;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (_) => getIt<ResetPasswordCubit>(),
                child: ResetPasswordScreen(email: args.email, code: args.code),
              ),
        );

      case AppRoutes.userHome:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminLayout());

      case AppRoutes.shopDashboard:
        return MaterialPageRoute(builder: (_) => const ShopLayout());

      case AppRoutes.deliveryDashboard:
        return MaterialPageRoute(builder: (_) => const DeliveryDashboardScreen());

      case AppRoutes.editProfile:
        final user = settings.arguments as ProfileResponse;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<EditProfileCubit>()..setInitialData(user),
            child: EditProfileScreen(user: user),
          ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
