import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:monster_library/API/env.dart';

Future<http.Response> getAllIndexes() async {
  late http.Response response;

  try {
    var url = Uri.parse('${BASE_URL}/monsters/');
    response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ).timeout(
        const Duration(seconds: 15),

        onTimeout: () {
          return http.Response('Error, request timed out.', 408);
        }
    );

    log('Response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Success');
    }
  }
  catch (e) {
    response = http.Response('An error occurred', 400);
    log('Error: $e');
  }

  return response;
}