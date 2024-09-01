import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/utils/app_colors.dart';
import 'package:snickz/utils/app_images.dart';

class ThirdOn extends StatelessWidget {
  const ThirdOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 9.h,
            left: 0.w,
            child: SvgPicture.asset(AppImages.onboardingThirdElements,
                width: 98.w)),
        Padding(
          padding: EdgeInsets.only(top: 3.h),
          child: Image.asset(
            AppImages.onboardingThirdShoe, width: 94.w,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5.w, 0,5.w,23.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  'You Have the\nPower To',
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
                  'There Are Many Beautiful And Attractive\nPlants To Your Room',
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
