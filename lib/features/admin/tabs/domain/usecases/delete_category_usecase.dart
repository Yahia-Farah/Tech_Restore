import 'package:injectable/injectable.dart';
import '../repo/admin_repo.dart';

@injectable
class DeleteCategoryUseCase {
  final AdminRepo _adminRepo;

  DeleteCategoryUseCase(this._adminRepo);

  Future<String> call(String categoryId) async {
    return await _adminRepo.deleteCategory(categoryId);
  }
}

