import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_all_repair_requests_usecase.dart';
import '../../domain/usecases/get_repair_requests_by_status_usecase.dart';
import 'states/repair_requests_states.dart';

@injectable
class RepairRequestsCubit extends Cubit<RepairRequestsStates> {
  final GetAllRepairRequestsUseCase _getAllRepairRequestsUseCase;
  final GetRepairRequestsByStatusUseCase _getRepairRequestsByStatusUseCase;

  RepairRequestsCubit(
    this._getAllRepairRequestsUseCase,
    this._getRepairRequestsByStatusUseCase,
  ) : super(RepairRequestsInitial());

  String _extractErrorMessage(dynamic error) {
    if (error is Exception) {
      final message = error.toString();
      if (message.startsWith('Exception: ')) {
        return message.substring(11); // Remove 'Exception: ' prefix
      }
      return message;
    }
    return error.toString();
  }

  Future<void> getAllRepairRequests(int page) async {
    emit(RepairRequestsLoading());
    try {
      final result = await _getAllRepairRequestsUseCase.call(page);
      emit(RepairRequestsSuccess(result));
    } catch (e) {
      emit(RepairRequestsError(_extractErrorMessage(e)));
    }
  }

  Future<void> getRepairRequestsByStatus(String status, int page) async {
    emit(RepairRequestsLoading());
    try {
      final result = await _getRepairRequestsByStatusUseCase.call(status, page);
      emit(RepairRequestsSuccess(result));
    } catch (e) {
      emit(RepairRequestsError(_extractErrorMessage(e)));
    }
  }
}
