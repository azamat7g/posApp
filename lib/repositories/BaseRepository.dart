import 'dart:convert';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:posapp/enums/HttpMethods.dart';
import 'package:posapp/services/StorageService.dart';

class BaseRepository {
  String apiDomain = 'https://frontend-task.depocloud.ml/api/mobile';

  final StorageService storage = Get.find();

  String buildUrl(url) {
    return "${this.apiDomain}/$url";
  }

  Future makeHttpRequest(String url, body, {bool withAuth = false, HttpMethodTypes method = HttpMethodTypes.POST}) async {
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      if (withAuth) headers['Authorization'] = 'Bearer ${this.storage.activeToken}';

      if ([HttpMethodTypes.GET, HttpMethodTypes.DELETE].contains(method) && body != null) {
        String queryString = Uri(queryParameters: body).query;
        String separator = (url.contains('?')) ? "&" : "?";

        url += separator + queryString;
      }

      http.Request req = http.Request(method.toString().split('.').last, Uri.parse(this.buildUrl(url)))..followRedirects = false;

      req.headers.addAll(headers);

      if ([HttpMethodTypes.POST, HttpMethodTypes.PUT].contains(method)) req.body = jsonEncode(body);

      http.StreamedResponse stream = await req.send();
      http.Response response = await http.Response.fromStream(stream);

      Logger().d("HTTP: ${response.statusCode.toString()}, BODY: $body, ${utf8.decode(response.bodyBytes)}, URL: $url");

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
