import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/config/di.dart';
import '../viewmodel/cart_cubit.dart';
import '../viewmodel/cart_state.dart';
import '../../data/models/cart_item_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartCubit>()..loadCart(),
      child: const _CartView(),
    );
  }
}

class _CartView extends StatelessWidget {
  const _CartView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final cart = cubit.cart;
        final items = cart?.items ?? [];

        final isLoading = state is CartLoading;
        final isClearing = state is CartClearing;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F7FA),
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
            ),
            title: Text(
              'Shopping Cart',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              if (items.isNotEmpty)
                TextButton(
                  onPressed: isClearing
                      ? null
                      : () => _showClearCartDialog(context, cubit),
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : items.isEmpty
              ? _buildEmptyCart(context)
              : _buildCartContent(context, cubit, items, state),
          bottomNavigationBar: items.isNotEmpty && cart != null
              ? _buildCheckoutSection(context, cart.totalPrice)
              : null,
        );
      },
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration:
            BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
            child: Icon(Icons.shopping_cart_outlined,
                size: 60, color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          Text('Your cart is empty',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text('Add some items to get started',
              style: TextStyle(fontSize: 14, color: Colors.grey[500])),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            child: const Text('Continue Shopping',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartCubit cubit,
      List<CartItemModel> items, CartState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isRemoving =
            state is CartItemRemoving && state.itemId == item.id;
        final isUpdating = state is CartItemUpdating;
        return _buildCartItem(context, cubit, item, isRemoving, isUpdating);
      },
    );
  }

  Widget _buildCartItem(BuildContext context, CartCubit cubit,
      CartItemModel item, bool isRemoving, bool isUpdating) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: isRemoving
          ? const Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ),
      )
          : Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child:
            Icon(Icons.devices, color: AppColors.primary, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary)),
                const SizedBox(height: 4),
                Text(
                    '${item.productPrice.toStringAsFixed(2)} EGP each',
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                    'Subtotal: ${item.subtotal.toStringAsFixed(2)} EGP',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: isUpdating
                        ? null
                        : () {
                      if (item.quantity > 1) {
                        cubit.updateItem(item.id, item.productId,
                            item.quantity - 1);
                      } else {
                        cubit.removeItem(item.id);
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle),
                      child: const Icon(Icons.remove, size: 14),
                    ),
                  ),
                  Container(
                    width: 36,
                    alignment: Alignment.center,
                    child: isUpdating
                        ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                            strokeWidth: 2))
                        : Text('${item.quantity}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: isUpdating
                        ? null
                        : () => cubit.updateItem(
                        item.id, item.productId, item.quantity + 1),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle),
                      child: const Icon(Icons.add,
                          size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => cubit.removeItem(item.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete_outline,
                      color: Colors.red, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, double totalPrice) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Amount:',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('${totalPrice.toStringAsFixed(2)} EGP',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Proceeding to checkout...'),
                      duration: Duration(seconds: 2)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Proceed to Checkout',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartCubit cubit) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear Cart'),
        content: const Text(
            'Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              cubit.clearCart();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
