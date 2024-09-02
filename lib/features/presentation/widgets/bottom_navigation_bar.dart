import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class CustomBottomNaviBar extends StatefulWidget {
  final Function(int) onItemSelected;
  const CustomBottomNaviBar({super.key, required this.onItemSelected});

  @override
  State<CustomBottomNaviBar> createState() => _CustomBottomNaviBarState();
}

class _CustomBottomNaviBarState extends State<CustomBottomNaviBar> {
  static int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 50,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomAppBar(
          surfaceTintColor: Colors.transparent,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10.0,
          elevation: 1,
          color: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _onItemTapped(0);
                  },
                  borderRadius: BorderRadius.circular(90),
                  radius: 10,
                  highlightColor: Colors.transparent,
                  splashColor: AppColors.primaryColor.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppImages.icHome,
                      color: selectedIndex == 0
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _onItemTapped(1);
                  },
                  borderRadius: BorderRadius.circular(90),
                  radius: 10,
                  highlightColor: Colors.transparent,
                  splashColor: AppColors.primaryColor.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppImages.icFavorite,
                      color: selectedIndex == 1
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    _onItemTapped(2);
                  },
                  borderRadius: BorderRadius.circular(90),
                  radius: 10,
                  highlightColor: Colors.transparent,
                  splashColor: AppColors.primaryColor.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppImages.icNotifications,
                      color: selectedIndex == 2
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _onItemTapped(3);
                  },
                  borderRadius: BorderRadius.circular(90),
                  radius: 10,
                  highlightColor: Colors.transparent,
                  splashColor: AppColors.primaryColor.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppImages.icProfile,
                      color: selectedIndex == 3
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
