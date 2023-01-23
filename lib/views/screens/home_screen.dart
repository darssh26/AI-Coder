import 'package:aicoder/controllers/home_controller.dart';
import 'package:aicoder/views/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            ClipRRect(
              child: SizedBox(
                width: 100.w,
                height: 25.h,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset("assets/images/header.png"),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 4.h),
                children: controller.features.asMap().entries.map((e) {
                  return InkWell(
                    onTap: () {
                      controller.goToCodeScreen(
                          e.value, controller.colors[e.key]);
                    },
                    child: Container(
                      width: 90.w,
                      margin:
                          EdgeInsets.only(bottom: 2.h, right: 2.w, left: 2.w),
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(
                              width: 4, color: controller.colors[e.key]),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            blurRadius: 4.0,
                            spreadRadius: 0.0,
                            offset: const Offset(
                              2.0,
                              3.0,
                            ),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.value.title,
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Divider(
                                  endIndent: 20.w,
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  e.value.subtitle,
                                  style: GoogleFonts.roboto(
                                    fontSize: 10.sp,
                                    height: 1.4,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15.sp,
                            color: controller.colors[e.key],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
