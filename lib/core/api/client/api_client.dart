
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/auth/data/models/login_models/login_request_model.dart';
import '../../../features/auth/data/models/login_models/login_response_model.dart';
import '../../../features/auth/data/models/signupmodels/sign_up_request_model.dart';
import '../../../features/auth/data/models/signupmodels/sign_up_response_model.dart';
import '../api_constants/api_end_points.dart';



part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _ApiClient;


  @POST(ApiEndPoints.register)
  Future<SignUpResponseModel> signUp(@Body() SignUpRequest request);

  @POST(ApiEndPoints.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);

}

