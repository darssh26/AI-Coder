import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:aicoder/apis/code_api.dart';
import 'package:aicoder/globals.dart';
import 'package:aicoder/models/answer.dart';
import 'package:aicoder/models/feature.dart';
import 'package:aicoder/views/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<Feature> _features = [];
  List<Feature> get features => _features;

  late Feature selectedFeature;

  late TextEditingController inputController;

  Answer? answer;

  bool loading = false;

  List<Color> colors = const [
    Color(0xFF10A19D),
    Color(0xFF540375),
    Color(0xFFFF7000),
    Color(0xFFFFBF00),
    Color(0xFF10A19D),
    Color(0xFF540375),
    Color(0xFFFF7000),
    Color(0xFFFFBF00),
    Color(0xFF10A19D),
    Color(0xFF540375),
    Color(0xFFFF7000),
    Color(0xFFFFBF00),
    Color(0xFF10A19D),
    Color(0xFF540375),
    Color(0xFFFF7000),
    Color(0xFFFFBF00),
  ];

  late Color selectedColor;

  @override
  void onInit() {
    super.onInit();

    inputController = TextEditingController();

    getData();
  }

  void getData() async {
    String jsonString = await loadJson();
    Map<String, dynamic> data = json.decode(jsonString);

    _features =
        (data["features"] as List).map((e) => Feature.fromJson(e)).toList();
    Globals.maxTokens = data['max_tokens'];
    Timer(const Duration(seconds: 2), goHome);
  }

  void goHome() {
    Get.offNamed(Routes.home);
  }

  Future<String> loadJson() async {
    return await rootBundle.loadString("assets/jsons/main.json");
  }

  void goToCodeScreen(Feature f, Color s) {
    selectedFeature = f;
    selectedColor = s;
    inputController.clear();
    answer = null;
    Get.toNamed(Routes.code);
  }

  void getAnswer() async {
    if (inputController.text.isEmpty || loading) return;
    Get.focusScope!.unfocus();
    try {
      loading = true;
      update();

      answer = await CodeApi.getCodeCompletion(
          prompt: selectedFeature.prompt, code: inputController.text);

      loading = false;
      update();
    } catch (e) {
      log(e.toString());
    }
  }
}
