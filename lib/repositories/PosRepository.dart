import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:posapp/enums/HttpMethods.dart';
import 'package:posapp/models/BarcodeProduct.dart';
import 'package:posapp/models/History.dart';
import 'package:posapp/models/Product.dart';
import 'package:posapp/repositories/BaseRepository.dart';

class PosRepository extends BaseRepository {
  Future<String> login(String phone, String password) async {
    Response response = await this.makeHttpRequest("login", {"phone_number": phone, "password": password});

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));

      return result["access_token"];
    }

    throw ("Error");
  }

  Future<bool> logout() async {
    Response response = await this.makeHttpRequest("logout", {}, withAuth: true);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<List<Product>> query(String keyword) async {
    Response response = await this.makeHttpRequest("items/search", {"query": keyword}, method: HttpMethodTypes.GET, withAuth: true);

    if (response.statusCode == 200) {
      var products = <Product>[];
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));

      for (var item in result["items"]) {
        var model = BarcodeProduct.fromJson(item);

        try {
          var product = await this.queryByBarcode(model.barcode);
          products.add(product);
        } catch (e) {}
      }

      return products;
    }

    throw ("Error");
  }

  Future<Product> queryByBarcode(String code) async {
    Response response = await this.makeHttpRequest("items/show", {"barcode": code}, method: HttpMethodTypes.GET, withAuth: true);

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));

      return Product.fromJson(result['item']);
    }

    throw ("Error");
  }

  Future<List<History>> getHistory() async {
    Response response = await this.makeHttpRequest("sales", null, method: HttpMethodTypes.GET, withAuth: true);

    if (response.statusCode == 200) {
      var model = <History>[];
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));

      for (var item in result["sales"]) {
        try {
          var data = await this.getSail(item["id"]);

          var sum = 0;
          for (var item in data["sale"]["items"]) {
            sum += item["price"] as int;
          }

          model.add(
            History(
              item["id"],
              item["cashier"],
              data["sale"]["items"].length,
              sum,
            ),
          );
        } catch (e) {}
      }

      return model;
    }

    throw ("Error2");
  }

  Future<Map<String, dynamic>> getSail(int id) async {
    Response response = await this.makeHttpRequest("sales/show?sale_id=${id.toString()}", null, method: HttpMethodTypes.GET, withAuth: true);

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }

    throw ("Error");
  }
}
