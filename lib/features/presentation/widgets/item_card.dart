import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:snickz/features/domain/entities/item_entity.dart';
import 'package:snickz/features/presentation/views/overview/item_details_view.dart';
import 'package:snickz/utils/app_utils.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';

class ItemCard extends StatefulWidget {
  final int? index;
  final ItemEntity itemEntity;

  const ItemCard({super.key, this.index, required this.itemEntity});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grayColor.withOpacity(0.4),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                log('Request to add to Cart');
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              log('Tapped White area - ${widget.index}');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemDetailsView(itemEntity: widget.itemEntity,)),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 3.h),
                SizedBox(
                  height: 12.h,
                  child: Image.asset(
                    AppImages.itemShoe1,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 45.w,
                      ),
                      Text(
                        widget.itemEntity.category ?? '',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.raleway(
                            fontSize: 12,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.itemEntity.title ?? '',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.raleway(
                            fontSize: 18,
                            color: AppColors.textTitleColor,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'LKR ${AppUtils.currencyFormater(widget.itemEntity.price!) ?? '0.00'}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
