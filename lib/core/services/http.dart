import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  static Future<dynamic> delete({
    required String uri,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    var url = Uri.parse(uri);

    var headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      var json = jsonEncode(body);
      var response = await http.delete(url, headers: headers, body: json);
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
    Map<String, dynamic>? body,
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

  static Future<dynamic> get({required String uri, String? token}) async {
    var url = Uri.parse(uri);

    var headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.get(url, headers: headers);
      // print(response.body);
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // print(response.body);
        return {"status": "200", "body": result};
      } else {
        print("ERROR: ${response.statusCode}");
        // print(response.body);
        return {"status": "400", "body": result};
      }
    } catch (e) {
      print(e.toString());
      throw FormatException('Invalid JSON format: ${e.toString()}');
    }
  }

  static Future<dynamic> postPhoto({
    required String uri,
    required String fileName,
    required File file,
    required String token,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.files.add(
      await http.MultipartFile.fromPath(
        "photo",
        file.path,
        filename: fileName,
        contentType: MediaType("photo", fileName.split(".").last),
      ),
    );
    request.headers["Authorization"] = "Bearer $token";
    request.headers["Accept"] = "application/json";

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
      print(jsonResponse);
      return {"status": "200", "body": jsonResponse};
    } else {
      print("ERROR: ${response.statusCode}");
      return {"status": "400", "body": "SomeThing Went Wrong, Try Again"};
    }
  }
}
