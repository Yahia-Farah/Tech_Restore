import 'package:injectable/injectable.dart';
import '../data_source/home_remote_datasource.dart';
import '../models/categories_response_model.dart';

@injectable
class HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepository(this._remoteDataSource);

  Future<CategoriesResponseModel> getCategoriesPageable({
    int page = 0,
    int size = 100,
    List<String>? sort,
  }) async {
    try {
      final queries = {
        'page': page,
        'size': size,
        if (sort != null && sort.isNotEmpty) 'sort': sort,
      };
      return await _remoteDataSource.getCategoriesPageable(queries);
    } catch (e) {
      rethrow;
    }
  }
}
