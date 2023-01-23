import 'package:aicoder/initial_binding.dart';
import 'package:aicoder/views/routes/app_pages.dart';
import 'package:aicoder/views/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'AI Coder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        getPages: AppPages.pages,
        initialRoute: Routes.initial,
        initialBinding: InitialBinding(),
      );
    });
  }
}
