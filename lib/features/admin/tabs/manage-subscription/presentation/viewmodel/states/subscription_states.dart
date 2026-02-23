import '../../../../data/model/subscription-model/subscription_response.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final SubscriptionResponse subscriptions;

  SubscriptionLoaded(this.subscriptions);
}

class SubscriptionError extends SubscriptionState {
  final String message;

  SubscriptionError(this.message);
}
