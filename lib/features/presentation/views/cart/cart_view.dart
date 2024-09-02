import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/features/presentation/widgets/app_bar.dart';
import 'package:snickz/features/presentation/widgets/cart_list_item.dart';
import 'package:snickz/utils/app_constants.dart';
import 'package:snickz/utils/app_utils.dart';

import '../../../../utils/app_colors.dart';
import '../../../domain/entities/item_entity.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

List<ItemEntity> cartItems = [];
double subTotal = 0;
double total = 0;
double deliveryFee = 100;

class _CartViewState extends State<CartView>
    with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);

  @override
  void initState() {
    setState(() {
      cartItems = [
        ItemEntity(title: 'Nike AirForce', price: 3900, qty: 2),
        ItemEntity(title: 'Nike AirForce', price: 2100, qty: 1),
        ItemEntity(title: 'Nike AirForce', price: 4300, qty: 1),
        ItemEntity(title: 'Nike AirForce', price: 3400, qty: 1),
        ItemEntity(title: 'Nike AirForce', price: 6000, qty: 2),
        ItemEntity(title: 'Nike AirForce', price: 8700, qty: 3),
      ];
      calculateBill();
    });
    super.initState();
  }

  void calculateBill() {
    setState(() {
      subTotal =
          cartItems.fold(0, (sum, item) => sum + (item.price! * item.qty!));
      total = subTotal + deliveryFee;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Cart',
        leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded),
        leadingOnTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                kLeftRightMarginOnBoarding,
                kOnBoardingMarginBetweenFields,
                kLeftRightMarginOnBoarding,
                kBottomMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${cartItems.length} Items',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  height: 52.h,
                  child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: index == 0 ? 10 : 0,
                              bottom: index == cartItems.length - 1 ? 20 : 0),
                          child: CartListItem(
                            key: GlobalKey(debugLabel: '$index'),
                            title: cartItems[index].title!,
                            qty: cartItems[index].qty,
                            price: cartItems[index].price,
                            onDelete: () {
                              setState(() {
                                cartItems.remove(cartItems[index]);
                                calculateBill();
                              });
                            },
                            onQtyAdd: () {
                              setState(() {
                                cartItems[index].qty++;
                                calculateBill();
                              });
                            },
                            onQtyMin: () {
                              setState(() {
                                if (cartItems[index].qty != 0) {
                                  cartItems[index].qty--;
                                  calculateBill();
                                }
                              });
                            },
                          ),
                        );
                      }),
                )
              ],
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
                            'LKR ${AppUtils.currencyFormater(subTotal)}',
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
                            'LKR ${AppUtils.currencyFormater(deliveryFee)}',
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
                            'LKR ${AppUtils.currencyFormater(total)}',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      ElevatedButton(
                        style: ButtonStyle(
                          surfaceTintColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                          elevation: const MaterialStatePropertyAll(0),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 16)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Checkout',
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
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
