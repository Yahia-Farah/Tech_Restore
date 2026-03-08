import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/data/models/shop_response.dart';
import 'package:tech_restore/features/admin/tabs/manage-reviews/data/models/review_response.dart';
import 'package:tech_restore/features/auth/data/models/forget_password_models/verify_email_request_model.dart';
import 'package:tech_restore/features/auth/data/models/signup_shop_models/sign_up_shop_request_model.dart';
import 'package:tech_restore/features/shop/data/models/offers/get_all_offers_model.dart';
import 'package:tech_restore/features/shop/data/models/offers/offer_response.dart';
import 'package:tech_restore/features/shop/data/models/addresses/get_all_addresses_model.dart';
import 'package:tech_restore/features/shop/data/models/addresses/address_request.dart';
import 'package:tech_restore/features/shop/data/models/profile/shop_profile_model.dart';
import 'package:tech_restore/features/shop/data/models/profile/update_profile_request.dart';
import 'package:tech_restore/features/shop/data/models/orders/get_all_orders_model.dart';
import 'package:tech_restore/features/shop/data/models/orders/order_status_request.dart';
import 'package:tech_restore/features/shop/data/models/transactions/financial_report_model.dart';
import 'package:tech_restore/features/shop/data/models/products/add_product_request.dart';
import 'package:tech_restore/features/shop/data/models/products/get_all_products_model.dart';
import 'package:tech_restore/features/shop/data/models/products/total_elements_response.dart';
import 'package:tech_restore/features/shop/data/models/products/product_model.dart';
import 'package:tech_restore/features/user/profile/data/models/edit_profile_request.dart';
import '../../../features/admin/tabs/data/model/transaction-models/transaction_admin_response.dart';
import '../../../features/admin/tabs/manage-user/data/models/user_model_response.dart';
import '../../../features/admin/tabs/manage-user/data/models/update_user_role_request.dart';
import '../../../features/admin/tabs/data/model/admin-states/admin_states_response.dart';
import '../../../features/admin/tabs/data/model/categories-model/categories_model_response.dart';
import '../../../features/admin/tabs/data/model/categories-model/categories_request.dart';
import '../../../features/admin/tabs/data/model/delivery-model/delivery_admin_response.dart';
import '../../../features/admin/tabs/data/model/delivery-model/content_delivery_admin.dart';
import '../../../features/admin/tabs/data/model/subscription-model/subscription_response.dart';
import '../../../features/admin/tabs/manage-offers/data/models/offer_page_model.dart';
import '../../../features/admin/tabs/manage-repair-requests/data/models/repair_request_model.dart';
import '../../../features/auth/data/models/forget_password_models/forget_password_request_model.dart';
import '../../../features/auth/data/models/forget_password_models/reset_password_request_model.dart';
import '../../../features/auth/data/models/login_models/login_request_model.dart';
import '../../../features/auth/data/models/login_models/login_response_model.dart';
import '../../../features/auth/data/models/signup_assigner_model/signup_assigner_request_model.dart';
import '../../../features/auth/data/models/signup_delivery_models/signup_delivery_request_model.dart';
import '../../../features/auth/data/models/signup_shop_models/sign_up_shop_response_model.dart';
import '../../../features/auth/data/models/signupmodels/sign_up_request_model.dart';
import '../../../features/auth/data/models/signupmodels/sign_up_response_model.dart';
import '../../../features/shop/data/models/offers/offer_request.dart';
import 'package:tech_restore/features/shop/data/models/chats/chat_session_model.dart'
    hide ChatMessageModel;
