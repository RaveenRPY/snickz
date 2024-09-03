import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class CartListItem extends StatefulWidget {
  final String title;
  final double? price;
  final String? image;
  final Function? onDelete;
  final Function? onQtyAdd;
  final Function? onQtyMin;
  int? qty;

  CartListItem(
      {super.key,
      required this.title,
      this.price,
      this.qty = 1,
      this.image,
      this.onDelete,
      this.onQtyAdd,
      this.onQtyMin});

  @override
  State<CartListItem> createState() => _CartListItemState();
}

int qty = 1;

class _CartListItemState extends State<CartListItem> {
  @override
  void initState() {
    setState(() {
      qty = widget.qty ?? 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                widget.onDelete!();
              },
              backgroundColor: AppColors.errorRedColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(16),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                widget.onDelete!();
              },
              backgroundColor: AppColors.errorRedColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(16),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.05),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    color: AppColors.lightAshColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(widget.image ?? AppImages.itemShoe1),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'LKR ${widget.price}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: IconButton(
                        iconSize: 15,
                        onPressed: () {
                          widget.onQtyAdd!();
                          setState(() {
                            qty++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors.greyWhiteColor),
                        ),
                      ),
                    ),
                    Text(
                      qty.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: IconButton(
                        iconSize: 15,
                        onPressed: () {
                          setState(() {
                            if (qty != 0) {
                              qty--;
                            }
                          });
                          widget.onQtyMin!();
                        },
                        icon: const Icon(
                          Icons.remove,
                        ),
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors.greyWhiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
