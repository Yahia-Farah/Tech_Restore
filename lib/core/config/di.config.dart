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

import '../../features/admin/tabs/api/datasource_impl/admin_remote_data_source_impl.dart'
    as _i702;
import '../../features/admin/tabs/data/datasource/admin_remote_datasource.dart'
    as _i532;
import '../../features/admin/tabs/data/repo_impl/admin_repo_impl.dart' as _i737;
import '../../features/admin/tabs/domain/repo/admin_repo.dart' as _i253;
import '../../features/admin/tabs/domain/usecases/activate_user_usecase.dart'
    as _i839;
import '../../features/admin/tabs/domain/usecases/add_category_usecase.dart'
    as _i733;
import '../../features/admin/tabs/domain/usecases/admin_states_usecase.dart'
    as _i902;
import '../../features/admin/tabs/domain/usecases/approve_shop_usecase.dart'
    as _i634;
import '../../features/admin/tabs/domain/usecases/deactivate_user_usecase.dart'
    as _i217;
import '../../features/admin/tabs/domain/usecases/delete_category_usecase.dart'
    as _i886;
import '../../features/admin/tabs/domain/usecases/get_all_categories_usecase.dart'
    as _i953;
import '../../features/admin/tabs/domain/usecases/get_all_deliveries_usecase.dart'
    as _i411;
import '../../features/admin/tabs/domain/usecases/get_all_subscriptions_usecase.dart'
    as _i653;
import '../../features/admin/tabs/domain/usecases/get_all_transactions_usecase.dart'
    as _i575;
import '../../features/admin/tabs/domain/usecases/get_delivery_by_id_usecase.dart'
    as _i1055;
import '../../features/admin/tabs/domain/usecases/get_pending_cash_subscriptions_usecase.dart'
    as _i842;
import '../../features/admin/tabs/domain/usecases/suspend_shop_usecase.dart'
    as _i57;
import '../../features/admin/tabs/domain/usecases/update_category_usecase.dart'
    as _i982;
import '../../features/admin/tabs/domain/usecases/update_user_role_usecase.dart'
    as _i586;
import '../../features/admin/tabs/manage-categories/presentation/viewmodel/categories_cubit.dart'
    as _i652;
import '../../features/admin/tabs/manage-dashboard/presentation/viewmodel/admin_stats_cubit.dart'
    as _i80;
import '../../features/admin/tabs/manage-delivery/presentation/viewmodel/deliveries_cubit.dart'
    as _i954;
import '../../features/admin/tabs/manage-reviews/data/datasource/get_reviews_data_source_impl.dart'
    as _i456;
import '../../features/admin/tabs/manage-reviews/data/repo/get_reviews_repo.dart'
    as _i764;
import '../../features/admin/tabs/manage-reviews/domain/usecases/delete_review_usecase.dart'
    as _i45;
import '../../features/admin/tabs/manage-reviews/presentation/viewmodel/get_reviews_cubit.dart'
    as _i381;
import '../../features/admin/tabs/manage-shops/data/datasource/get_shops_data_source_impl.dart'
    as _i392;
import '../../features/admin/tabs/manage-shops/data/repo/get_shops_repo.dart'
    as _i63;
import '../../features/admin/tabs/manage-shops/presentation/viewmodel/get_shops_cubit.dart'
    as _i697;
import '../../features/admin/tabs/manage-subscription/presentation/viewmodel/subscription_cubit.dart'
    as _i58;
import '../../features/admin/tabs/manage-transaction/presentation/viewmodel/transactions_cubit.dart'
    as _i691;
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
import '../../features/auth/domain/usecases/assigner_signup_usecase.dart'
    as _i68;
import '../../features/auth/domain/usecases/delivery_signup_usecase.dart'
    as _i77;
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
import '../../features/shop/data/data_source/shop_remote_datasource.dart'
    as _i622;
import '../../features/shop/data/repositories/shop_repository.dart' as _i57;
import '../../features/shop/presentation/viewmodel/notifications_cubit.dart'
    as _i335;
