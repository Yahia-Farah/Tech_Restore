import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/admin/tabs/manage-reviews/presentation/viewmodel/states/get_reviews_states.dart';
import '../../data/repo/get_reviews_repo.dart';
import '../../domain/usecases/delete_review_usecase.dart';

@injectable
class GetReviewsCubit extends Cubit<GetReviewsState> {
  final GetReviewsRepository _repository;
  final DeleteReviewUseCase _deleteReviewUseCase;

  GetReviewsCubit(
    this._repository,
    this._deleteReviewUseCase,
  ) : super(GetReviewsInitial());

  Future<void> getAllReviews() async {
    emit(GetReviewsLoading());
    try {
      final reviews = await _repository.getReviews();
      emit(GetReviewsLoaded(reviews));
    } catch (e) {
      emit(GetReviewsError(e.toString()));
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      final message = await _deleteReviewUseCase(reviewId);
      emit(ReviewDeleted(message));
      await getAllReviews();
    } catch (e) {
      emit(GetReviewsError(e.toString()));
    }
  }
}