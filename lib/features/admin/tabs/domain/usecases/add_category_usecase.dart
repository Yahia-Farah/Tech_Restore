import 'package:injectable/injectable.dart';
import '../repo/admin_repo.dart';
import '../../data/model/categories-model/categories_request.dart';

@injectable
class AddCategoryUseCase {
  final AdminRepo _adminRepo;

  AddCategoryUseCase(this._adminRepo);

  Future<String> call(CategoriesRequest request) async {
    return await _adminRepo.addCategory(request);
  }
}
