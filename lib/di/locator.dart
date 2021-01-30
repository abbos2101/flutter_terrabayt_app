import 'package:flutter_terrabayt_app/data/net/dio_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void locatorSetup() {
  locator.registerSingleton(DioService());
}
