import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/features/presentation/widgets/main_button.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({
    super.key,
    this.title,
    this.image,
    this.isTwoButton = true,
    this.negativeButtonText,
    this.positiveButtonText,
    this.negativeButtonTap,
    this.positiveButtonTap,
    this.messege,
  });

  final String? title;
  final String? messege;
  final String? image;
  final bool isTwoButton;
  final String? negativeButtonText;
  final String? positiveButtonText;
  final Function? negativeButtonTap;
  final Function? positiveButtonTap;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        alignment: FractionalOffset.center,
        padding:  const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Material(
          color: AppColors.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Wrap(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.8.h, horizontal: 2.6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        image ?? AppImages.successDialog,
                        frameRate: const FrameRate(120),
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      title ?? '',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      messege ?? '',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textTitleColor),
                    ),
                    const SizedBox(height: 35),
                    Row(
                      children: [
                        if (isTwoButton)
                          Expanded(
                            child: MainButton(
                              title: negativeButtonText ?? '',
                              bgColor: AppColors.disableGray,
                              onPressed: () {
                                negativeButtonTap!();
                              },
                            ),
                          ),
                        if (isTwoButton) SizedBox(width: 2.5.w),
                        Expanded(
                          child: MainButton(
                            title: positiveButtonText ?? '',
                            onPressed: () {
                              positiveButtonTap!();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    String? title,
    String? message,
    String? image,
    bool isTwoButton = true,
    String? negativeButtonText,
    String? positiveButtonText,
    VoidCallback? negativeButtonTap,
    VoidCallback? positiveButtonTap,
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: false,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: CustomDialogBox(
              title: title,
              messege: message,
              image: image,
              negativeButtonText: negativeButtonText,
              positiveButtonText: positiveButtonText,
              negativeButtonTap: negativeButtonTap,
              positiveButtonTap: positiveButtonTap,
              isTwoButton: isTwoButton,
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return const SizedBox.shrink();
      },
    );
  }
}
