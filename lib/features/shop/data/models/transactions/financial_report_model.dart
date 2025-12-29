class FinancialReportModel {
  final double? totalSalesRevenue;
  final double? totalRepairRevenue;
  final double? totalProfit;
  final List<TransactionModel>? transactions;

  FinancialReportModel({
    this.totalSalesRevenue,
    this.totalRepairRevenue,
    this.totalProfit,
    this.transactions,
  });

  factory FinancialReportModel.fromJson(Map<String, dynamic> json) {
    return FinancialReportModel(
      totalSalesRevenue: (json['totalSalesRevenue'] as num?)?.toDouble(),
      totalRepairRevenue: (json['totalRepairRevenue'] as num?)?.toDouble(),
      totalProfit: (json['totalProfit'] as num?)?.toDouble(),
      transactions:
          json['transactions'] != null
              ? (json['transactions'] as List)
                  .map((e) => TransactionModel.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSalesRevenue': totalSalesRevenue,
      'totalRepairRevenue': totalRepairRevenue,
      'totalProfit': totalProfit,
      'transactions': transactions?.map((e) => e.toJson()).toList(),
    };
  }
}

class TransactionModel {
  final String? id;
  final double? amount;
  final String? paymentType;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? paidAt;
  final String? paymentReference;
  final String? transactionId;
  final String? details;
  final String? orderId;
  final String? repairRequestId;

  TransactionModel({
    this.id,
    this.amount,
    this.paymentType,
    this.paymentMethod,
    this.paymentStatus,
    this.paidAt,
    this.paymentReference,
    this.transactionId,
    this.details,
    this.orderId,
    this.repairRequestId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] as num?)?.toDouble(),
      paymentType: json['paymentType'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      paidAt: json['paidAt'],
      paymentReference: json['paymentReference'],
      transactionId: json['transactionId'],
      details: json['details'],
      orderId: json['orderId'],
      repairRequestId: json['repairRequestId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'paymentType': paymentType,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paidAt': paidAt,
      'paymentReference': paymentReference,
      'transactionId': transactionId,
      'details': details,
      'orderId': orderId,
      'repairRequestId': repairRequestId,
    };
  }
}