import '../../features/shop/presentation/viewmodel/shop_chat_cubit.dart'
    as _i453;
import '../../features/shop/presentation/viewmodel/transactions_cubit.dart'
    as _i225;
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
    gh.lazySingleton<_i532.AdminRemoteDataSource>(
        () => _i702.AdminRemoteDataSourceImpl(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i456.GetReviewsRemoteDataSource>(
        () => _i456.GetReviewsRemoteDataSource(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i392.GetShopsRemoteDataSource>(
        () => _i392.GetShopsRemoteDataSource(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i508.GetUserRemoteDataSource>(
        () => _i508.GetUserRemoteDataSource(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i622.ShopRemoteDataSource>(
        () => _i622.ShopRemoteDataSource(gh<_i364.ApiClient>()));
    gh.lazySingleton<_i904.ProfileRemoteDataSource>(
        () => _i904.ProfileRemoteDataSource(gh<_i364.ApiClient>()));
    gh.factory<_i341.ResetPasswordCubit>(
        () => _i341.ResetPasswordCubit(gh<_i364.ApiClient>()));
    gh.factory<_i253.AdminRepo>(
        () => _i737.AdminRepoImpl(gh<_i532.AdminRemoteDataSource>()));
    gh.lazySingleton<_i57.ShopRepository>(
        () => _i57.ShopRepository(gh<_i622.ShopRemoteDataSource>()));
    gh.factory<_i839.ActivateUserUseCase>(
        () => _i839.ActivateUserUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i733.AddCategoryUseCase>(
        () => _i733.AddCategoryUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i902.AdminStatesUseCase>(
        () => _i902.AdminStatesUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i217.DeactivateUserUseCase>(
        () => _i217.DeactivateUserUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i886.DeleteCategoryUseCase>(
        () => _i886.DeleteCategoryUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i953.GetAllCategoriesUseCase>(
        () => _i953.GetAllCategoriesUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i411.GetAllDeliveriesUseCase>(
        () => _i411.GetAllDeliveriesUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i575.GetAllTransactionsUseCase>(
        () => _i575.GetAllTransactionsUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i1055.GetDeliveryByIdUseCase>(
        () => _i1055.GetDeliveryByIdUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i982.UpdateCategoryUseCase>(
        () => _i982.UpdateCategoryUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i586.UpdateUserRoleUseCase>(
        () => _i586.UpdateUserRoleUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i653.GetAllSubscriptionsUseCase>(
        () => _i653.GetAllSubscriptionsUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i842.GetPendingCashSubscriptionsUseCase>(
        () => _i842.GetPendingCashSubscriptionsUseCase(gh<_i253.AdminRepo>()));
    gh.factory<_i652.CategoriesCubit>(() => _i652.CategoriesCubit(
          gh<_i953.GetAllCategoriesUseCase>(),
          gh<_i733.AddCategoryUseCase>(),
          gh<_i982.UpdateCategoryUseCase>(),
          gh<_i886.DeleteCategoryUseCase>(),
        ));
    gh.factory<_i80.AdminStatsCubit>(
        () => _i80.AdminStatsCubit(gh<_i902.AdminStatesUseCase>()));
    gh.lazySingleton<_i890.ProfileRepository>(
        () => _i890.ProfileRepository(gh<_i904.ProfileRemoteDataSource>()));
    gh.lazySingleton<_i170.AuthRepository>(
        () => _i279.AuthRepositoryImpl(gh<_i24.AuthRemoteDataSource>()));
    gh.factory<_i335.NotificationsCubit>(
        () => _i335.NotificationsCubit(gh<_i57.ShopRepository>()));
    gh.factory<_i453.ShopChatCubit>(
        () => _i453.ShopChatCubit(gh<_i57.ShopRepository>()));
    gh.factory<_i225.TransactionsCubit>(
        () => _i225.TransactionsCubit(gh<_i57.ShopRepository>()));
    gh.lazySingleton<_i680.GetUserRepository>(
        () => _i680.GetUserRepository(gh<_i508.GetUserRemoteDataSource>()));
    gh.lazySingleton<_i63.GetShopsRepository>(
        () => _i63.GetShopsRepository(gh<_i392.GetShopsRemoteDataSource>()));
    gh.lazySingleton<_i764.GetReviewsRepository>(() =>
        _i764.GetReviewsRepository(gh<_i456.GetReviewsRemoteDataSource>()));
    gh.factory<_i48.LogoutUseCase>(
        () => _i48.LogoutUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i30.VerifyEmailUseCase>(
        () => _i30.VerifyEmailUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i954.DeliveriesCubit>(() => _i954.DeliveriesCubit(
          gh<_i411.GetAllDeliveriesUseCase>(),
          gh<_i1055.GetDeliveryByIdUseCase>(),
        ));
    gh.factory<_i691.TransactionsCubit>(
        () => _i691.TransactionsCubit(gh<_i575.GetAllTransactionsUseCase>()));
    gh.factory<_i948.ForgetPasswordUseCase>(
        () => _i948.ForgetPasswordUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i474.ResetPasswordUseCase>(
        () => _i474.ResetPasswordUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i294.VerifyCodeUseCase>(
        () => _i294.VerifyCodeUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i68.AssignerSignupUseCase>(
        () => _i68.AssignerSignupUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i77.DeliverySignUpUseCase>(
        () => _i77.DeliverySignUpUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i188.LoginUseCase>(
        () => _i188.LoginUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i80.SignUpUseCase>(
        () => _i80.SignUpUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i1037.SignUpUseCase>(
        () => _i1037.SignUpUseCase(gh<_i170.AuthRepository>()));
    gh.factory<_i58.SubscriptionCubit>(() => _i58.SubscriptionCubit(
          gh<_i653.GetAllSubscriptionsUseCase>(),
          gh<_i842.GetPendingCashSubscriptionsUseCase>(),
        ));
    gh.factory<_i45.DeleteReviewUseCase>(
        () => _i45.DeleteReviewUseCase(gh<_i764.GetReviewsRepository>()));
    gh.factory<_i327.EditProfileCubit>(
        () => _i327.EditProfileCubit(gh<_i890.ProfileRepository>()));
    gh.factory<_i1061.ProfileCubit>(
        () => _i1061.ProfileCubit(gh<_i890.ProfileRepository>()));
    gh.factory<_i164.ForgetPasswordCubit>(
        () => _i164.ForgetPasswordCubit(gh<_i948.ForgetPasswordUseCase>()));
    gh.factory<_i634.ApproveShopUseCase>(
        () => _i634.ApproveShopUseCase(gh<_i63.GetShopsRepository>()));
    gh.factory<_i57.SuspendShopUseCase>(
        () => _i57.SuspendShopUseCase(gh<_i63.GetShopsRepository>()));
    gh.factory<_i146.LoginViewModel>(
        () => _i146.LoginViewModel(gh<_i188.LoginUseCase>()));
    gh.factory<_i697.GetShopsCubit>(() => _i697.GetShopsCubit(
          gh<_i63.GetShopsRepository>(),
          gh<_i634.ApproveShopUseCase>(),
          gh<_i57.SuspendShopUseCase>(),
        ));
    gh.factory<_i524.GetUsersCubit>(() => _i524.GetUsersCubit(
          gh<_i680.GetUserRepository>(),
          gh<_i586.UpdateUserRoleUseCase>(),
          gh<_i217.DeactivateUserUseCase>(),
          gh<_i839.ActivateUserUseCase>(),
        ));
    gh.factory<_i71.LogoutViewModel>(
        () => _i71.LogoutViewModel(gh<_i48.LogoutUseCase>()));
    gh.factory<_i215.VerifyCodeCubit>(() => _i215.VerifyCodeCubit(
          gh<_i294.VerifyCodeUseCase>(),
          gh<_i30.VerifyEmailUseCase>(),
        ));
    gh.factory<_i381.GetReviewsCubit>(() => _i381.GetReviewsCubit(
          gh<_i764.GetReviewsRepository>(),
          gh<_i45.DeleteReviewUseCase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i484.DioModule {}
