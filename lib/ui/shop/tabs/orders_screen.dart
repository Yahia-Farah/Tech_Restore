import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Mock data for orders
  final List<Map<String, dynamic>> orders = [
    {
      'id': 1,
      'customer': 'Ahmed Mohamed',
      'address': '123 Nile St, Cairo, Egypt',
      'status': 'Shipped',
      'status_ar': 'تم الشحن',
      'status_timeline': [
        {
          'label': 'Order Placed',
          'label_ar': 'تم الطلب',
          'date': '2023-05-01 10:00',
          'active': true,
        },
        {
          'label': 'Processing',
          'label_ar': 'قيد المعالجة',
          'date': '2023-05-01 12:30',
          'active': true,
        },
        {
          'label': 'Shipped',
          'label_ar': 'تم الشحن',
          'date': '2023-05-02 09:15',
          'active': true,
        },
      ],
      'total': 4500,
      'payment_method': 'Credit Card',
      'items': [
        {'name': 'iPhone 13 Pro', 'price': 4000, 'qty': 1},
        {'name': 'AirPods Pro', 'price': 500, 'qty': 1},
      ],
    },
    {
      'id': 2,
      'customer': 'Mariam Ali',
      'address': '123 Nile St, Cairo, Egypt',
      'status': 'Delivered',
      'status_ar': 'تم التوصيل',
      'status_timeline': [
        {
          'label': 'Order Placed',
          'label_ar': 'تم الطلب',
          'date': '2023-05-03 09:00',
          'active': true,
        },
        {
          'label': 'Processing',
          'label_ar': 'قيد المعالجة',
          'date': '2023-05-03 11:00',
          'active': true,
        },
        {
          'label': 'Delivered',
          'label_ar': 'تم التوصيل',
          'date': '2023-05-04 15:30',
          'active': true,
        },
      ],
      'total': 2500,
      'payment_method': 'Cash',
      'items': [
        {'name': 'Samsung Galaxy S21', 'price': 2500, 'qty': 1},
      ],
    },
  ];

  int selectedOrderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: const Color(0xFFF7F8FA),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "طلبات الشراء",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "يمكنك متابعة عمليات الشراء التي قام بها العميل من هنا",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Last Orders List
              Container(
                width: 400,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('آخر الطلبات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    ...orders.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final o = entry.value;
                      return GestureDetector(
                        onTap: () => setState(() => selectedOrderIndex = idx),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: selectedOrderIndex == idx ? Colors.blue.shade50 : Colors.white,
                            border: Border.all(color: selectedOrderIndex == idx ? Colors.blue.shade200 : Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('الطلب #${o['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(o['customer'], style: const TextStyle(color: Colors.black54)),
                                ],
                              ),
                              Row(
                                children: [
                                  _statusChip(o['status']),
                                  const SizedBox(width: 12),
                                  Text('${o['total']} EGP', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Order Details and Timeline (stacked vertically)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('الطلب #${orders[selectedOrderIndex]['id']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        _statusChip(orders[selectedOrderIndex]['status']),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('معلومات العميل', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(orders[selectedOrderIndex]['customer']),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_on, size: 16, color: Colors.black54),
                                  const SizedBox(width: 4),
                                  Text(orders[selectedOrderIndex]['address'], style: const TextStyle(color: Colors.black54)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('تفاصيل الدفع', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text('${orders[selectedOrderIndex]['total']} EGP', style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('طريقة الدفع: ${orders[selectedOrderIndex]['payment_method']}', style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Order Items Table
                    const Text('محتوى الطلب', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade200),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.grey.shade100),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('المنتج', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('السعر', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('الكمية', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        ...orders[selectedOrderIndex]['items'].map<TableRow>((item) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['name'], textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${item['price']} EGP', textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${item['qty']}', textAlign: TextAlign.center),
                            ),
                          ],
                        )).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('تتبع الطلب', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    ...orders[selectedOrderIndex]['status_timeline'].asMap().entries.map((entry) {
                      final idx = entry.key;
                      final status = entry.value;
                      final isActive = status['active'] == true;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: isActive ? Colors.blue : Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (idx != orders[selectedOrderIndex]['status_timeline'].length - 1)
                                Container(
                                  width: 2,
                                  height: 32,
                                  color: Colors.grey.shade300,
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(status['label_ar'], style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: isActive ? Colors.blue : Colors.black54)),
                              Text(status['date'], style: const TextStyle(color: Colors.black45, fontSize: 12)),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;
    String label;
    switch (status) {
      case 'Shipped':
        color = Colors.blue;
        label = 'Shipped';
        break;
      case 'Delivered':
        color = Colors.green;
        label = 'Delivered';
        break;
      default:
        color = Colors.grey;
        label = status;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
