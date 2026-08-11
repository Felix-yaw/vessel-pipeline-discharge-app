import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// A single navigation item with optional badge and active highlighting.
class NavItem extends StatelessWidget {
  final String label;
  final String? assetPath;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;
  final int badgeCount;

  const NavItem({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.assetPath,
    this.icon,
    this.badgeCount = 0,
  }) : assert(assetPath != null || icon != null,
            'Provide either assetPath or icon');

  @override
  Widget build(BuildContext context) {
    final Color contentColor =
        selected ? AppColors.backgroundColor : AppColors.greyColor;

    return SizedBox(
      width: getProportionateScreenWidth(72),
      height: getProportionateHeight(60),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(getProportionateHeight(10)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(8),
            getProportionateHeight(8),
            getProportionateScreenWidth(8),
            getProportionateHeight(8),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(getProportionateHeight(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: getProportionateHeight(24),
                  height: getProportionateHeight(24),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Center(
                        child: assetPath != null
                            ? SvgPicture.asset(
                                assetPath!,
                                width: getProportionateHeight(24),
                                height: getProportionateHeight(24),
                                colorFilter: ColorFilter.mode(
                                  contentColor,
                                  BlendMode.srcIn,
                                ),
                              )
                            : Icon(
                                icon,
                                color: contentColor,
                                size: getProportionateHeight(24),
                              ),
                      ),
                      if (badgeCount > 0)
                        Positioned(
                          right: -getProportionateHeight(2),
                          top: -getProportionateHeight(2),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateHeight(5),
                              vertical: getProportionateHeight(2),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF12B76A),
                              borderRadius: BorderRadius.circular(
                                getProportionateHeight(8),
                              ),
                            ),
                            child: Text(
                              '$badgeCount',
                              style: TextStyle(
                                color: AppColors.backgroundColor,
                                fontSize: getProportionateHeight(9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateHeight(4)),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: getProportionateHeight(10),
                    color: contentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}