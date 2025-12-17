import 'package:injectable/injectable.dart';
import '../repo/admin_repo.dart';
import '../../data/model/categories-model/categories_request.dart';

@injectable
class UpdateCategoryUseCase {
  final AdminRepo _adminRepo;

  UpdateCategoryUseCase(this._adminRepo);

  Future<String> call(String categoryId, CategoriesRequest request) async {
    return await _adminRepo.updateCategory(categoryId, request);
  }
}
