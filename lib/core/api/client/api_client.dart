import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/data/models/shop_response.dart';
import 'package:tech_restore/features/auth/data/models/forget_password_models/verify_email_request_model.dart';
import 'package:tech_restore/features/auth/data/models/signup_shop_models/sign_up_shop_request_model.dart';
import 'package:tech_restore/features/shop/data/models/offers/get_all_offers_model.dart';
import 'package:tech_restore/features/shop/data/models/offers/offer_response.dart';
import 'package:tech_restore/features/shop/data/models/products/add_product_request.dart';
import 'package:tech_restore/features/shop/data/models/products/get_all_products_model.dart';
import 'package:tech_restore/features/shop/data/models/products/total_elements_response.dart';
import 'package:tech_restore/features/shop/data/models/products/product_model.dart';
import 'package:tech_restore/features/user/profile/data/models/edit_profile_request.dart';
import '../../../features/admin/tabs/manage-user/data/models/user_model_response.dart';
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
import 'package:tech_restore/features/shop/data/models/chats/chat_session_model.dart' hide ChatMessageModel;
import 'package:tech_restore/features/shop/data/models/chats/chat_message_model.dart';
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
  Future<HttpResponse<LoginResponseModel>> login(@Body() LoginRequestModel request);

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
  Future<List<ChatMessageModel>> getChatMessages(@Path('sessionId') String sessionId);

  // Note: Messages are sent via WebSocket, not REST POST
  // The endpoint only supports GET for retrieving messages

  @POST(ApiEndPoints.endChatSession)
  @Extra({'auth': true})
  Future<dynamic> endChatSession(@Path('sessionId') String sessionId);


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
}
