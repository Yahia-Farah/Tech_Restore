import '../../../data/models/review_response.dart';

abstract class GetReviewsState {}

class GetReviewsInitial extends GetReviewsState {}

class GetReviewsLoading extends GetReviewsState {}

class GetReviewsLoaded extends GetReviewsState {
  final ReviewListResponse reviews;
  GetReviewsLoaded(this.reviews);
}

class GetReviewsError extends GetReviewsState {
  final String message;
  GetReviewsError(this.message);
}

class ReviewDeleted extends GetReviewsState {
  final String message;
  ReviewDeleted(this.message);
}