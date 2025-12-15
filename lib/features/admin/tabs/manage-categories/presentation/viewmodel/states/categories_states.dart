import '../../../../data/model/categories-model/categories_model_response.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final CategoriesResponse categories;
  CategoriesLoaded(this.categories);
}

class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError(this.message);
}

class CategoryAdded extends CategoriesState {
  final String message;
  CategoryAdded(this.message);
}

class CategoryUpdated extends CategoriesState {
  final String message;
  CategoryUpdated(this.message);
}

class CategoryDeleted extends CategoriesState {
  final String message;
  CategoryDeleted(this.message);
}


