import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/features/presentation/views/cart/cart_view.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_constants.dart';
import '../../widgets/app_bar.dart';

class ItemDetailsView extends StatefulWidget {
  const ItemDetailsView({super.key});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  bool _isLoading = false;
  bool _isSuccess = false;

  Future<void> _handleButtonPress() async {
    setState(() {
      _isLoading = true;
      _isSuccess = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _isSuccess = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sneaker Shop',
        leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded),
        actionIcon: SvgPicture.asset(AppImages.icCart),
        leadingOnTap: () {
          Navigator.of(context).pop();
        },
        actionOnTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartView()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(kLeftRightMarginOnBoarding, 0,
            kLeftRightMarginOnBoarding, kBottomMargin),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kTopMarginOnBoarding),
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        'Nike Air Max 270 Essential',
                        style: GoogleFonts.raleway(
                            fontSize: 26,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Outdoor Shoes',
                      style: GoogleFonts.raleway(
                          fontSize: 16,
                          color: AppColors.itemTitleGrey,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'LKR 14,990.00',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 3.h),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.h, left: 10),
                          child: SvgPicture.asset(AppImages.detailsCurve),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 32.h,
                          child: Image.asset(
                            AppImages.itemShoe1,
                            scale: 0.9,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      'The Nike Air Max 270 Essential is a versatile sneaker that blends modern design with the signature comfort of Nike’s Air Max technology...',
                      style: GoogleFonts.raleway(
                          fontSize: 14,
                          color: AppColors.itemTitleGrey,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ButtonStyle(
                    surfaceTintColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                    backgroundColor: MaterialStateProperty.all(_isLoading
                        ? AppColors.primaryColor
                        : (_isSuccess ? Colors.green : AppColors.primaryColor)),
                    elevation: const MaterialStatePropertyAll(0),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)))),
                onPressed: _isLoading || _isSuccess ? null : _handleButtonPress,
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : _isSuccess
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Successfully Added',
                                style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImages.icCart,
                                color: AppColors.whiteColor,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                'Add To Cart',
                                style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteColor),
                              ),
                            ],
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
