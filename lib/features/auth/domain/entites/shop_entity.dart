import '../../data/models/signup_shop_models/sign_up_shop_request_model.dart';

class ShopEntity {
  final String email;
  final String password;
  final String name;
  final String description;
  final String phone;
  final String shopType;
  final ShopAddress shopAddress;

  ShopEntity({
    required this.email,
    required this.password,
    required this.name,
    required this.description,
    required this.phone,
    required this.shopType,
    required this.shopAddress,
  });
}
