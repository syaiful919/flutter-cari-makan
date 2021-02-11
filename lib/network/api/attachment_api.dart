import 'dart:convert';
import 'dart:io';

import 'package:carimakan/utils/config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AttachmentApi {
  Future<String> uploadMedia({
    @required File file,
    @required String token,
  }) async {
    String apiUrl = "user/photo";

    var request = http.MultipartRequest('POST', Uri.parse(baseUrl() + apiUrl));
    request.headers["Content-Type"] = "application/json";
    request.headers["Authorization"] = "Bearer $token";

    String fileName = file.path.split("/").last;

    request.files.add(
      http.MultipartFile('file', File(file.path).readAsBytes().asStream(),
          File(file.path).lengthSync(),
          filename: fileName),
    );

    var apiResponse = await request.send();

    if (apiResponse.statusCode == 200) {
      http.Response jsonResponsefromStream =
          await http.Response.fromStream(apiResponse);
      var jsonResponse = json.decode(jsonResponsefromStream.body);
      return storageUrl() + jsonResponse['data'][0];
    } else {
      throw Exception("Upload Failed");
    }
  }
}