import 'package:tech_restore/features/shop/data/models/chats/chat_message_model.dart';
import 'package:tech_restore/features/shop/data/models/notifications/notification_model.dart';
import '../../../features/shop/data/models/products/get_all_category_model.dart';
import '../../../features/user/profile/data/models/profile_response.dart';
import '../api_constants/api_end_points.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _ApiClient;

  @POST(ApiEndPoints.register)
  Future<SignUpResponseModel> signUp(@Body() SignUpRequest request);

  @POST(ApiEndPoints.registerShop)
  Future<SignUpShopResponseModel> signUpShop(
    @Body() SignUpShopRequestModel request,
  );

  @POST(ApiEndPoints.registerDelivery)
  Future<SignUpShopResponseModel> signUpDelivery(
    @Body() SignupDeliveryRequestModel request,
  );

  @POST(ApiEndPoints.registerAssigner)
  Future<SignUpShopResponseModel> signUpAssigner(
    @Body() SignupAssignerRequestModel request,
  );

  @POST(ApiEndPoints.login)
  Future<HttpResponse<LoginResponseModel>> login(
    @Body() LoginRequestModel request,
  );

  @POST(ApiEndPoints.forgetPassword)
  Future<String> forgetPassword(
    @Body() ForgetPasswordRequestModel forgetPasswordRequestModel,
  );

  @POST(ApiEndPoints.resetPassword)
  Future<String> resetPassword(
    @Body() ResetPasswordRequestModel resetPasswordRequestModel,
  );

  @POST(ApiEndPoints.resendCode)
  Future<String> resendCode(
    @Body() ForgetPasswordRequestModel forgetPasswordRequestModel,
  );

  @POST(ApiEndPoints.verifyEmail)
  Future<String> verifyEmail(
    @Body() VerifyEmailRequestModel verifyEmailRequestModel,
  );

  @POST(ApiEndPoints.logout)
  @Extra({'auth': true})
  Future<String> logout();

  @GET(ApiEndPoints.profile)
  @Extra({'auth': true})
  Future<ProfileResponse> getProfile();

  @PUT(ApiEndPoints.profile)
  @Extra({'auth': true})
  Future<ProfileResponse> editProfile(@Body() EditProfileRequest model);

  @GET(ApiEndPoints.getAllUsers)
  @Extra({'auth': true})
  Future<UserListResponse> getUsers();

  @GET(ApiEndPoints.getAllShops)
  Future<ShopListResponse> getShops();

  @GET(ApiEndPoints.chatSessions)
  @Extra({'auth': true})
  Future<List<ChatSessionModel>> getChatSessions();

  @GET(ApiEndPoints.chatMessages)
  @Extra({'auth': true})
  Future<List<ChatMessageModel>> getChatMessages(
    @Path('sessionId') String sessionId,
  );

  @POST(ApiEndPoints.endChatSession)
  @Extra({'auth': true})
  Future<dynamic> endChatSession(@Path('sessionId') String sessionId);

  @GET(ApiEndPoints.getAllNotificationsShop)
  @Extra({'auth': true})
  Future<List<NotificationModel>> getAllNotificationsShop();

  @DELETE(ApiEndPoints.deleteNotificationsShop)
  @Extra({'auth': true})
  Future<dynamic> deleteNotificationShop(
    @Path('notificationId') String notificationId,
  );

  @GET(ApiEndPoints.getAdminStats)
  @Extra({'auth': true})
  Future<AdminStatesResponse> getAdminStats();

  @GET(ApiEndPoints.getAllOffers)
  @Extra({'auth': true})
  Future<GetAllOffersModel> getOffers(@Query('page') int page);

  @POST(ApiEndPoints.addOffer)
  @Extra({'auth': true})
  Future<OfferResponse> addOffer(@Body() OfferRequest model);

  @DELETE(ApiEndPoints.deleteOffer)
  @Extra({'auth': true})
  Future<String> deleteOffer(@Path('offerId') String offerId);

  @PUT(ApiEndPoints.updateOffer)
  @Extra({'auth': true})
  Future<OfferResponse> updateOffer(
    @Body() OfferRequest model,
    @Path('offerId') String offerId,
  );

  @GET(ApiEndPoints.getAllCategory)
  @Extra({'auth': true})
  Future<GetAllCategoryModel> getAllCategory(@Query('page') int page);

  @GET(ApiEndPoints.getAllProducts)
  @Extra({'auth': true})
  Future<GetAllProductsModel> getAllProducts(@Query('page') int page);

  @POST(ApiEndPoints.addProducts)
  @Extra({'auth': true})
  Future<ProductModel> addProducts(@Body() AddProductRequest model);

  @PUT(ApiEndPoints.updateProducts)
  @Extra({'auth': true})
  Future<ProductModel> updateProducts(
    @Body() AddProductRequest model,
    @Path('productId') String productId,
  );

  @DELETE(ApiEndPoints.deleteProducts)
  @Extra({'auth': true})
  Future<String> deleteProducts(@Path('productId') String productId);

  @GET(ApiEndPoints.searchInventory)
  @Extra({'auth': true})
  Future<GetAllProductsModel> searchInventory(
    @Query('query') String query,
    @Query('page') int page,
  );

  @GET(ApiEndPoints.lowStockInInventory)
  @Extra({'auth': true})
  Future<TotalElementsResponse> lowStockInInventory();

  @GET(ApiEndPoints.outOfStockInInventory)
  @Extra({'auth': true})
  Future<TotalElementsResponse> outOfStockInInventory();

  @GET(ApiEndPoints.totalItemsInInventory)
  @Extra({'auth': true})
  Future<int> totalItemsInInventory();

  @GET(ApiEndPoints.totalInventoryValue)
  @Extra({'auth': true})
  Future<double> totalInventoryValue();

  @PUT(ApiEndPoints.UpdateUserRole)
  @Extra({'auth': true})
  Future<String> updateUserRole(
    @Path('userId') String userId,
    @Body() UpdateUserRoleRequest request,
  );

  @PUT(ApiEndPoints.deactivateUser)
  @Extra({'auth': true})
  Future<String> deactivateUser(@Path('userId') String userId);

  @PUT(ApiEndPoints.activateUser)
  @Extra({'auth': true})
  Future<String> activateUser(@Path('userId') String userId);

  @GET(ApiEndPoints.getAllCategoriesAdmin)
  @Extra({'auth': true})
  Future<CategoriesResponse> getAllCategoriesAdmin(@Query('page') int page);

  @POST(ApiEndPoints.addCategoriesAdmin)
  @Extra({'auth': true})
  Future<String> addCategoryAdmin(@Body() CategoriesRequest request);

  @PUT(ApiEndPoints.updateCategoriesAdmin)
  @Extra({'auth': true})
  Future<String> updateCategoryAdmin(
    @Path('categroyId') String categoryId,
    @Body() CategoriesRequest request,
  );

  @DELETE(ApiEndPoints.deleteCategoriesAdmin)
  @Extra({'auth': true})
  Future<String> deleteCategoryAdmin(@Path('categroyId') String categoryId);

  @GET(ApiEndPoints.getAllTransactionAdmin)
  @Extra({'auth': true})
  Future<TransactionAdminModelResponse> getAllTransactionsAdmin(
    @Query('page') int page,
  );

  @GET(ApiEndPoints.getDeliveriesAdmin)
  @Extra({'auth': true})
  Future<DeliveryAdminResponse> getAllDeliveriesAdmin(@Query('page') int page);

  @GET(ApiEndPoints.getDeliveriesAdminById)
  @Extra({'auth': true})
  Future<ContentDeliveryAdmin> getDeliveryAdminById(@Path('deliveryId') String deliveryId);

  @PUT(ApiEndPoints.approveShops)
  @Extra({'auth': true})
  Future<String> approveShop(@Path('shopId') String shopId);


  @GET(ApiEndPoints.getAllAddresses)
  @Extra({'auth': true})
  Future<GetAllAddressesModel> getAllAddresses(@Query('page') int page);

  @POST(ApiEndPoints.addAddress)
  @Extra({'auth': true})
  Future<String> addAddress(@Body() AddressRequest model);

  @DELETE(ApiEndPoints.deleteAddress)
  @Extra({'auth': true})
  Future<String> deleteAddress(@Path('id') String addressId);

  @PUT(ApiEndPoints.updateAddress)
  @Extra({'auth': true})
  Future<String> updateAddress(
    @Body() AddressRequest model,
    @Path('id') String addressId,
  );

  @GET(ApiEndPoints.getShopProfile)
  @Extra({'auth': true})
  Future<ShopProfileModel> getShopProfile(@Path('shopId') String shopId);

  @PUT(ApiEndPoints.updateShopProfile)
  @Extra({'auth': true})
  Future<ShopProfileModel> updateShopProfile(
    @Body() UpdateProfileRequest model,
    @Path('id') String shopId,
  );

  @GET(ApiEndPoints.getAllOrders)
  @Extra({'auth': true})
  Future<GetAllOrdersModel> getAllOrders(@Query('page') int page);

  @GET(ApiEndPoints.getOrdersByStatus)
  @Extra({'auth': true})
  Future<GetAllOrdersModel> getOrdersByStatus(
    @Path('status') String status,
    @Query('page') int page,
  );

  @GET(ApiEndPoints.getOrderDetails)
  @Extra({'auth': true})
  Future<OrderContent> getOrderDetails(@Path('orderId') String orderId);

  @POST(ApiEndPoints.acceptOrder)
  @Extra({'auth': true})
  Future<String> acceptOrder(@Path('orderId') String orderId);

  @POST(ApiEndPoints.rejectOrder)
  @Extra({'auth': true})
  Future<String> rejectOrder(@Path('orderId') String orderId);

  @PUT(ApiEndPoints.updateOrderStatus)
  @Extra({'auth': true})
  Future<String> updateOrderStatus(
    @Path('orderId') String orderId,
    @Body() OrderStatusRequest request,
  );

  @GET(ApiEndPoints.getFinancialReport)
  @Extra({'auth': true})
  Future<FinancialReportModel> getFinancialReport();

  @PUT(ApiEndPoints.suspendShops)
  @Extra({'auth': true})
  Future<String> suspendShop(@Path('shopId') String shopId);

  @GET(ApiEndPoints.getAllReviews)
  @Extra({'auth': true})
  Future<ReviewListResponse> getReviews();

  @DELETE(ApiEndPoints.deleteReview)
  @Extra({'auth': true})
  Future<String> deleteReview(@Path('reviewId') String reviewId);

  @GET(ApiEndPoints.subscriptionWithPayment)
  @Extra({'auth': true})
  Future<SubscriptionResponse> getAllSubscriptions(@Query('page') int page);

  @GET(ApiEndPoints.cashPending)
  @Extra({'auth': true})
  Future<SubscriptionResponse> getPendingCashSubscriptions(@Query('page') int page);

  @GET(ApiEndPoints.adminOffers)
  @Extra({'auth': true})
  Future<OfferPageModel> getAdminOffers(@Query('page') int page);

  @GET(ApiEndPoints.adminRepairRequests)
  @Extra({'auth': true})
  Future<RepairRequestModel> getAdminRepairRequests(@Query('page') int page);

  @GET(ApiEndPoints.adminRepairRequestsByStatus)
  @Extra({'auth': true})
  Future<RepairRequestModel> getAdminRepairRequestsByStatus(
    @Path('status') String status,
    @Query('page') int page,
  );
}
