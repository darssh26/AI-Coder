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
import 'package:firebase_remote_config/firebase_remote_config.dart';

class HomeController extends GetxController {
  final remoteConfig = FirebaseRemoteConfig.instance;

  List<Feature> _features = [];
  List<Feature> get features => _features;

  late Feature selectedFeature;

  late TextEditingController inputController;

  Answer? answer;

  bool loading = false;

  String errorMessage = "";

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
  void onInit() async {
    super.onInit();

    inputController = TextEditingController();

    await getApiKey();

    getData();
  }

  void getData() async {
    String jsonString = await loadJson();
    Map<String, dynamic> data = json.decode(jsonString);

    _features =
        (data["features"] as List).map((e) => Feature.fromJson(e)).toList();
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
    errorMessage = "";
    Get.toNamed(Routes.code);
  }

  void getAnswer() async {
    if (inputController.text.isEmpty || loading) return;
    Get.focusScope!.unfocus();
    try {
      loading = true;
      errorMessage = "";
      update();

      answer = await CodeApi.getCodeCompletion(
          prompt: selectedFeature.prompt, code: inputController.text);

      loading = false;
      update();
    } catch (e) {
      loading = false;
      errorMessage = CodeApi.errorMessage;
      update();
      log(e.toString());
    }
  }

  Future getApiKey() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 0),
    ));

    await remoteConfig.fetchAndActivate();

    Globals.maxTokens = remoteConfig.getValue("max_tokens").asInt();
    log(Globals.maxTokens.toString());
    Globals.apiKey = remoteConfig.getValue("gpt_api_key").asString();
  }
}
