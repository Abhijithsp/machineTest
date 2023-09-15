import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../modules/dashboard/data_model/data_grid_response.dart';
import '../utils/constants/api_path.dart';

class NetworkService {
  var dio = Dio();

  Future<dynamic> getData() async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';
      var response = await dio.get(ApiUrls.baseUrl);

      if (response.statusCode == 200) {
        return response.data
            .map<DataGridResponse>((e) => DataGridResponse.fromJson(e))
            .toList();
      } else {
        return response.statusCode.toString();
      }
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      return e.toString();
    }
  }
}
