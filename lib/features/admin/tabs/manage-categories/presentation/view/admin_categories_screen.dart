import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/widgets/toast_helper.dart';
import '../../../data/model/categories-model/content.dart' as category_model;
import '../viewmodel/categories_cubit.dart';
import '../viewmodel/states/categories_states.dart';

class AdminCategoriesScreen extends StatefulWidget {
  const AdminCategoriesScreen({super.key});

  @override
  State<AdminCategoriesScreen> createState() => _AdminCategoriesScreenState();
}

class _AdminCategoriesScreenState extends State<AdminCategoriesScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _editCategoryNameController = TextEditingController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getAllCategories(_currentPage);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _categoryNameController.dispose();
    _editCategoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesError) {
            ToastHelper.showCustomToast(
              context,
              text: state.message,
              isError: true,
            );
          } else if (state is CategoryUpdated) {
            ToastHelper.showCustomToast(
              context,
              text: local.category_updated_successfully,
              isError: false,
            );
          } else if (state is CategoryDeleted) {
            ToastHelper.showCustomToast(
              context,
              text: local.category_deleted_successfully,
              isError: false,
            );
          }
        },
        builder: (context, state) {
          List<category_model.Content> categories = [];
          int totalCategories = 0;

          if (state is CategoriesLoaded) {
            final contentList = state.categories.content;
            categories = contentList != null ? List<category_model.Content>.from(contentList) : <category_model.Content>[];
            totalCategories = state.categories.totalElements ?? 0;
          }

          final filteredCategories = categories.where((category) {
            final query = _searchQuery.toLowerCase();
            return (category.name ?? '').toLowerCase().contains(query);
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      local.manage_product_categories,
                      style: TextStyle(color: AppColors.hint),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _showAddCategoryDialog(context, local);
                      },
                      icon: const Icon(Icons.add, color: AppColors.white, size: 20),
                      label: Text(
                        local.add_category,
                        style: const TextStyle(color: AppColors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary[70],
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: AppColors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            local.total_categories,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.hint,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            totalCategories.toString(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  local.search,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.hint,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _searchController,
                  hint: local.search_by_name,
                  prefixIcon: Icon(Icons.search, color: AppColors.black[30]!),
                  onChanged: (val) {
                    setState(() => _searchQuery = val);
                  },
                ),
                const SizedBox(height: 20),

                Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.black[30]!, width: 1),
                  ),
                  elevation: 2,
                  child: state is CategoriesLoading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : _buildCategoriesTable(filteredCategories, local),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesTable(List<category_model.Content> categories, AppLocalizations local) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.grey,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      local.id.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      local.name.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      local.actions.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            if (categories.isEmpty)
              _buildEmptyState(local)
            else
              ...categories.map((category) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.black[30]!, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                category.id ?? '',
                                style: const TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: category.id ?? ''));
                                ToastHelper.showCustomToast(
                                  context,
                                  text: local.id_copied_to_clipboard,
                                  isError: false,
                                );
                              },
                              child: const Icon(Icons.copy, size: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          category.name ?? '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: ElevatedButton(
                                onPressed: () {
                                  _showEditCategoryDialog(context, local, category);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade400,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(local.edit, style: const TextStyle(fontSize: 12, color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: ElevatedButton(
                                onPressed: () {
                                  _showDeleteCategoryDialog(context, local, category);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade400,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(local.delete, style: const TextStyle(fontSize: 12, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(AppLocalizations local) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list,
            size: 64,
            color: AppColors.black[30]!,
          ),
          const SizedBox(height: 16),
          Text(
            local.no_categories_available,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black[40]!,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, AppLocalizations local) {
    _categoryNameController.clear();
    final cubit = context.read<CategoriesCubit>();
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: cubit,
          child: BlocListener<CategoriesCubit, CategoriesState>(
            listener: (context, state) {
              if (state is CategoryAdded) {
                ToastHelper.showCustomToast(
                  context,
                  text: local.category_added_successfully,
                  isError: false,
                );
                Navigator.of(dialogContext).pop();
                _categoryNameController.clear();
              } else if (state is CategoriesError) {
                ToastHelper.showCustomToast(
                  context,
                  text: state.message,
                  isError: true,
                );
              }
            },
            child: Dialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          local.add_category,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary[70],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          color: AppColors.black[40],
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      local.category_details,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      local.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      controller: _categoryNameController,
                      hint: local.enter_category_name,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        final isLoading = state is CategoriesLoading;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () => Navigator.of(dialogContext).pop(),
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.grey,
                                foregroundColor: AppColors.black[40],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                local.cancel,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      final name = _categoryNameController.text.trim();
                                      if (name.isEmpty) {
                                        ToastHelper.showCustomToast(
                                          context,
                                          text: local.enter_category_name,
                                          isError: true,
                                        );
                                        return;
                                      }
                                      context.read<CategoriesCubit>().addCategory(name);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: AppColors.white,
                                disabledBackgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Text(
                                      local.create,
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditCategoryDialog(BuildContext context, AppLocalizations local, category_model.Content category) {
    _editCategoryNameController.text = category.name ?? '';
    final categoryId = category.id ?? '';
    final cubit = context.read<CategoriesCubit>();
    
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: cubit,
          child: BlocListener<CategoriesCubit, CategoriesState>(
            listener: (context, state) {
              if (state is CategoryUpdated) {
                ToastHelper.showCustomToast(
                  context,
                  text: local.category_updated_successfully,
                  isError: false,
                );
                Navigator.of(dialogContext).pop();
              } else if (state is CategoriesError) {
                ToastHelper.showCustomToast(
                  context,
                  text: state.message,
                  isError: true,
                );
              }
            },
            child: Dialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          local.edit_category,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary[70],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          color: AppColors.black[40],
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      local.category_details,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          '${local.id}: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            categoryId,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.black[40],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: categoryId));
                            ToastHelper.showCustomToast(
                              context,
                              text: local.id_copied_to_clipboard,
                              isError: false,
                            );
                          },
                          child: const Icon(Icons.copy, size: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      local.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      controller: _editCategoryNameController,
                      hint: local.enter_category_name,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        final isLoading = state is CategoriesLoading;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () => Navigator.of(dialogContext).pop(),
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.grey,
                                foregroundColor: AppColors.black[40],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                local.cancel,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      final name = _editCategoryNameController.text.trim();
                                      if (name.isEmpty) {
                                        ToastHelper.showCustomToast(
                                          context,
                                          text: local.enter_category_name,
                                          isError: true,
                                        );
                                        return;
                                      }
                                      context.read<CategoriesCubit>().updateCategory(
                                        categoryId,
                                        name,
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: AppColors.white,
                                disabledBackgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Text(
                                      local.updateText,
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteCategoryDialog(BuildContext context, AppLocalizations local, category_model.Content category) {
    final categoryName = category.name ?? '';
    final categoryId = category.id ?? '';
    final cubit = context.read<CategoriesCubit>();
    
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: cubit,
          child: BlocListener<CategoriesCubit, CategoriesState>(
            listener: (context, state) {
              if (state is CategoryDeleted) {
                ToastHelper.showCustomToast(
                  context,
                  text: local.category_deleted_successfully,
                  isError: false,
                );
                Navigator.of(dialogContext).pop();
              } else if (state is CategoriesError) {
                ToastHelper.showCustomToast(
                  context,
                  text: state.message,
                  isError: true,
                );
              }
            },
            child: Dialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        size: 40,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      local.delete_category,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      local.delete_category_warning,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black[40],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        final isLoading = state is CategoriesLoading;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => Navigator.of(dialogContext).pop(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.black[50],
                                foregroundColor: AppColors.white,
                                disabledBackgroundColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(local.cancel),
                            ),
                            ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      context.read<CategoriesCubit>().deleteCategory(categoryId);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: AppColors.white,
                                disabledBackgroundColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Text(local.yes_delete),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
