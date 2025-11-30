import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart'; // Add this import

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
