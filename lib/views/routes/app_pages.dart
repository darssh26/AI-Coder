import 'package:aicoder/views/screens/code_screen.dart';
import 'package:aicoder/views/screens/home_screen.dart';
import 'package:aicoder/views/screens/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.code,
      page: () => const CodeScreen(),
    ),
  ];
}
