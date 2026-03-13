import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/api/api_constants/api_end_points.dart';
import '../models/categories_response_model.dart';

part 'home_remote_datasource.g.dart';

@lazySingleton
@RestApi()
abstract class HomeRemoteDataSource {
  @factoryMethod
  factory HomeRemoteDataSource(Dio dio) = _HomeRemoteDataSource;

  @GET(ApiEndPoints.getCategoriesPageable)
  @Extra({'auth': true})
  Future<CategoriesResponseModel> getCategoriesPageable(
    @Queries() Map<String, dynamic> queries,
  );
}
