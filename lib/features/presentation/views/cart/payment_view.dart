import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/features/presentation/views/home/home_page.dart';
import 'package:snickz/features/presentation/widgets/app_bar.dart';
import 'package:snickz/features/presentation/widgets/cart_list_item.dart';
import 'package:snickz/features/presentation/widgets/custom_dialog_box.dart';
import 'package:snickz/features/presentation/widgets/main_button.dart';
import 'package:snickz/utils/app_constants.dart';
import 'package:snickz/utils/app_images.dart';
import 'package:snickz/utils/app_utils.dart';

import '../../../../utils/app_colors.dart';
import '../../../domain/entities/item_entity.dart';
import '../../bloc/main_bloc.dart';

class PaymentView extends StatefulWidget {
  final double subTotal;
  final double total;
  final double deliveryFee;

  const PaymentView({
    super.key,
    required this.subTotal,
    required this.total,
    required this.deliveryFee,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView>
    with SingleTickerProviderStateMixin {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  late final controller = SlidableController(this);

  bool? isEmailValidated;
  bool? isMobileValidated;
  bool? isAddressValidated;

  late String email;
  late String mobile;
  late String address;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Billing Info',
        leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded),
        leadingOnTap: () {
          Navigator.of(context).pop();
        },
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                kLeftRightMarginOnBoarding,
                kOnBoardingMarginBetweenFields,
                kLeftRightMarginOnBoarding,
                kBottomMargin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: kLeftRightMarginOnBoarding,
                  vertical: kTopMarginOnBoarding),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Contact Information',
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor),
                  ),
                  const SizedBox(height: kOnBoardingMarginBetweenFields / 2),
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.grayColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(AppImages.icEmail),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Form(
                          key: _formKey1,
                          child: TextFormField(
                            key: const Key('email'),
                            cursorColor: AppColors.blackColor.withOpacity(0.6),
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[A-Za-z0-9@_.]")),
                            ],
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  setState(() {
                                    isEmailValidated = true;
                                  });
                                } else {
                                  isEmailValidated = false;
                                }
                              } else {
                                isEmailValidated = false;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _formKey1.currentState!.validate();
                                email = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'someone@gmail.com',
                              label: Text(
                                'Email',
                                style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.itemTitleGrey),
                              ),
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      if (isEmailValidated != null)
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.check_circle_outline_rounded,
                              color: isEmailValidated!
                                  ? AppColors.successGreenColor
                                  : AppColors.errorRedColor,
                            ))
                    ],
                  ),
                  const SizedBox(height: kOnBoardingMarginBetweenFields / 5),
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.grayColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(AppImages.icPhone),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Form(
                          key: _formKey2,
                          child: TextFormField(
                            key: const Key('phone'),
                            cursorColor: AppColors.blackColor.withOpacity(0.6),
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            validator: (value) {
                              if (value!.length == 10 &&
                                  value[0] == "0" &&
                                  value[1] == "7") {
                                setState(() {
                                  isMobileValidated = true;
                                });
                              } else {
                                setState(() {
                                  isMobileValidated = false;
                                });
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _formKey2.currentState!.validate();
                                mobile = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '07XXXXXXXX',
                              counterText: '',
                              label: Text(
                                'Phone',
                                style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.itemTitleGrey),
                              ),
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      if (isMobileValidated != null)
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.check_circle_outline_rounded,
                              color: isMobileValidated!
                                  ? AppColors.successGreenColor
                                  : AppColors.errorRedColor,
                            ))
                    ],
                  ),
                  const SizedBox(height: kOnBoardingMarginBetweenFields / 5),
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.grayColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.location_on_outlined),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Form(
                          key: _formKey3,
                          child: TextFormField(
                            key: const Key('address'),
                            cursorColor: AppColors.blackColor.withOpacity(0.6),
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            validator: (value) {
                              if (value != '' && value != null) {
                                setState(() {
                                  isAddressValidated = true;
                                });
                              } else {
                                setState(() {
                                  isAddressValidated = false;
                                });
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _formKey3.currentState!.validate();
                                address = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '201 Shanti Villa, Kandy',
                              counterText: '',
                              label: Text(
                                'Address',
                                style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.itemTitleGrey),
                              ),
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      if (isAddressValidated != null)
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.check_circle_outline_rounded,
                              color: isAddressValidated!
                                  ? AppColors.successGreenColor
                                  : AppColors.errorRedColor,
                            ))
                    ],
                  ),
                  const SizedBox(height: kOnBoardingMarginBetweenFields),
                  Text(
                    'Payment Method',
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor),
                  ),
                  const SizedBox(height: kOnBoardingMarginBetweenFields / 2),
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.grayColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.credit_card),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'People\'s Bank',
                              style: GoogleFonts.raleway(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor),
                            ),
                            const SizedBox(height: 0),
                            Text(
                              'XXXX XXXX 0696 4629',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.itemTitleGrey),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 2.w),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_circle_outline_rounded,
                          color: AppColors.successGreenColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.1),
                        offset: const Offset(0, 0),
                        blurRadius: 20)
                  ],
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kLeftRightMarginOnBoarding),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: kBottomMargin),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text(
                            'Subtotal',
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor),
                          ),
                          const Spacer(),
                          Text(
                            'LKR ${AppUtils.currencyFormater(widget.subTotal)}',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Text(
                            'Delivery',
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor),
                          ),
                          const Spacer(),
                          Text(
                            'LKR ${AppUtils.currencyFormater(widget.deliveryFee)}',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      DottedLine(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceAround,
                        lineLength: double.infinity,
                        lineThickness: 2.0,
                        dashLength: 8.0,
                        dashGradient: const [Colors.red, Colors.blue],
                        dashRadius: 0.0,
                        dashGapLength: 8.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Text(
                            'Total Cost',
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor),
                          ),
                          const Spacer(),
                          Text(
                            'LKR ${AppUtils.currencyFormater(widget.total)}',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      MainButton(
                        title: 'Place Order',
                        onPressed: () {
                          _formKey1.currentState!.validate();
                          _formKey2.currentState!.validate();
                          _formKey3.currentState!.validate();

                          if (isEmailValidated! &&
                              isMobileValidated! &&
                              isAddressValidated!) {
                            BlocProvider.of<MainBloc>(context)
                                .add(ClearCartItemsEvent());

                            CustomDialogBox.show(
                              context,
                              image: AppImages.successDialog,
                              title: 'Success',
                              message: 'Successfully placed your order',
                              isTwoButton: false,
                              positiveButtonText: 'Okay',
                              positiveButtonTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                    (route) => false);
                              },
                            );
                          } else {
                            CustomDialogBox.show(
                              context,
                              image: AppImages.failedDialog,
                              title: 'Oops !',
                              message:
                                  'Please fill all of the contact details !',
                              isTwoButton: false,
                              positiveButtonText: 'Try Again',
                              positiveButtonTap: () {
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
