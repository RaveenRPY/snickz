import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/features/presentation/views/onboarding/first_widget.dart';
import 'package:snickz/utils/app_colors.dart';
import 'package:snickz/utils/app_images.dart';

class SignInPage extends StatefulWidget {
  static const routeName = "/sign-in";

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  int _selectedPage = 0;
  late final _pageController = PageController(initialPage: _selectedPage);

  late final Timer? _timer;

  List<int> get _pageItem => [0, 1, 2];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(days: 1), (time) async {
      final nexPage = (_pageController.page?.toInt() ?? 0) + 1;
      await _pageController.animateToPage(
        nexPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer?.cancel();
  }

  void _pageChanged(int currentPage) {
    _selectedPage = currentPage % _pageItem.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.onBoardingBGColor,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.onBoardingBGColor,
      body: Stack(
        children: [
          Positioned(
            top: 55.h,
            left: -5.w,
            child: SvgPicture.asset(
              AppImages.appLogo,
              width: 128.w,
              color: AppColors.whiteColor.withOpacity(0.1),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _pageChanged,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const FirstOn();
                        case 1:
                          return Center(
                            child: Text(_pageItem[_selectedPage].toString()),
                          );
                        default:
                          return const FirstOn();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      _pageItem.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                              width: index == _selectedPage ? 42 : 25,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: index == _selectedPage
                                      ? AppColors.accentColor
                                      : AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )),
                ],
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(0.5),
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 14)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _selectedPage == 0 ? "Get Started" : "Next",
                        style: GoogleFonts.raleway(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  onPressed: () async {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
