import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

const List<Color> kBackgroundGradient = [
  Color(0xFF31478A),
  Color(0xFF3A54A2),
  Color(0xFF6882CC),
];

/// A full-width rounded button with a linear gradient background.
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool showCheckIcon;
  final bool showArrowIcon;
  final bool showTrailingArrow;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.showCheckIcon = false,
    this.showArrowIcon = false,
    this.showTrailingArrow = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor = textColor ?? AppColors.backgroundColor;
    return SizedBox(
      width: width ?? getProportionateScreenWidth(304),
      height: height ?? getProportionateHeight(56),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: backgroundColor == null
                  ? const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: kBackgroundGradient,
                    )
                  : null,
              borderRadius:
                  BorderRadius.circular(getProportionateHeight(16)),
              border: borderColor != null
                  ? Border.all(color: borderColor!)
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showArrowIcon) ...[
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: contentColor,
                        size: getProportionateHeight(24),
                      ),
                      SizedBox(width: getProportionateScreenWidth(8)),
                    ],
                    Text(
                      label,
                      style: TextStyle(
                        color: contentColor,
                        fontSize: getProportionateHeight(16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (showTrailingArrow) ...[
                      SizedBox(width: getProportionateScreenWidth(8)),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: contentColor,
                        size: getProportionateHeight(24),
                      ),
                    ],
                    if (showCheckIcon) ...[
                      SizedBox(width: getProportionateScreenWidth(8)),
                      SvgPicture.asset(
                        'assets/images/check.svg',
                        width: getProportionateHeight(24),
                        height: getProportionateHeight(24),
                      ),
                    ],
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