// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/admin/tabs/manage-user/data/datasource/get_user_remote_data_source_impl.dart'
    as _i508;
import '../../features/admin/tabs/manage-user/data/repo/get_user_repo_impl.dart'
    as _i680;
import '../../features/admin/tabs/manage-user/presentation/viewmodel/get_users_cubit.dart'
    as _i524;
import '../../features/auth/api/datasource_impl/auth_remote_data_source_impl.dart'
    as _i504;
import '../../features/auth/data/datasource/auth_remote_data_source.dart'
    as _i24;
import '../../features/auth/data/repo_impl/auth_repo_impl.dart' as _i279;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/usecases/forget_password_usecase.dart'
    as _i948;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/reset_password_usecase.dart'
    as _i474;
import '../../features/auth/domain/usecases/shop_signup_usecase.dart' as _i80;
import '../../features/auth/domain/usecases/sign_up_use_case.dart' as _i1037;
import '../../features/auth/domain/usecases/verify_code_usecase.dart' as _i294;
import '../../features/auth/domain/usecases/verify_email_usecase.dart' as _i30;
import '../../features/auth/forget_password/presentation/viewmodel/forget_password_viewmodel.dart'
    as _i164;
import '../../features/auth/forget_password/presentation/viewmodel/reset_password_viewmodel.dart'
    as _i341;
import '../../features/auth/forget_password/presentation/viewmodel/verify_code_viewmodel.dart'
    as _i215;
import '../../features/auth/login/viewmodel/login_viewmodel.dart' as _i146;
import '../../features/auth/logout/viewmodel/logout_viewmodel.dart' as _i71;
import '../../features/user/profile/data/data_sources/profile_remote_data_source_impl.dart'
    as _i904;
import '../../features/user/profile/data/repositories/profile_repo_impl.dart'
    as _i890;
import '../../features/user/profile/presentation/viewmodel/edit_profile_cubit.dart'
    as _i327;
import '../../features/user/profile/presentation/viewmodel/profile_cubit.dart'
    as _i1061;
import '../api/client/api_client.dart' as _i364;
import 'dio_module/dio_module.dart' as _i484;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<String>(
      () => dioModule.baseUrl,
      instanceName: 'baseurl',
    );
    gh.lazySingleton<_i361.Dio>(
        () => dioModule.dio(gh<String>(instanceName: 'baseurl')));
    gh.factory<_i364.ApiClient>(() => _i364.ApiClient(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'baseurl'),
        ));
    gh.lazySingleton<_i24.AuthRemoteDataSource>(
        () => _i504.AuthRemoteDatasourceImpl(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i904.ProfileRemoteDataSource>(
        () => _i904.ProfileRemoteDataSource(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i508.GetUserRemoteDataSource>(
        () => _i508.GetUserRemoteDataSource(gh<_i364.ApiClient>()));
    gh.factory<_i341.ResetPasswordCubit>(
        () => _i341.ResetPasswordCubit(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i890.ProfileRepository>(
        () => _i890.ProfileRepository(gh<_i904.ProfileRemoteDataSource>()));
    gh.lazySingleton<_i170.AuthRepository>(
        () => _i279.AuthRepositoryImpl(gh<_i24.AuthRemoteDataSource>()));
    gh.lazySingleton<_i680.GetUserRepository>(
        () => _i680.GetUserRepository(gh<_i508.GetUserRemoteDataSource>()));
    gh.factory<_i48.LogoutUseCase>(
        () => _i48.LogoutUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i30.VerifyEmailUseCase>(
        () => _i30.VerifyEmailUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i948.ForgetPasswordUseCase>(
        () => _i948.ForgetPasswordUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i474.ResetPasswordUseCase>(
        () => _i474.ResetPasswordUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i294.VerifyCodeUseCase>(
        () => _i294.VerifyCodeUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i1037.SignUpUseCase>(
        () => _i1037.SignUpUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i188.LoginUseCase>(
        () => _i188.LoginUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i80.SignUpUseCase>(
        () => _i80.SignUpUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i524.GetUsersCubit>(
        () => _i524.GetUsersCubit(gh<_i680.GetUserRepository>()));
    gh.factory<_i1061.ProfileCubit>(
        () => _i1061.ProfileCubit(gh<_i890.ProfileRepository>()));
    gh.factory<_i327.EditProfileCubit>(
        () => _i327.EditProfileCubit(gh<_i890.ProfileRepository>()));
    gh.factory<_i164.ForgetPasswordCubit>(
        () => _i164.ForgetPasswordCubit(gh<_i948.ForgetPasswordUseCase>()));
    gh.factory<_i146.LoginViewModel>(
        () => _i146.LoginViewModel(gh<_i188.LoginUseCase>()));
    gh.factory<_i71.LogoutViewModel>(
        () => _i71.LogoutViewModel(gh<_i48.LogoutUseCase>()));
    gh.factory<_i215.VerifyCodeCubit>(() => _i215.VerifyCodeCubit(
          gh<_i294.VerifyCodeUseCase>(),
          gh<_i30.VerifyEmailUseCase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i484.DioModule {}
