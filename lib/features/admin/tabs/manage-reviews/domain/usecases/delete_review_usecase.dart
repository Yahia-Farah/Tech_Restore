import 'package:injectable/injectable.dart';
import '../../data/repo/get_reviews_repo.dart';

@injectable
class DeleteReviewUseCase {
  final GetReviewsRepository _repository;

  DeleteReviewUseCase(this._repository);

  Future<String> call(String reviewId) async {
    return await _repository.deleteReview(reviewId);
  }
}