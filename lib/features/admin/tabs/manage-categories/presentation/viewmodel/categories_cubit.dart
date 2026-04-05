import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/categories-model/categories_request.dart';
import '../../../domain/usecases/add_category_usecase.dart';
import '../../../domain/usecases/delete_category_usecase.dart';
import '../../../domain/usecases/get_all_categories_usecase.dart';
import '../../../domain/usecases/update_category_usecase.dart';
import '../viewmodel/states/categories_states.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  final AddCategoryUseCase _addCategoryUseCase;
  final UpdateCategoryUseCase _updateCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;
  int _currentPage = 0;

  CategoriesCubit(
    this._getAllCategoriesUseCase,
    this._addCategoryUseCase,
    this._updateCategoryUseCase,
    this._deleteCategoryUseCase,
  ) : super(CategoriesInitial());

  Future<void> getAllCategories(int page) async {
    _currentPage = page;
    emit(CategoriesLoading());
    try {
      final categories = await _getAllCategoriesUseCase(page);
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> addCategory(String name) async {
    try {
      final request = CategoriesRequest(name: name);
      final message = await _addCategoryUseCase(request);
      emit(CategoryAdded(message));
      // Refresh the list after adding
      await getAllCategories(_currentPage);
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> updateCategory(String categoryId, String name) async {
    try {
      final request = CategoriesRequest(name: name);
      final message = await _updateCategoryUseCase(categoryId, request);
      emit(CategoryUpdated(message));
      // Refresh the list after updating
      await getAllCategories(_currentPage);
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      final message = await _deleteCategoryUseCase(categoryId);
      emit(CategoryDeleted(message));
      // Refresh the list after deleting
      await getAllCategories(_currentPage);
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}

