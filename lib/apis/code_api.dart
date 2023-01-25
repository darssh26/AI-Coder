import 'dart:convert';
import 'dart:developer';

import 'package:aicoder/globals.dart';
import 'package:aicoder/models/answer.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CodeApi {
  static String errorMessage = "";
  static Future<Answer?> getCodeCompletion(
      {required String prompt, required String code}) async {
    Answer? answer;
    errorMessage = "";
    try {
      var response = await http.post(Uri.parse(Globals.completionsUrl),
          body: json.encode({
            "model": Globals.modelUsed,
            "prompt": prompt + code,
            "max_tokens": Globals.maxTokens,
          }),
          headers: {
            "Authorization": "Bearer ${Globals.apiKey}",
            "Content-Type": "application/json",
          });

      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      debugPrint(jsonResponse.toString());

      if (response.statusCode == 200) {
        answer = Answer.fromJson(jsonResponse);
      } else {
        errorMessage =
            jsonResponse['error']['message'] ?? "Something went wrong!";
        throw "Something went wrong!";
      }
    } catch (e) {
      log(e.toString());
      //errorMessage = e.toString();
      rethrow;
    }

    return answer;
  }
}
