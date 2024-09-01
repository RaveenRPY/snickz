import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/utils/app_colors.dart';
import 'package:snickz/utils/app_images.dart';

class FirstOn extends StatelessWidget {
  const FirstOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(11.w, 14.h, 13.w, 0),
          child:
              SvgPicture.asset(AppImages.onboardingFirstElement, width: 100.w),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Image.asset(
            AppImages.onboardingFirstShoe,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          left: 18.w,
          top: 8.5.h,
          child: SvgPicture.asset(AppImages.onboardingFirstElement2),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              'Wellcome To\nSnickZ',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                  color: AppColors.whiteColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }
}
