import 'package:injectable/injectable.dart';
import '../repo/admin_repo.dart';
import '../../data/model/categories-model/categories_model_response.dart';

@injectable
class GetAllCategoriesUseCase {
  final AdminRepo _adminRepo;

  GetAllCategoriesUseCase(this._adminRepo);

  Future<CategoriesResponse> call(int page) async {
    return await _adminRepo.getAllCategories(page);
  }
}


