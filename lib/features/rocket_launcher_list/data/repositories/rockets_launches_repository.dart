import 'package:dio/dio.dart';

class RocketsLaunchesRepository {
  final Dio _dio = Dio();

  static const String _rocketsUpcomingURL =
      "https://api.spacexdata.com/v4/launches/upcoming";

  Future<List<dynamic>> dioGetAllUpcomingLaunches() async {
    try {
      final response = await _dio.get(_rocketsUpcomingURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      return [
        {"error": "Error getting all upcoming launches:\n${e.message}"}
      ];
    }
    return [
      {"error": "Unexpected error while getting all upcoming launches!"}
    ];
  }

  static const String _launchpadsURL =
      "https://api.spacexdata.com/v4/launchpads";

  Future<dynamic> dioGetLaunchpadNameByID(String launchpad) async {
    String launchpadsWithIdURL = "$_launchpadsURL/$launchpad";
    try {
      final response = await _dio.get(launchpadsWithIdURL);

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException {
      return "";
    }
    return "";
  }
}
