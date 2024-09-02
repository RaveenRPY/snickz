import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/features/presentation/widgets/app_bar.dart';
import 'package:snickz/features/presentation/widgets/bottom_navigation_bar.dart';
import 'package:snickz/features/presentation/widgets/item_card.dart';
import 'package:snickz/utils/app_constants.dart';
import 'package:snickz/utils/app_images.dart';

import '../../../../utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> items = [
  "All Shoes",
  "Outdoor",
  "Tennis",
  "Indoor",
  "Spikes"
];

class _HomePageState extends State<HomePage> {
  int selectedBottomIndex = 0;
  int selectedCatIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.whiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        isHome: true,
        title: 'Explorer',
        leadingIcon: SvgPicture.asset(AppImages.icMenu),
        actionIcon: SvgPicture.asset(AppImages.icCart),
        leadingOnTap: () {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kLeftRightMarginOnBoarding),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.blackColor.withOpacity(0.2),
                            offset: const Offset(0, 4),
                            blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: TextFormField(
                        cursorColor: AppColors.blackColor.withOpacity(0.6),
                        onTapOutside: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Looking for shoes',
                            hintStyle: GoogleFonts.raleway(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(AppImages.icSearch),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(CircleBorder()),
                          elevation: MaterialStatePropertyAll(6),
                          surfaceTintColor:
                              MaterialStatePropertyAll(Colors.transparent),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.primaryColor),
                          padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
                          fixedSize: MaterialStatePropertyAll(Size.infinite)),
                      onPressed: () {},
                      child: SvgPicture.asset(
                        AppImages.icSliders,
                        color: AppColors.whiteColor,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(kLeftRightMarginOnBoarding,
                kTopMarginOnBoarding, kLeftRightMarginOnBoarding, 10),
            child: Text(
              'Select Category',
              style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      index == 0 ? kLeftRightMarginOnBoarding : 0, 5, 16, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCatIndex = index;
                      });
                    },
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        elevation: MaterialStatePropertyAll(
                            selectedCatIndex == index ? 5 : 1),
                        surfaceTintColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        backgroundColor: MaterialStatePropertyAll(
                            selectedCatIndex == index
                                ? AppColors.primaryColor
                                : AppColors.whiteColor)),
                    child: Text(
                      items[index],
                      style: GoogleFonts.raleway(
                          fontSize: 12,
                          fontWeight: selectedCatIndex == index
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: selectedCatIndex == index
                              ? AppColors.whiteColor
                              : AppColors.blackColor),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: kOnBoardingMarginBetweenFields / 2),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kLeftRightMarginOnBoarding,
                    vertical: kOnBoardingMarginBetweenFields / 2),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index){
                    return ItemCard(index: index);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    mainAxisExtent: 250,
                    crossAxisSpacing: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: CustomBottomNaviBar(onItemSelected: (index) {
        setState(() {
          selectedBottomIndex = index;
        });
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.8), // Shadow color
              spreadRadius: 0.2,
              blurRadius: 20,
              offset: const Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            setState(() {});
          },
          backgroundColor: AppColors.primaryColor,
          child: SvgPicture.asset(
            AppImages.icCart,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Align(
      child: ItemCard(
        index: index,
      ),
    );
  }
}
