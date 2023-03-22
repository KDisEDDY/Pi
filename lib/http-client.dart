import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert'

class http {

  static Future<http.Response> post(String url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    var client = new http.Client();
    var response = await client.post(url, headers: headers, body: body);
    return response;
  }

  static String wrapBody(String msg) {

    return "{" +
        "}"
  }
}