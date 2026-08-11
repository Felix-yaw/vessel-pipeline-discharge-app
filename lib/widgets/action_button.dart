import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Primary action button with a checkmark icon on the right.
class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(304),
      height: getProportionateHeight(56),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(getProportionateHeight(16)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(getProportionateHeight(16)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontSize: getProportionateHeight(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/check.svg',
                  width: getProportionateHeight(24),
                  height: getProportionateHeight(24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}