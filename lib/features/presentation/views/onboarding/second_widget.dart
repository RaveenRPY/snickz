import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/utils/app_colors.dart';
import 'package:snickz/utils/app_images.dart';

class SecondOn extends StatelessWidget {
  const SecondOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 11.h,
            left: 5.w,
            child: SvgPicture.asset(AppImages.onboardingSecondElements,
                width: 85.w)),
        Padding(
          padding: EdgeInsets.only(top: 14.h),
          child: Image.asset(
            AppImages.onboardingSecondShoe, width: 90.w,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5.w, 0,5.w,23.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  'Let’s Start Journey\nWith Nike',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      color: AppColors.whiteColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 1.h,),
              Center(
                child: Text(
                  'Smart, Gorgeous & Fashionable\nCollection Explore Now',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      color: AppColors.grayColor,
                      fontSize: 14),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
