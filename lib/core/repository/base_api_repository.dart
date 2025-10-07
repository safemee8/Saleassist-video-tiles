import 'package:dio/dio.dart';

class BaseApiRepo {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://vtiles.saleassist.ai/",
  ));
}
