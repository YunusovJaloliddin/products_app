import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants/api_const.dart';

enum Method {
  get,
  post,
  put,
  patch,
  delete,
}

class APIService {
  const APIService._inctance();

  factory APIService() => _;
  static const _ = APIService._inctance();

  Future<String> request(
      String requestPath, {
        Method method = Method.get,
        String queryParametersAll="",
        Map<String, String> headers = const {},
        Map<String, Object?> body = const {},
      }) async {

    final uri = Uri.parse('${ApiConst.baseUrl}$requestPath$queryParametersAll');
    try {
      Response response = await switch (method) {
        Method.get => get(uri, headers: headers),
        Method.post => post(uri, headers: headers, body: body),
        Method.put => put(uri, headers: headers, body: body),
        Method.patch => patch(uri, headers: headers, body: body),
        Method.delete => delete(uri, headers: headers),
      }
          .timeout(const Duration(seconds: 10));
      return switch (response.statusCode) {
        < 200 => throw Error.throwWithStackTrace(
          "${response.reasonPhrase}",
          StackTrace.current,
        ),
        >= 200 && < 300 => response.body,
        > 399 && < 500 => throw Error.throwWithStackTrace(
          "Client error",
          StackTrace.current,
        ),
        >= 500 => throw Error.throwWithStackTrace(
          "Server error",
          StackTrace.current,
        ),
        _ => throw Error.throwWithStackTrace(
          "Unexpected Error",
          StackTrace.current,
        ),
      };
    } on TimeoutException catch (e, s) {
      debugPrint("$e\n$s");
      return throw Error.throwWithStackTrace(
        "Check your network connection!",
        StackTrace.current,
      );
    } catch (e, s) {
      debugPrint("$e\n$s");
      rethrow;
    }
  }
}
