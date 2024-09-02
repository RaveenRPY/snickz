import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  final bool? isHome;
  final String? title;
  final Widget? leadingIcon;
  final Function? leadingOnTap;
  final Widget? actionIcon;
  final Function? actionOnTap;

  const CustomAppBar(
      {super.key,
      this.isHome = false,
      this.title,
      this.leadingIcon,
      this.leadingOnTap,
      this.actionIcon,
      this.actionOnTap});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: widget.isHome!
          ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    widget.title ?? '',
                    style: GoogleFonts.raleway(
                        fontSize: 28,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                    left: 5,
                    top: 2,
                    child: SvgPicture.asset(
                      AppImages.onboardingFirstElement2,
                      color: AppColors.blackColor,
                      width: 20,
                    ))
              ],
            )
          : Text(
              widget.title ?? '',
              style: GoogleFonts.raleway(
                  fontSize: 18,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600),
            ),
      leading: Padding(
        padding: const EdgeInsets.all(7.0),
        child: InkWell(
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(90),
          child: Container(
            decoration: BoxDecoration(
                color: widget.leadingIcon != null ? AppColors.whiteColor: Colors.transparent,
                borderRadius: BorderRadius.circular(90)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              // child: SvgPicture.asset(AppImages.icMenu),
              child: widget.leadingIcon,
            ),
          ),
          onTap: () {
            widget.leadingOnTap!();
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: InkWell(
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(90),
            child: Container(
              decoration: BoxDecoration(
                  color: widget.actionIcon != null ? AppColors.whiteColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(90)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: widget.actionIcon,
              ),
            ),
            onTap: () {
              widget.actionOnTap!();
            },
          ),
        ),
      ],
    );
  }
}
