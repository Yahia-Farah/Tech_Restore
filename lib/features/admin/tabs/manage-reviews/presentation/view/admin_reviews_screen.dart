import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/admin/tabs/manage-reviews/data/models/review_model.dart';
import 'package:tech_restore/features/admin/tabs/manage-reviews/presentation/viewmodel/get_reviews_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-reviews/presentation/viewmodel/states/get_reviews_states.dart';

import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_toast.dart';

class AdminReviewsScreen extends StatefulWidget {
  const AdminReviewsScreen({super.key});

  @override
  State<AdminReviewsScreen> createState() => _AdminReviewsScreenState();
}

class _AdminReviewsScreenState extends State<AdminReviewsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  Set<String> _loadingReviews = {}; // Track loading state per review

  @override
  void initState() {
    super.initState();
    context.read<GetReviewsCubit>().getAllReviews();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<GetReviewsCubit, GetReviewsState>(
        listener: (context, state) {
          if (state is GetReviewsError) {
            _loadingReviews.clear(); // Clear loading state on error
            _showErrorToast(state.message);
          }
          if (state is ReviewDeleted) {
            _loadingReviews.clear(); // Clear loading state on success
            _showSuccessToast(l10n.review_deleted_successfully);
          }
        },
        builder: (context, state) {
          if (state is GetReviewsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state is GetReviewsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline, 
                    size: 64, 
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${l10n.error}: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    text: l10n.retry,
                    onPressed: () {
                      context.read<GetReviewsCubit>().getAllReviews();
                    },
                    width: 120,
                    height: 40,
                  ),
                ],
              ),
            );
          }

          if (state is GetReviewsLoaded) {
            final reviews = state.reviews.content ?? [];
            final filteredReviews = _getFilteredReviews(reviews);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.rate_review,
                        color: AppColors.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.review_management,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.monitor_and_manage_customer_feedback,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Stats Cards
                  _buildStatsCards(reviews, l10n),
                  const SizedBox(height: 24),

                  // Search
                  _buildSearchField(l10n),
                  const SizedBox(height: 20),

                  // Reviews Table
                  _buildReviewsTable(filteredReviews, l10n),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // Helper methods
  List<ReviewModel> _getFilteredReviews(List<ReviewModel> reviews) {
    return reviews.where((review) {
      final query = _searchQuery.toLowerCase();
      final customerName = (review.customerName ?? '').toLowerCase();
      final shopName = (review.shopName ?? '').toLowerCase();
      final comment = (review.comment ?? '').toLowerCase();
      
      return customerName.contains(query) ||
          shopName.contains(query) ||
          comment.contains(query);
    }).toList();
  }

  Widget _buildStatsCards(List<ReviewModel> reviews, AppLocalizations l10n) {
    final totalReviews = reviews.length;
    final approvedReviews = reviews.where((r) => r.isApproved == true).length;
    final flaggedReviews = reviews.where((r) => r.isFlagged == true).length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard(
            title: l10n.total_reviews,
            count: totalReviews.toString(),
            icon: Icons.rate_review,
            color: AppColors.primary,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.approved,
            count: approvedReviews.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.flagged,
            count: flaggedReviews.toString(),
            icon: Icons.flag,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(AppLocalizations l10n) {
    return CustomTextFormField(
      controller: _searchController,
      hint: l10n.search_by_customer_shop_or_comment,
      prefixIcon: const Icon(Icons.search, color: Colors.grey),
      onChanged: (value) {
        setState(() => _searchQuery = value);
      },
    );
  }

  Widget _buildReviewsTable(List<ReviewModel> reviews, AppLocalizations l10n) {
    if (reviews.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                l10n.no_reviews_available,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Single horizontal scroll for entire table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Table Header
                Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          l10n.id.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          l10n.rating.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          l10n.comment.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          l10n.date.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          l10n.actions.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Body
                Column(
                  children: reviews.map((review) => _buildReviewRow(review, l10n)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow(ReviewModel review, AppLocalizations l10n) {
    final reviewId = review.id ?? '';
    final isReviewLoading = _loadingReviews.contains(reviewId);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          // ID
          SizedBox(
            width: 120,
            child: Text(
              review.id?.substring(0, 8) ?? 'N/A',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Rating
          SizedBox(
            width: 120,
            child: _buildStarRating(review.rating ?? 0),
          ),
          // Comment
          SizedBox(
            width: 300,
            child: Text(
              review.comment ?? 'N/A',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          // Date
          SizedBox(
            width: 120,
            child: Text(
              _formatDate(review.createdAt) ?? 'N/A',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Actions
          SizedBox(
            width: 300,
            child: Row(
              children: [
                // View Button
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: ElevatedButton.icon(
                    onPressed: () => _showReviewDetails(review, l10n),
                    icon: const Icon(Icons.visibility, size: 16),
                    label: Text(l10n.view),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                // Delete Button
                ElevatedButton.icon(
                  onPressed: isReviewLoading ? null : () => _deleteReview(reviewId),
                  icon: isReviewLoading 
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.delete, size: 16),
                  label: Text(l10n.delete),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewDetails(ReviewModel review, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(
            maxWidth: 600,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.review_details,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.grey),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              // Content
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailItem(l10n.customer, review.customerName ?? 'N/A'),
                        const SizedBox(height: 16),
                        _buildDetailItem(l10n.shop, review.shopName ?? 'N/A'),
                        const SizedBox(height: 16),
                        _buildDetailItem(l10n.rating, "${review.rating ?? 0}/5"),
                        const SizedBox(height: 16),
                        _buildDetailItem(l10n.comment, review.comment ?? 'N/A'),
                        const SizedBox(height: 16),
                        _buildDetailItem(l10n.date, _formatDate(review.createdAt) ?? 'N/A'),
                        const SizedBox(height: 16),
                        _buildDetailItem(l10n.status, _getReviewStatus(review)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  void _deleteReview(String reviewId) {
    if (reviewId.isEmpty) return;
    
    setState(() {
      _loadingReviews.add(reviewId);
    });
    
    context.read<GetReviewsCubit>().deleteReview(reviewId);
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _getReviewStatus(ReviewModel review) {
    if (review.isFlagged == true) {
      return 'Flagged';
    } else if (review.isApproved == true) {
      return 'Approved';
    } else {
      return 'Pending';
    }
  }

  void _showSuccessToast(String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => CustomToast(
        text: message,
        isError: false,
      ),
    );

    overlay.insert(entry);

    // Auto remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }

  void _showErrorToast(String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => CustomToast(
        text: message,
        isError: true,
      ),
    );

    overlay.insert(entry);

    // Auto remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }

  // ===== Rating Stars =====
  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }
}