import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../../../../../../core/errors/failure.dart';
import '../models/review_response.dart';

@lazySingleton
class GetReviewsRemoteDataSource {
  final ApiClient _apiClient;

  GetReviewsRemoteDataSource(this._apiClient);

  String _extractApiMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['error'] ??
          data['message'] ??
          ServerFailure.fromDio(e).errorMessage;
    }
    if (data is String) {
      try {
        final decoded = json.decode(data);
        if (decoded is Map) {
          return decoded['error'] ??
              decoded['message'] ??
              ServerFailure.fromDio(e).errorMessage;
        }
      } catch (_) {}
    }
    return ServerFailure.fromDio(e).errorMessage;
  }

  Future<ReviewListResponse> getReviews() async {
    log('🌐 [GetReviewsRemoteDataSource] Calling getReviews API');
    try {
      final result = await _apiClient.getReviews();
      log('✅ [GetReviewsRemoteDataSource] API returned successfully. Reviews count: ${result.content?.length ?? 0}');
      return result;
    } on DioException catch (e) {
      log('❌ [GetReviewsRemoteDataSource] API call failed: ${e.message}');
      log('Response status: ${e.response?.statusCode}');
      log('Response data: ${e.response?.data}');
      throw Exception(_extractApiMessage(e));
    } catch (e) {
      log('❌ [GetReviewsRemoteDataSource] Unexpected error: $e');
      rethrow;
    }
  }

  Future<String> deleteReview(String reviewId) async {
    log('🌐 [GetReviewsRemoteDataSource] Calling deleteReview API for reviewId: $reviewId');
    try {
      final result = await _apiClient.deleteReview(reviewId);
      log('✅ [GetReviewsRemoteDataSource] Review deleted successfully');
      return result;
    } on DioException catch (e) {
      log('❌ [GetReviewsRemoteDataSource] Delete failed: ${e.message}');
      log('Response status: ${e.response?.statusCode}');
      log('Response data: ${e.response?.data}');
      throw Exception(_extractApiMessage(e));
    } catch (e) {
      log('❌ [GetReviewsRemoteDataSource] Unexpected error: $e');
      rethrow;
    }
  }
}