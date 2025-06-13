import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static Future<dynamic> post({
    required String uri,
    String? token,
    required Map<String, dynamic> body,
  }) async {
    var url = Uri.parse(uri);

    var headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      var json = jsonEncode(body);
      var response = await http.post(url, headers: headers, body: json);
      print(response.body);
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return {"status": "200", "body": result};
      } else {
        print("ERROR: ${response.statusCode}");
        print(response.body);
        return {"status": "400", "body": result};
      }
    } catch (e) {
      print(e.toString());
      throw FormatException('Invalid JSON format: ${e.toString()}');
    }
  }

  static Future<dynamic> put({
    required String uri,
    String? token,
    required Map<String, dynamic> body,
  }) async {
    var url = Uri.parse(uri);

    var headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      var json = jsonEncode(body);
      var response = await http.put(url, headers: headers, body: json);
      print(response.body);
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return {"status": "200", "body": result};
      } else {
        print("ERROR: ${response.statusCode}");
        print(response.body);
        return {"status": "400", "body": result};
      }
    } catch (e) {
      print(e.toString());
      throw FormatException('Invalid JSON format: ${e.toString()}');
    }
  }

static Future<dynamic> get({
    required String uri,
    String? token,
  }) async {
    var url = Uri.parse(uri);

    var headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.get(url, headers: headers);
      print(response.body);
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return {"status": "200", "body": result};
      } else {
        print("ERROR: ${response.statusCode}");
        print(response.body);
        return {"status": "400", "body": result};
      }
    } catch (e) {
      print(e.toString());
      throw FormatException('Invalid JSON format: ${e.toString()}');
    }
  }



}
