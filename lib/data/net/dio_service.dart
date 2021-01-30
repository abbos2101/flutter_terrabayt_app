import 'package:dio/dio.dart';
import '../model/post_model.dart';
import '../model/category_model.dart';
import 'dio_base.dart';

class DioService {
  final Dio _dio = Dio();
  final String _baseUrl = DioBase.baseUrl;
  final int _timeOut = DioBase.timeOut;

  Future<List<CategoryModel>> getCategoryList() async {
    Response response = await _dio.request(
      '${_baseUrl}api.php?action=categories',
      options: Options(
        method: 'GET',
        receiveTimeout: _timeOut,
        sendTimeout: _timeOut,
      ),
    );
    if (response.statusCode != 200)
      throw Exception("Internet bilan bog'liq xatolik");
    if (response.data == null) throw Exception("Xatolik sodir bo'ldi");

    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  Future<List<PostModel>> getPostList({
    int firstUpdate = 0,
    int lastUpdate = 0,
    int category = 0,
    int limit = 30,
  }) async {
    Response response = await _dio.request(
      '${_baseUrl}api.php?action=posts'
      '&first_update=$firstUpdate'
      '&last_update=$lastUpdate'
      '&category=$category'
      '&limit=$limit',
      options: Options(
        method: 'GET',
        receiveTimeout: _timeOut,
        sendTimeout: _timeOut,
      ),
    );
    if (response.statusCode != 200)
      throw Exception("Internet bilan bog'liq xatolik");
    if (response.data == null) throw Exception("Xatolik sodir bo'ldi");
    return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
  }
}
