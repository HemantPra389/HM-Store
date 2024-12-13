import 'package:dio/dio.dart';

import 'logger_helper.dart';
import 'url_constants.dart';

class THttpHandler {
  static final Dio dio = Dio();
  static final Map<String, dynamic> headers = {
    "x-rapidapi-host": "apidojo-hm-hennes-mauritz-v1.p.rapidapi.com",
    "x-rapidapi-key": "1c024eae26mshcc89d4d55994482p16ff2bjsnd88d7f987722"
  };

  static Future post(
      {required String endPointUrl, required Map<String, dynamic> body}) async {
    try {
      var response = await dio.post("${TUrlConstants.mainUrl}$endPointUrl",
          data: body, options: Options(headers: headers));
      return response.data;
    } catch (e) {
      TLoggerHelper.error(e.toString());
    }
  }

  static Future get(
      {required String endPointUrl,
      Map<String, String>? queryParameters}) async {
    try {
      var response = await dio.get("${TUrlConstants.mainUrl}$endPointUrl",
          queryParameters: queryParameters, options: Options(headers: headers));
      return response.data;
    } catch (e) {
      TLoggerHelper.error(e.toString());
    }
  }
}
