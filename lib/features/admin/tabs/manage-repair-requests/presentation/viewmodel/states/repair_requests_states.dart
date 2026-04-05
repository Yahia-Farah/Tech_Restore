import '../../../data/models/repair_request_model.dart';

abstract class RepairRequestsStates {}

class RepairRequestsInitial extends RepairRequestsStates {}

class RepairRequestsLoading extends RepairRequestsStates {}

class RepairRequestsSuccess extends RepairRequestsStates {
  final RepairRequestModel repairRequests;

  RepairRequestsSuccess(this.repairRequests);
}

class RepairRequestsError extends RepairRequestsStates {
  final String message;

  RepairRequestsError(this.message);
}
