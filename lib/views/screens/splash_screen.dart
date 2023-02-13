import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 100.w,
            height: 100.h,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset("assets/images/splash.png"),
            ),
          ),
          Container(
            width: 100.w,
            height: 100.h,
            color: Colors.black.withOpacity(0.5),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFFFFF).withAlpha(30),
                  blurRadius: 20.0,
                  spreadRadius: 0.0,
                  offset: const Offset(
                    2.0,
                    3.0,
                  ),
                ),
              ],
            ),
            child: Text(
              "Code Mentor",
              style: GoogleFonts.roboto(
                fontSize: 30.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
