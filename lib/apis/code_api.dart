import 'dart:convert';
import 'dart:developer';

import 'package:aicoder/globals.dart';
import 'package:aicoder/models/answer.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CodeApi {
  static Future<Answer?> getCodeCompletion(
      {required String prompt, required String code}) async {
    Answer? answer;
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

      var jsonResponse = json.decode(response.body);

      debugPrint(jsonResponse.toString());

      if (response.statusCode == 200) {
        answer = Answer.fromJson(jsonResponse);
      } else {
        throw "Something went wrong!";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }

    return answer;
  }
}
