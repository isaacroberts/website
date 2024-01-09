import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:developer';

const String hostName = kDebugMode ? 'http://127.0.0.1:5000' : '';

const HEADERS = {
  'Content-type': 'application/json',
// 'Accept': '*',
// "Access-Control-Allow-Origin": "*",
};

Future<dynamic?> sendToServer(String function,
    {Map<String, dynamic>? body}) async {
  var send = body != null ? jsonEncode(body) : {};

  try {
    var response = await post(Uri.parse('$hostName/$function'), body: send);

    log('Response: $response');
    log('Response code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      log('Error: ${response.reasonPhrase ?? 'Not submitted'}');

      return null;
    }
  } catch (exception, stacktrace) {
// log(stacktrace.toString());
    if (kDebugMode) {
      print("Exception:");
      print(exception.toString());
      print(stacktrace);
    }
    return null;
  }
}

// Returns error message if not successful
Future<String?> sendSignup(String emailAddress, String body) async {
  if (kDebugMode) {
    return null;
  }

  var map = <String, dynamic>{};
  map['email'] = emailAddress;
  map['body'] = body;

  var send = jsonEncode(map);
  log('sending:$send');
  try {
    var response = await post(Uri.parse('$hostName/contact'),
        body: send, headers: HEADERS);
    log('Response: $response');
    log('Response code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return null;
    } else {
      return 'Error: ${response.reasonPhrase ?? 'Not submitted'}';
    }
  } catch (exception, stacktrace) {
    // log(stacktrace.toString());
    if (kDebugMode) {
      print("Exception:");
      print(exception.toString());
      print(stacktrace);
    }
    return exception.toString();
  }
}