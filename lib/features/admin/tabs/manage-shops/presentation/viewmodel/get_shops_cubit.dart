import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/states/get_shops_states.dart';
import '../../data/repo/get_shops_repo.dart';
import '../../../domain/usecases/approve_shop_usecase.dart';
import '../../../domain/usecases/suspend_shop_usecase.dart';

@injectable
class GetShopsCubit extends Cubit<GetShopsState> {
  final GetShopsRepository _repository;
  final ApproveShopUseCase _approveShopUseCase;
  final SuspendShopUseCase _suspendShopUseCase;

  GetShopsCubit(
    this._repository,
    this._approveShopUseCase,
    this._suspendShopUseCase,
  ) : super(GetShopsInitial());

  Future<void> getAllShops() async {
    emit(GetShopsLoading());
    try {
      final shops = await _repository.getShops();
      emit(GetShopsLoaded(shops));
    } catch (e) {
      emit(GetShopsError(e.toString()));
    }
  }

  Future<void> approveShop(String shopId) async {
    try {
      final message = await _approveShopUseCase(shopId);
      emit(ShopApproved(message));
      await getAllShops();
    } catch (e) {
      emit(GetShopsError(e.toString()));
    }
  }

  Future<void> suspendShop(String shopId) async {
    try {
      final message = await _suspendShopUseCase(shopId);
      emit(ShopSuspended(message));
      await getAllShops();
    } catch (e) {
      emit(GetShopsError(e.toString()));
    }
  }
}



