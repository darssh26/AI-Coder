import 'package:aicoder/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CodeScreen extends StatelessWidget {
  const CodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: controller.selectedColor,
          title: Text(
            controller.selectedFeature.title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 20.h,
              margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GetBuilder<HomeController>(builder: (_) {
                return TextField(
                  controller: controller.inputController,
                  enabled: !controller.loading,
                  maxLines: 20,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: InkWell(
                    onTap: () {
                      controller.inputController.clear();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Clear",
                        style: GoogleFonts.roboto(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: InkWell(
                    onTap: () {
                      controller.getAnswer();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: controller.selectedColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Send",
                        style: GoogleFonts.roboto(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GetBuilder<HomeController>(builder: (_) {
                if (controller.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.answer == null) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    child: Text(
                      controller.errorMessage,
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 100.w,
                        height: 5.h,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        margin:
                            EdgeInsets.only(right: 4.w, left: 4.w, top: 2.h),
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                        ),
                        child: InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                  text: controller.answer!.text.trim()),
                            ).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.teal,
                                  content: Text(
                                    "Answer copied to clipboard",
                                    style: GoogleFonts.roboto(
                                      fontSize: 10.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.copy,
                                size: 15.sp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                "Copy",
                                style: GoogleFonts.roboto(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.all(2.w),
                        margin:
                            EdgeInsets.only(right: 4.w, left: 4.w, bottom: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border.all(),
                        ),
                        child: Text(
                          controller.answer!.text.trim(),
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            height: 1.3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
