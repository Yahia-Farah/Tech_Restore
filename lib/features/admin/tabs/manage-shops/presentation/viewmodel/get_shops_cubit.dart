import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/states/get_shops_states.dart';
import '../../data/repo/get_shops_repo.dart';

@injectable
class GetShopsCubit extends Cubit<GetShopsState> {
  final GetShopsRepository _repository;

  GetShopsCubit(this._repository) : super(GetShopsInitial());

  Future<void> getAllShops() async {
    emit(GetShopsLoading());
    try {
      final shops = await _repository.getShops();
      emit(GetShopsLoaded(shops));
    } catch (e) {
      emit(GetShopsError(e.toString()));
    }
  }
}

