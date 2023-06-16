import 'package:dio/dio.dart';

class RocketsRepository {
  final Dio _dio = Dio();

  static const String _rocketsURL = "https://api.spacexdata.com/v4/rockets";

  Future<Map<String, dynamic>> dioGetAllRockets() async {
    try {
      final response = await _dio.get(_rocketsURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      return {"error": "Error getting all rockets:\n${e.message}"};
    }
    return {"error": "Unexpected error while getting all rockets!"};
  }
}
