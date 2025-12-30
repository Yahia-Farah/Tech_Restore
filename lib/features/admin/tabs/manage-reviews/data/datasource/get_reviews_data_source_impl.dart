import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../models/review_response.dart';

@lazySingleton
class GetReviewsRemoteDataSource {
  final ApiClient _apiClient;

  GetReviewsRemoteDataSource(this._apiClient);

  Future<ReviewListResponse> getReviews() async {
    return await _apiClient.getReviews();
  }

  Future<String> deleteReview(String reviewId) async {
    return await _apiClient.deleteReview(reviewId);
  }
}