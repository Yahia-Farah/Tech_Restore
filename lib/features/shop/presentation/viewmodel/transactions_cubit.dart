import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/shop_repository.dart';
import '../../data/models/transactions/financial_report_model.dart';
import 'transactions_state.dart';

@injectable
class TransactionsCubit extends Cubit<TransactionsState> {
  final ShopRepository _repository;

  List<TransactionModel> _transactions = [];
  double _totalSalesRevenue = 0.0;
  double _totalRepairRevenue = 0.0;
  double _totalProfit = 0.0;

  TransactionsCubit(this._repository) : super(TransactionsInitial());

  List<TransactionModel> get transactions => _transactions;
  double get totalSalesRevenue => _totalSalesRevenue;
  double get totalRepairRevenue => _totalRepairRevenue;
  double get totalProfit => _totalProfit;

  Future<void> loadFinancialReport({bool isRefresh = false}) async {
    if (!isRefresh && state is TransactionsLoading) return;

    emit(TransactionsLoading());

    try {
      final report = await _repository.getFinancialReport();

      _transactions = report.transactions ?? [];
      _totalSalesRevenue = report.totalSalesRevenue ?? 0.0;
      _totalRepairRevenue = report.totalRepairRevenue ?? 0.0;
      _totalProfit = report.totalProfit ?? 0.0;

      emit(
        TransactionsLoaded(
          totalSalesRevenue: _totalSalesRevenue,
          totalRepairRevenue: _totalRepairRevenue,
          totalProfit: _totalProfit,
        ),
      );
    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }

  List<TransactionModel> getFilteredTransactions(String query) {
    if (query.isEmpty) return _transactions;

    final searchQuery = query.toLowerCase();

    return _transactions.where((transaction) {
      // Existing search fields
      final paymentMethod = transaction.paymentMethod?.toLowerCase() ?? '';
      final paymentType = transaction.paymentType?.toLowerCase() ?? '';
      final amount = transaction.amount?.toString() ?? '';
      final status = transaction.paymentStatus?.toLowerCase() ?? '';

      // New search fields - date and shop
      final date = _formatDateForSearch(transaction.paidAt ?? '');
      final shopInfo = getShopInfo(transaction).toLowerCase();

      return paymentMethod.contains(searchQuery) ||
          paymentType.contains(searchQuery) ||
          amount.contains(searchQuery) ||
          status.contains(searchQuery) ||
          date.contains(searchQuery) ||
          shopInfo.contains(searchQuery);
    }).toList();
  }

  String _formatDateForSearch(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      // Format date in multiple ways for better search matching
      final year = date.year.toString();
      final month = date.month.toString().padLeft(2, '0');
      final day = date.day.toString().padLeft(2, '0');

      // Return searchable date formats: "2024", "2024/01", "2024/01/15", "01/15", "15"
      return '$year $year/$month $year/$month/$day $month/$day $day';
    } catch (e) {
      return dateString.toLowerCase();
    }
  }

  String getTransactionType(TransactionModel transaction) {
    switch (transaction.paymentType?.toUpperCase()) {
      case 'ORDER_PAYMENT':
        return 'Sale';
      case 'REPAIR_PAYMENT':
        return 'Repair';
      default:
        return transaction.paymentType ?? 'Unknown';
    }
  }

  String getDeviceInfo(TransactionModel transaction) {
    // For now, we'll use a placeholder since we don't have device info in the API
    // This could be enhanced by joining with order/repair data
    if (transaction.orderId != null) {
      return 'Order #${transaction.orderId?.substring(0, 8)}...';
    } else if (transaction.repairRequestId != null) {
      return 'Repair #${transaction.repairRequestId?.substring(0, 8)}...';
    }
    return 'N/A';
  }

  String getShopInfo(TransactionModel transaction) {
    // Placeholder - this would come from shop data
    return 'Tech Restore Shop';
  }
}
