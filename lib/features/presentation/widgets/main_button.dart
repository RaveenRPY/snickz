import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';

class MainButton extends StatefulWidget {
  final String title;
  final Color? bgColor;
  final Color? titleColor;
  final Function? onPressed;
  final Icon? prefixIcon;

  const MainButton({super.key, required this.title, this.bgColor, this.titleColor, this.onPressed, this.prefixIcon});

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
        backgroundColor: MaterialStateProperty.all(widget.bgColor ?? AppColors.primaryColor),
        elevation: const MaterialStatePropertyAll(0),
        padding:
            const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
      onPressed: () {
        widget.onPressed!();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.raleway(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: widget.titleColor ?? AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
