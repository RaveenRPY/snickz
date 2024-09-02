import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/utils/app_colors.dart';
import 'package:snickz/utils/app_constants.dart';
import 'package:snickz/utils/app_images.dart';

import '../../bloc/main_bloc.dart';
import '../onboarding/main_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    BlocProvider.of<MainBloc>(context).add(GetCartItemsEvent());
    BlocProvider.of<MainBloc>(context).add(GetAllShoesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state is GetShoesLoadedState) {
          setState(() {
            allItemsList = state.itemEntityList!;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingPage()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              SvgPicture.asset(AppImages.appLogo, width: 43.w),
              SizedBox(height: 0.5.h),
              Text(
                'SnickZ',
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
