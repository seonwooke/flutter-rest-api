import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'picsum_model.dart';

class PicsumRepository {
  PicsumRepository._privateConstructor();
  static final PicsumRepository _instance =
      PicsumRepository._privateConstructor();
  static PicsumRepository get instance => _instance;

  /// http 패키지를 이용한 REST API 통신
  Future<List<PicsumModel>> fetchDataUsingHttp() async {
    try {
      int pageNumber = 1;
      http.Response response = await http.get(
        Uri.parse(
          "https://picsum.photos/v2/list?page=$pageNumber&limit=10",
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<PicsumModel> result = data.map((element) {
          return PicsumModel.fromJson(element);
        }).toList();
        return result;
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('[picsum_repository / fetchDataUsingHttp] $error');
      return [];
    }
  }

  /// Dio 패키지를 이용한 REST API 통신
  Future<List<PicsumModel>> fetchDataUsingDio() async {
    try {
      final Dio dio = Dio();
      int pageNumber = 1;
      final response = await dio.get(
        "https://picsum.photos/v2/list?page=$pageNumber&limit=10",
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data as List<dynamic>;
        List<PicsumModel> result = data.map((element) {
          return PicsumModel.fromJson(element);
        }).toList();
        return result;
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('[picsum_repository / fetchDataUsingDio] $error');
      return [];
    }
  }
}
