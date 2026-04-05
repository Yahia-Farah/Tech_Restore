import 'package:injectable/injectable.dart';
import '../datasource/get_reviews_data_source_impl.dart';
import '../models/review_response.dart';

@lazySingleton
class GetReviewsRepository {
  final GetReviewsRemoteDataSource _remoteDataSource;

  GetReviewsRepository(this._remoteDataSource);

  Future<ReviewListResponse> getReviews() async {
    return await _remoteDataSource.getReviews();
  }

  Future<String> deleteReview(String reviewId) async {
    return await _remoteDataSource.deleteReview(reviewId);
  }
}