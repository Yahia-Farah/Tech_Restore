abstract class ApiEndPoints {
  static const String login = 'auth/login';
  static const String chatSessions = 'chats/shop/sessions';
  static const String chatMessages = 'chats/shop/{sessionId}/messages';
  static const String endChatSession = 'chats/shop/{sessionId}/end';
  static const String forgetPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';
  static const String resendCode = 'auth/resend-otp';
  static const String register = 'auth/register/user';
  static const String registerShop = 'auth/register/shop';
  static const String registerDelivery = 'auth/register/delivery';
  static const String registerAssigner = 'auth/register/assigner';
  static const String logout = 'auth/logout';
  static const String verifyEmail = 'auth/verify-email';
  static const String profile = 'users/profile';
  static const String getAllUsers = 'admin/users';
  static const String getAllOffers = 'shop/offers';
  static const String addOffer = 'shop/offers';
  static const String deleteOffer = 'shop/offers/{offerId}';
  static const String updateOffer = 'shop/offers/{offerId}';
  static const String getAllCategory = 'admin/categories';
  static const String getAllProducts = 'shops/products';
  static const String addProducts = 'shops/products';
  static const String updateProducts = 'shops/products/{productId}';
  static const String updateProductStock = 'shops/products/{productId}/stock';
  static const String deleteProducts = 'shops/products/{productId}';
  static const String searchInventory = 'shop/inventory/search';
  static const String outOfStockInInventory = 'shop/inventory/out-of-stock';
  static const String lowStockInInventory = 'shop/inventory/low-stock';
  static const String totalItemsInInventory = 'shop/inventory/total-items';
  static const String totalInventoryValue = 'shop/inventory/total-value';
  static const String exportInventoryData = 'shop/inventory/export';
  static const String getAllShops = 'admin/shops';
  static const String approveShops = 'admin/shops/{shopId}/approve';
  static const String suspendShops = 'admin/shops/{shopId}/suspend';
  static const String getAdminStats = 'admin/stats';
  static const String deactivateUser = 'admin/users/{userId}/deactivate';
  static const String activateUser = 'admin/users/{userId}/activate';
  static const String updateUserRole = 'admin/users/{userId}';
  static const String getAllCategoriesAdmin = 'admin/categories';
  static const String addCategoriesAdmin = 'admin/categories';
  static const String updateCategoriesAdmin = 'admin/categories/{categroyId}';
  static const String deleteCategoriesAdmin = 'admin/categories/{categroyId}';
  static const String getAllTransactionAdmin = 'admin/transactions/all';
  static const String getAllNotificationsShop = 'notifications/shops';
  static const String deleteNotificationsShop =
      'notifications/shops/{notificationId}';
  static const String getDeliveriesAdmin = 'admin/deliveries';
  static const String getDeliveriesAdminById = 'admin/deliveries/{deliveryId}';
  static const String getDeliveriesAdminSuspended =
      'admin/deliveries/suspended';
  static const String getDeliveriesAdminPending = 'admin/deliveries/pending';
  static const String getDeliveriesAdminApproved = 'admin/deliveries/approved';
  static const String putDeliveriesAdminSuspended =
      'admin/deliveries/{deliveryId}/suspend';
  static const String putDeliveriesAdminApproved =
      'admin/deliveries/{deliveryId}/approve';
  static const String deleteDeliveriesAdminById =
      'admin/deliveries/{deliveryId}';
  static const String getAllAddresses = 'shops/address';
  static const String addAddress = 'shops/address';
  static const String deleteAddress = 'shops/address/{id}';
  static const String updateAddress = 'shops/address/{id}';
  static const String getShopProfile = 'shops/{shopId}';
  static const String updateShopProfile = 'shops/{id}';
  static const String getAllOrders = 'shops/orders/control';
  static const String getOrdersByStatus =
      'shops/orders/control/status/{status}';
  static const String getOrderDetails = 'shops/orders/control/{orderId}';
  static const String acceptOrder = 'shops/orders/control/{orderId}/accept';
  static const String rejectOrder = 'shops/orders/control/{orderId}/reject';
  static const String updateOrderStatus =
      'shops/orders/control/{orderId}/status';
  static const String getFinancialReport = 'shops/payments/financial-report';
  static const String getAllReviews = 'admin/reviews';
  static const String deleteReview = 'admin/reviews/{reviewId}';
  static const String subscriptionWithPayment = "admin/subscriptions/subscriptions-with-payment";
  static const String cashPending = "admin/subscriptions/cash/pending";
  static const String adminOffers = "admin/offers";
  static const String adminRepairRequests = "admin/repair-requests";
  static const String adminRepairRequestsByStatus = "admin/repair-requests/status/{status}";

  // Dashboard
  static const String getDashboardRepairsTotal =
      'shops/dashboard/repairs/total';
  static const String getDashboardSalesTotal = 'shops/dashboard/sales/total';
  static const String getDashboardOrdersTotal = 'shops/dashboard/orders/total';
  static const String getDashboardSalesStats = 'shops/dashboard/sales/stats';
  static const String getDashboardRepairsStats =
      'shops/dashboard/repairs/stats';

  static const String getMyChatSessions = 'chats/my/sessions';
  static const String getChatMessages = 'chats';
  static const String markMessagesAsRead = 'chats';
  static const String closeChatSession = 'chats';
  static const String getUnreadMessageCount = 'chats';

  static const String getShopChatSessions = 'chats/shop/sessions';

  // User Addresses
  static const String getUserAddresses = 'users/addresses';
  static const String addUserAddress = 'users/addresses';
  static const String updateUserAddress = 'users/addresses/{addressId}';
  static const String deleteUserAddress = 'users/addresses/{addressId}';

  // User Orders
  static const String getUserOrders = 'users/orders';
  static const String cancelUserOrder = 'users/orders/{orderId}/cancel';

  // User Explore
  static const String getAllShopsUser = 'users/shops/all';
  static const String getAllDevices = 'products';
  static const String getCategories = 'categories';
  static const String getCategoriesPageable = 'categories';
  static const String getShopById = 'shops/{shopId}';
  static const String getProductsByShop = 'products/shop/{shopId}';
  static const String getProductsByShopAndCategory =
      'products/{shopId}/{categoryId}';

  // Cart
  static const String getCart = 'cart';
  static const String addCartItem = 'cart/items';
  static const String updateCartItem = 'cart/items/{itemId}';
  static const String removeCartItem = 'cart/items/{itemId}';
  static const String clearCart = 'cart';

  // Reviews
  static const String getShopReviews = 'reviews/{shopId}/reviews';
  static const String addReview = 'reviews/{shopId}';
  static const String updateReview = 'reviews/{id}';
  static const String deleteReview = 'reviews/cancel/{id}';
}
