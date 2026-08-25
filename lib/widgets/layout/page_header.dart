import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/colors.dart';
import 'package:vessel_pipeline_discharge_app/core/constants/size_config.dart';

/// Reusable branded header used across the operation screens.
///
/// Mirrors the header block from the existing screens: a rounded container
/// with a background SVG, an optional Back button, a [title] and an optional
/// vessel [name] / [code] pair.
class PageHeader extends StatelessWidget {
  final String title;
  final String? name;
  final String? code;
  final bool showBack;

  const PageHeader({
    super.key,
    required this.title,
    this.name,
    this.code,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(336),
      height: getProportionateHeight(134),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateHeight(32)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/images/background2.svg',
            fit: BoxFit.cover,
          ),
          if (showBack)
            Positioned(
              left: getProportionateScreenWidth(16),
              top: getProportionateHeight(16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.primaryColor,
                      size: getProportionateHeight(20),
                    ),
                    SizedBox(width: getProportionateScreenWidth(8)),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: getProportionateHeight(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            left: getProportionateScreenWidth(16),
            right: getProportionateScreenWidth(16),
            top: getProportionateHeight(62),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: getProportionateHeight(20),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (name != null) ...[
                  SizedBox(height: getProportionateHeight(4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: getProportionateHeight(23),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (code != null)
                        Text(
                          code!,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: getProportionateHeight(14),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
